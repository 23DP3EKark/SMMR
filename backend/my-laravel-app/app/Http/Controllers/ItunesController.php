<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class ItunesController extends Controller
{
    public function search(Request $request): JsonResponse
    {
        if (! Auth::check()) {
            return response()->json([
                'message' => 'Unauthenticated.',
            ], 401);
        }

        $validated = $request->validate([
            'term' => ['nullable', 'string', 'max:100'],
            'media' => ['required', Rule::in(['music', 'movie'])],
            'genre' => ['nullable', 'string', 'max:50'],
            'year_from' => ['nullable', 'integer', 'min:1900', 'max:2100'],
            'year_to' => ['nullable', 'integer', 'min:1900', 'max:2100'],
            'sort_by' => ['nullable', Rule::in(['title', 'creator', 'year'])],
            'sort_direction' => ['nullable', Rule::in(['asc', 'desc'])],
            'limit' => ['nullable', 'integer', 'min:1', 'max:25'],
        ]);

        $media = $validated['media'];
        $results = $media === 'music'
            ? $this->searchSongs($validated)
            : $this->searchMovies($validated);

        return response()->json([
            'result_count' => $results->count(),
            'results' => $results,
        ]);
    }

    private function searchSongs(array $validated)
    {
        $term = trim($validated['term'] ?? '');
        $sortColumns = [
            'title' => 'songs.title',
            'creator' => 'songs.artist',
            'year' => 'songs.release_year',
        ];
        $sortBy = $validated['sort_by'] ?? 'title';
        $sortDirection = $validated['sort_direction'] ?? 'asc';

        return DB::table('songs')
            ->leftJoin('song_categories', 'songs.id', '=', 'song_categories.song_id')
            ->leftJoin('music_categories', 'song_categories.category_id', '=', 'music_categories.id')
            ->select([
                'songs.id',
                DB::raw("'music' as media"),
                'songs.title',
                'songs.artist',
                DB::raw('NULL as collection'),
                'songs.cover_image_url as artwork',
                'songs.preview_url',
                DB::raw('NULL as store_url'),
                'songs.release_year as release_date',
                DB::raw("GROUP_CONCAT(music_categories.name ORDER BY music_categories.name SEPARATOR ', ') as genre"),
                DB::raw('NULL as price'),
                DB::raw("'' as currency"),
                DB::raw("'' as description"),
            ])
            ->when($term !== '', function ($query) use ($term) {
                $searchTerm = '%' . $term . '%';

                $query->where(function ($query) use ($searchTerm) {
                    $query->where('songs.title', 'like', $searchTerm)
                        ->orWhere('songs.artist', 'like', $searchTerm);
                });
            })
            ->when($validated['genre'] ?? null, function ($query, string $genre) {
                $query->whereExists(function ($subquery) use ($genre) {
                    $subquery->select(DB::raw(1))
                        ->from('song_categories as genre_filter')
                        ->join('music_categories as selected_genre', 'genre_filter.category_id', '=', 'selected_genre.id')
                        ->whereColumn('genre_filter.song_id', 'songs.id')
                        ->where('selected_genre.name', $genre);
                });
            })
            ->when($validated['year_from'] ?? null, function ($query, int $yearFrom) {
                $query->where('songs.release_year', '>=', $yearFrom);
            })
            ->when($validated['year_to'] ?? null, function ($query, int $yearTo) {
                $query->where('songs.release_year', '<=', $yearTo);
            })
            ->groupBy('songs.id', 'songs.title', 'songs.artist', 'songs.cover_image_url', 'songs.preview_url', 'songs.release_year')
            ->orderBy($sortColumns[$sortBy], $sortDirection)
            ->limit($validated['limit'] ?? 12)
            ->get();
    }

    private function searchMovies(array $validated)
    {
        $term = trim($validated['term'] ?? '');
        $sortColumns = [
            'title' => 'movies.title',
            'creator' => 'movies.studio',
            'year' => 'movies.release_year',
        ];
        $sortBy = $validated['sort_by'] ?? 'title';
        $sortDirection = $validated['sort_direction'] ?? 'asc';

        return DB::table('movies')
            ->leftJoin('movie_category_map', 'movies.id', '=', 'movie_category_map.movie_id')
            ->leftJoin('movie_categories', 'movie_category_map.category_id', '=', 'movie_categories.id')
            ->select([
                'movies.id',
                DB::raw("'movie' as media"),
                'movies.title',
                'movies.studio as artist',
                DB::raw('NULL as collection'),
                'movies.cover_image_url as artwork',
                DB::raw('NULL as preview_url'),
                DB::raw('NULL as store_url'),
                'movies.release_year as release_date',
                DB::raw("GROUP_CONCAT(movie_categories.name ORDER BY movie_categories.name SEPARATOR ', ') as genre"),
                DB::raw('NULL as price'),
                DB::raw("'' as currency"),
                DB::raw("'' as description"),
            ])
            ->when($term !== '', function ($query) use ($term) {
                $searchTerm = '%' . $term . '%';

                $query->where(function ($query) use ($searchTerm) {
                    $query->where('movies.title', 'like', $searchTerm)
                        ->orWhere('movies.studio', 'like', $searchTerm);
                });
            })
            ->when($validated['genre'] ?? null, function ($query, string $genre) {
                $query->whereExists(function ($subquery) use ($genre) {
                    $subquery->select(DB::raw(1))
                        ->from('movie_category_map as genre_filter')
                        ->join('movie_categories as selected_genre', 'genre_filter.category_id', '=', 'selected_genre.id')
                        ->whereColumn('genre_filter.movie_id', 'movies.id')
                        ->where('selected_genre.name', $genre);
                });
            })
            ->when($validated['year_from'] ?? null, function ($query, int $yearFrom) {
                $query->where('movies.release_year', '>=', $yearFrom);
            })
            ->when($validated['year_to'] ?? null, function ($query, int $yearTo) {
                $query->where('movies.release_year', '<=', $yearTo);
            })
            ->groupBy('movies.id', 'movies.title', 'movies.studio', 'movies.cover_image_url', 'movies.release_year')
            ->orderBy($sortColumns[$sortBy], $sortDirection)
            ->limit($validated['limit'] ?? 12)
            ->get();
    }
}
