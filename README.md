# Remote Assignment

To start your Phoenix server:

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.setup`
  * This will also create 100 users to the DB with 0 points
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Dependencies

* PostgreSQL.

## About the application:

* Starts a GenServer which:
  * Randomly sets points (0-100) for all the users in the database every minute
  * Maintains a `MAX_NUMBER` and `last queried timestamp` in the Process memory. $MAX_NUMBER is refreshed every minute.

* Exposes an endpoint to Query a maximum of 2 users with points > MAX_NUMBER.
  * The API currently returns the first two users who match the criteria.
