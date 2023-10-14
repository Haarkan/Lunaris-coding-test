# LunarisApi

## To run the server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup``
- Run tests with `mix test`, they all should succeed
- Start Phoenix endpoint with `mix phx.server`

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
  "email": "a.hou@a.fr",
  "amount": 1000.0,
  "currency" : "jpy"
}'
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
