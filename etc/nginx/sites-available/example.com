server {
    listen 443 ssl http2;

    server_name example.com;

    root /var/www/example.com;
    index index.html;
    location / {
        try_files $uri $uri/ =404;
    }

    add_header X-Frame-Options "SAMEORIGIN";
    if ($request_method !~ ^(GET|HEAD)$ ) {
        return 405;
    }
}
