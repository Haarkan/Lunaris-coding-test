# LunarisApi

## To run the server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup``
- Run tests with `mix test`, they all should succeed
- Start Phoenix endpoint with `mix phx.server`

## Configuration

You can easly customize the reward percentage in `lunaris_api/config/config.exs` by modifying the property `point_percentage`

## HTTP Queries

- To create a customer :

```
curl --location --request POST 'http://localhost:4000/api/customer' \
--header 'Content-Type: application/json' \
--data-raw '{
  "email": "test@email.com",
  "phone": "000"
}'
```

- To create an order :

```
curl --location --request POST 'http://localhost:4000/api/order' \
--header 'Content-Type: application/json' \
--data-raw '{
  "email": "test@email.com",
  "amount": 1000.0,
  "currency" : "jpy"
}'
```

- To create an order :

```
curl --location --request POST 'http://localhost:4000/api/order' \
--header 'Content-Type: application/json' \
--data-raw '{
  "email": "test@email.fr",
  "amount": 1000.0,
  "currency" : "jpy"
}'
```

- To get a customer's balance :
  `curl --location -g --request GET 'localhost:4000/api/customer/{YOUR_EMAIL}/balance'`

- To add points to a customer :

```
curl --location --request PUT 'http://localhost:4000/api/customer/balance' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "test@email.com",
    "points": 10,
    "action": "add"
}'
```

- To subtract points to a customer :

```
curl --location --request PUT 'http://localhost:4000/api/customer/balance' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "test@email.com",
    "points": 10,
    "action": "subtract"
}'
```

## Things that could (or should) be improved

- Input validation on email and phone number
- More in deep @docs
- Customer authentication on order creation
- Store the percentage in database for friendlier configuration (would require admin auth)
- Better error handling and HTTP status
