# README

## What is Shorten URL Service?
A shorten url service is a tool that allows you to create short and easy-to-remember links from long and complex URLs. Short links are useful for sharing on social media, email, SMS, and other platforms where space and readability are limited. Short links can also help you track the performance and analytics of your links, such as the number of clicks, the location of the visitors, the device type, etc.

## Versions
- Rails: 7.1.3
- Ruby: 3.1.2

## How to use Shorten URL Service?
### Use Web UI
#### Step 1: register a user
```command
  https://url-shorten.thanhtuan.tech/users/sign_up
```

#### Step 2: login to the system with your username and password
```command
  https://url-shorten.thanhtuan.tech/users/sign_in
```

#### Step 3: visit url list
```command
  https://url-shorten.thanhtuan.tech/urls
```
- To shorten a URL
- To view all URLs
- To search for a specific URL
- To remove some unused URLs

### Use API
#### Step 1: register a user
```command
  curl -i --location --request POST 'localhost:3000/api/v1/registrations' \
  --header 'Content-Type: application/json' \
  --data-raw '{ "user": { "email": "admin+1@shorten-url.com", "password": "skj**hJJJ666" }}'
```

#### Step 2: login to the system with your username and password
```command
  curl -i --location --request POST 'localhost:3000/api/v1/sessions' \
  --header 'Content-Type: application/json' \
  --data-raw '{ "email": "admin+1@shorten-url.com", "password": "skj**hJJJ666" }'
```

#### Step 3: shorten a URL
```command
  curl -i --location --request POST 'localhost:3000/api/v1/urls/shorten' \
  --header 'Content-Type: application/json' \
  --header 'X-User-Email: admin+1@shorten-url.com' \
  --header 'X-User-Token: 4A6rty-5yyMVaYdWonuW' \
  --data-raw '{ "original": "http://abc.com" }'
```

#### Step 4: get original URL
```command
  curl -i --location --request GET 'localhost:3000/api/v1/urls/original_url' \
  --header 'Content-Type: application/json' \
  --header 'X-User-Email: admin@shorten-url.com' \
  --header 'X-User-Token: 4A6rty-5yyMVaYdWonuW' \
  --data-raw '{ "short": "4euibv" }'
```

#### Step 5: List URL
```command
  curl -i --location --request GET 'localhost:3000/api/v1/urls' \
  --header 'Content-Type: application/json' \
  --header 'X-User-Email: admin+1@shorten-url.com' \
  --header 'X-User-Token: 4A6rty-5yyMVaYdWonuW'
```