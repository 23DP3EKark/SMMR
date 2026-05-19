<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->validateCsrfTokens(except: [
            'login',
            'register',
            'logout',
            'password',
            'account',
            'todo-items',
            'todo-items/*',
            'itunes/search',
            'travel/destinations',
            'api/login',
            'api/register',
            'api/logout',
            'api/password',
            'api/account',
            'api/todo-items',
            'api/todo-items/*',
            'api/itunes/search',
            'api/travel/destinations',
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        //
    })->create();
