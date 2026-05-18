<?php

$frontendUrl = env('FRONTEND_URL');

return [
    'paths' => ['*'],

    'allowed_methods' => ['*'],

    'allowed_origins' => array_values(array_filter([
        $frontendUrl,
        env('VERCEL_URL') ? 'https://'.env('VERCEL_URL') : null,
        'http://localhost:5173',
    ])),

    'allowed_origins_patterns' => [
        '#^https://.*\.vercel\.app$#',
    ],

    'allowed_headers' => ['*'],

    'exposed_headers' => [],

    'max_age' => 0,

    'supports_credentials' => true,
];
