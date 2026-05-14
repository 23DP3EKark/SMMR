<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ItunesController;
use App\Http\Controllers\TodoController;
use App\Http\Controllers\TravelController;
use Illuminate\Support\Facades\Route;

Route::post('/login', [AuthController::class, 'login']);
Route::get('/me', [AuthController::class, 'me']);
Route::post('/logout', [AuthController::class, 'logout']);
Route::put('/password', [AuthController::class, 'changePassword']);
Route::delete('/account', [AuthController::class, 'deleteAccount']);
Route::get('/todo-items', [TodoController::class, 'index']);
Route::post('/todo-items', [TodoController::class, 'store']);
Route::put('/todo-items/{id}', [TodoController::class, 'update']);
Route::delete('/todo-items/{id}', [TodoController::class, 'destroy']);
Route::get('/itunes/search', [ItunesController::class, 'search']);
Route::get('/travel/destinations', [TravelController::class, 'index']);

Route::get('/{any}', function () {
    return view('app');
})->where('any', '.*');
