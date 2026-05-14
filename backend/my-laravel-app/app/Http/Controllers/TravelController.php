<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class TravelController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        if (! Auth::check()) {
            return response()->json([
                'message' => 'Unauthenticated.',
            ], 401);
        }

        $validated = $request->validate([
            'term' => ['nullable', 'string', 'max:100'],
            'attraction' => ['nullable', 'string', 'max:100'],
            'max_price' => ['nullable', 'numeric', 'min:0'],
            'sort_by' => ['nullable', Rule::in(['price', 'name'])],
            'sort_direction' => ['nullable', Rule::in(['asc', 'desc'])],
        ]);

        $term = trim($validated['term'] ?? '');
        $attraction = trim($validated['attraction'] ?? '');
        $sortColumns = [
            'price' => 'destinations.weekly_cost_estimate',
            'name' => 'destinations.name',
        ];
        $sortBy = $validated['sort_by'] ?? 'price';
        $sortDirection = $validated['sort_direction'] ?? 'asc';

        $destinations = DB::table('destinations')
            ->leftJoin('attractions', 'destinations.id', '=', 'attractions.destination_id')
            ->select([
                'destinations.id',
                'destinations.name',
                'destinations.description',
                'destinations.weekly_cost_estimate',
                DB::raw("GROUP_CONCAT(attractions.name ORDER BY attractions.name SEPARATOR ', ') as attractions"),
            ])
            ->when($term !== '', function ($query) use ($term) {
                $searchTerm = '%' . $term . '%';

                $query->where(function ($query) use ($searchTerm) {
                    $query->where('destinations.name', 'like', $searchTerm)
                        ->orWhere('destinations.description', 'like', $searchTerm);
                });
            })
            ->when($attraction !== '', function ($query) use ($attraction) {
                $searchTerm = '%' . $attraction . '%';

                $query->whereExists(function ($subquery) use ($searchTerm) {
                    $subquery->select(DB::raw(1))
                        ->from('attractions as attraction_filter')
                        ->whereColumn('attraction_filter.destination_id', 'destinations.id')
                        ->where('attraction_filter.name', 'like', $searchTerm);
                });
            })
            ->when($validated['max_price'] ?? null, function ($query, float $maxPrice) {
                $query->where('destinations.weekly_cost_estimate', '<=', $maxPrice);
            })
            ->groupBy('destinations.id', 'destinations.name', 'destinations.description', 'destinations.weekly_cost_estimate')
            ->orderBy($sortColumns[$sortBy], $sortDirection)
            ->get()
            ->map(function ($destination) {
                return [
                    'id' => $destination->id,
                    'name' => $destination->name,
                    'description' => $destination->description,
                    'weekly_cost_estimate' => (float) $destination->weekly_cost_estimate,
                    'attractions' => $destination->attractions
                        ? explode(', ', $destination->attractions)
                        : [],
                ];
            });

        return response()->json([
            'destinations' => $destinations,
        ]);
    }
}
