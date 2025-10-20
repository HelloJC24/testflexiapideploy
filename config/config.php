<?php

return [
   'database' => [
        'host' => 'bngcbe-bngc-bpjv5k',
        'port' => 3306,
        'database' => 'bngc_db',
        'username' => 'root',
        'password' => 'bdaktwmfhpkauycf',
        'charset' => 'utf8mb4'
    ],
    'jwt' => [
        'secret' => 'd388570774df11c0d6ef282b39625b632f94badb918eb5934a9ae934c451dce8',
        'algorithm' => 'HS256',
        'expiration' => 3600
    ],
    'encryption' => [
        'key' => 'b7d0ac5f6a32123e817568fcb7114254f9d208adf53a938d752750f719f48f4e'
    ],
    'api' => [
        'secret_key' => '024828055dd875a34c6bc831bece3d0b',
        'base_url' => 'http://localhost:8000/api',
        'version' => 'v1'
    ],
    'rate_limit' => [
        'enabled' => true,
        'requests_per_minute' => 60,
        'storage' => 'file'
    ],
    'cors' => [
        'origins' => ['*'],
        'methods' => ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
        'headers' => ['Content-Type', 'Authorization', 'X-API-Key']
    ]
];