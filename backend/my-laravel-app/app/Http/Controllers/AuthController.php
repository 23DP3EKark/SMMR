<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function register(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'first_name' => ['required', 'string', 'min:2', 'max:255'],
            'last_name' => ['required', 'string', 'min:2', 'max:255'],
            'email' => ['required', 'email', 'max:255', 'unique:users,email'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
            'terms' => ['accepted'],
        ]);

        $user = User::create([
            'first_name' => $validated['first_name'],
            'last_name' => $validated['last_name'],
            'email' => $validated['email'],
            'password_hash' => $validated['password'],
        ]);

        return response()->json([
            'message' => 'Registration successful.',
            'user' => $user,
        ], 201);
    }

    public function login(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'email' => ['required', 'email'],
            'password' => ['required', 'string'],
            'remember' => ['nullable', 'boolean'],
        ]);

        if (! Auth::attempt([
            'email' => $validated['email'],
            'password' => $validated['password'],
        ], $validated['remember'] ?? false)) {
            return response()->json([
                'message' => 'Invalid email or password.',
            ], 422);
        }

        $request->session()->regenerate();

        return response()->json([
            'message' => 'Login successful.',
            'user' => Auth::user(),
        ]);
    }

    public function me(Request $request): JsonResponse {
        if (! Auth::check()) {
            return response()->json([
                'message' => 'Unauthenticated.',
            ], 401);
        }

        return response()->json([
            'user' => Auth::user(),
        ]);
    }

    public function logout(Request $request): JsonResponse {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return response()->json([
            'message' => 'Logged out.',
        ]);
    }

    public function changePassword(Request $request): JsonResponse {
        if (! Auth::check()) {
            return response()->json([
                'message' => 'Unauthenticated.',
            ], 401);
        }

        $validated = $request->validate([
            'current_password' => ['required', 'string'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
        ]);

        $user = Auth::user();

        if (! Hash::check($validated['current_password'], $user->password_hash)) {
            return response()->json([
                'message' => 'Current password is incorrect.',
            ], 422);
        }

        $user->update([
            'password_hash' => $validated['password'],
        ]);

        return response()->json([
            'message' => 'Password changed successfully.',
        ]);
    }

    public function deleteAccount(Request $request): JsonResponse {
        if (! Auth::check()) {
            return response()->json([
                'message' => 'Unauthenticated.',
            ], 401);
        }

        $request->validate([
            'verification_code' => ['required', 'string'],
            'verification_input' => ['required', 'string', 'same:verification_code'],
        ]);

        $user = Auth::user();

        Auth::logout();

        $user->delete();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return response()->json([
            'message' => 'Account deleted successfully.',
        ]);
    }
}
