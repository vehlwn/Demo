server {
    listen 50.60.70.80:443 ssl http2;

    server_name example.com;
    if ($host !~ ^(example.com)$ ) {
        return 403;
    }

    root /var/www/example.com;
    index index.html;
    location / {
        try_files $uri $uri/ =404;
    }

    add_header X-Frame-Options "SAMEORIGIN";
    if ($request_method !~ ^(GET|HEAD)$ ) {
        return 405;
    }

    # sudo certbot certonly -d "*.example.com" --preferred-challenges=dns --must-staple --manual
    # sudo certbot certonly -d "example.com" --must-staple --standalone --no-eff-email
    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
    # verify chain of trust of OCSP response using Root CA and Intermediate certs
    ssl_trusted_certificate /etc/letsencrypt/live/example.com/chain.pem;

    include /etc/nginx/portscan.conf;
}
