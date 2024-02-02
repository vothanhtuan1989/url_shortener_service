### Login

curl -i --location --request POST 'localhost:3000/api/v1/sessions' \
--header 'Content-Type: application/json' \
--data-raw '{ "email": "admin@shorten-url.com", "password": "skj**hJJJ666" }'

### Shorten
curl -i --location --request POST 'localhost:3000/api/v1/urls/shorten' \
--header 'Content-Type: application/json' \
--header 'X-User-Email: admin@shorten-url.com' \
--header 'X-User-Token: HG49jJ2zdo6jGgKLrzfQ' \
--data-raw '{ "original": "http://abc.com" }'

### Original URL
curl -i --location --request GET 'localhost:3000/api/v1/urls/original_url' \
--header 'Content-Type: application/json' \
--header 'X-User-Email: admin@shorten-url.com' \
--header 'X-User-Token: HG49jJ2zdo6jGgKLrzfQ' \
--data-raw '{ "short": "dquqws" }'

### List URL
curl -i --location --request GET 'localhost:3000/api/v1/urls' \
--header 'Content-Type: application/json' \
--header 'X-User-Email: admin@shorten-url.com' \
--header 'X-User-Token: HG49jJ2zdo6jGgKLrzfQ'