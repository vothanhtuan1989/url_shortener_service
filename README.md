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
- To register a user, please provide YOUR_EMAIL and YOUR_PASSWORD.

```command
  curl -i --location --request POST 'https://url-shorten.thanhtuan.tech/api/v1/registrations' \
  --header 'Content-Type: application/json' \
  --data-raw '{ "user": { "email": "YOUR_EMAIL", "password": "YOUR_PASSWORD" }}'
```

#### Step 2: login to the system with your username and password
- To log in to the system and receive an authentication_token, copy YOUR_EMAIL and YOUR_PASSWORD from step 1.

```command
  curl -i --location --request POST 'https://url-shorten.thanhtuan.tech/api/v1/sessions' \
  --header 'Content-Type: application/json' \
  --data-raw '{ "email": "YOUR_EMAIL", "password": "YOUR_PASSWORD" }'
```

#### Step 3: shorten a URL
- To shorten a URL, copy YOUR_EMAIL and YOUR_AUTHENTICATION_TOKEN from the response you get in step 2, and change YOUR_ORIGINAL_URL to the URL you want.

```command
  curl -i --location --request POST 'https://url-shorten.thanhtuan.tech/api/v1/urls/shorten' \
  --header 'Content-Type: application/json' \
  --header 'X-User-Email: YOUR_EMAIL' \
  --header 'X-User-Token: YOUR_AUTHENTICATION_TOKEN' \
  --data-raw '{ "original": "YOUR_ORIGINAL_URL" }'
```

#### Step 4: get original URL
- To get the original URL, copy YOUR_EMAIL and YOUR_AUTHENTICATION_TOKEN from the response you get in step 2, and change YOUR_SHORT_URL to the short URL you want.

```command
  curl -i --location --request GET 'https://url-shorten.thanhtuan.tech/api/v1/urls/original_url' \
  --header 'Content-Type: application/json' \
  --header 'X-User-Email: YOUR_EMAIL' \
  --header 'X-User-Token: YOUR_AUTHENTICATION_TOKEN' \
  --data-raw '{ "short": "YOUR_SHORT_URL" }'
```

#### Step 5: List URL
- To see all your URLs, copy YOUR_EMAIL and YOUR_AUTHENTICATION_TOKEN from the response in step 2.

```command
  curl -i --location --request GET 'https://url-shorten.thanhtuan.tech/api/v1/urls' \
  --header 'Content-Type: application/json' \
  --header 'X-User-Email: YOUR_EMAIL' \
  --header 'X-User-Token: YOUR_AUTHENTICATION_TOKEN'
```