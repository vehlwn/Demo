upstream backend {
    server localhost:1234;
}

server {
    listen 443 ssl;

    server_name example.com;

    root /var/www/example.com;
    index index.html;
    location / {
        try_files $uri $uri/ =404;
    }


    location /api {
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_read_timeout 5m;
        proxy_connect_timeout 5s;
        proxy_http_version 1.1;
        proxy_pass http://backend;
    }

    add_header X-Frame-Options "SAMEORIGIN";
    if ($request_method !~ ^(GET|HEAD)$ ) {
        return 405;
    }
}
