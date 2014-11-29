+{
    database => [
        'dbi:mysql:myapp', 'root', '', {
            on_connect_do     => ['SET NAMES utf8mb4'],
            mysql_enable_utf8 => 1,
        },
    ],
};
