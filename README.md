curl --location --request POST 'localhost:3000/api/v1/urls/shorten' --header 'Content-Type: application/json' --data-raw '{ "original": "http://abc.com" }' --header 'X-User-Email: admin@shorten-url.com' --header 'X-User-Token: HG49jJ2zdo6jGgKLrzfQ'

docker buildx build --platform linux/amd64 -t vothanhtuan1989/url_shorten_service:02022024.1 --force-rm -f Dockerfile .