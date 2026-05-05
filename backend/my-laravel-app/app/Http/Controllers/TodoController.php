<?php

namespace App\Http\Controllers;

use App\Models\TodoItem;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TodoController extends Controller
{
    public function index(): JsonResponse
    {
        if (! Auth::check()) {
            return response()->json([
                'message' => 'Unauthenticated.',
            ], 401);
        }

        $todoItems = TodoItem::where('user_id', Auth::id())
            ->latest()
            ->get();

        return response()->json([
            'todo_items' => $todoItems,
        ]);
    }

    public function store(Request $request): JsonResponse
    {
        if (! Auth::check()) {
            return response()->json([
                'message' => 'Unauthenticated.',
            ], 401);
        }

        $validated = $request->validate([
            'title' => ['required', 'string', 'max:100'],
            'description' => ['nullable', 'string'],
        ]);

        $todoItem = TodoItem::create([
            'user_id' => Auth::id(),
            'title' => $validated['title'],
            'description' => $validated['description'] ?? null,
        ]);

        return response()->json([
            'message' => 'Todo item created successfully.',
            'todo_item' => $todoItem,
        ], 201);
    }

    public function update(Request $request, int $id): JsonResponse
    {
        if (! Auth::check()) {
            return response()->json([
                'message' => 'Unauthenticated.',
            ], 401);
        }

        $todoItem = TodoItem::where('user_id', Auth::id())->findOrFail($id);

        $validated = $request->validate([
            'title' => ['sometimes', 'required', 'string', 'max:100'],
            'description' => ['nullable', 'string'],
            'is_completed' => ['sometimes', 'boolean'],
        ]);

        $todoItem->update($validated);

        return response()->json([
            'message' => 'Todo item updated successfully.',
            'todo_item' => $todoItem,
        ]);
    }

    public function destroy(int $id): JsonResponse
    {
        if (! Auth::check()) {
            return response()->json([
                'message' => 'Unauthenticated.',
            ], 401);
        }

        $todoItem = TodoItem::where('user_id', Auth::id())->findOrFail($id);
        $todoItem->delete();

        return response()->json([
            'message' => 'Todo item deleted successfully.',
        ]);
    }
}
