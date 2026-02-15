# Todos API

# Getting Started

## Start the Server

``` bash
rails s
```

![Server Start](screenshots/1.png)

## Base URL

``` bash
BASE=http://localhost:3000
```

------------------------------------------------------------------------

# Authentication

## Signup (παίρνεις token)

``` bash
http POST $BASE/signup   user:='{"email":"me@example.com","password":"Password1!","password_confirmation":"Password1!"}'
```

![Signup](screenshots/2.png)

------------------------------------------------------------------------

## Login (παίρνεις token)

``` bash
http POST $BASE/auth/login   user:='{"email":"me@example.com","password":"Password1!"}'
```

![Login](screenshots/3.png)

------------------------------------------------------------------------

## Logout (με Bearer token)

``` bash
http GET $BASE/auth/logout   Authorization:"Bearer $TOKEN"
```

![Logout](screenshots/4.png)

------------------------------------------------------------------------

## Απόδειξη ότι έγινε revoke

(Ξαναχτυπάμε το ίδιο request)

![Revoke Proof](screenshots/5.png)

------------------------------------------------------------------------

# Todos Endpoints

## Create Todo

``` bash
http POST $BASE/todos   title="My first todo"   created_by="Panos"
```

![Create Todo](screenshots/6.png)

------------------------------------------------------------------------

## List Todos

``` bash
http GET $BASE/todos
```

![List Todos](screenshots/7.png)

------------------------------------------------------------------------

## Get Todo by ID

``` bash
http GET $BASE/todos/1
```

![Get Todo](screenshots/8.png)

------------------------------------------------------------------------

## Update Todo

``` bash
http PUT $BASE/todos/1   title="Updated title"
```

![Update Todo](screenshots/9.png)

------------------------------------------------------------------------

## Delete Todo

``` bash
http DELETE $BASE/todos/1
```

![Delete Todo](screenshots/10.png)

------------------------------------------------------------------------

# Items Endpoints

(Δημιουργούμε ξανά ένα todo γιατί το προηγούμενο το αφαιρέσαμε μόλις)

``` bash
http POST $BASE/todos   title="Todo with items"   created_by="Panos"

TODO_ID=2
```

------------------------------------------------------------------------

## Create Item

``` bash
http POST $BASE/todos/$TODO_ID/items   name="Buy milk"   done:=false
```

![Create Item](screenshots/11.png)

------------------------------------------------------------------------

## Get Item

``` bash
http GET $BASE/todos/$TODO_ID/items/1
```

![Get Item](screenshots/12.png)

------------------------------------------------------------------------

## Update Item

``` bash
http PUT $BASE/todos/$TODO_ID/items/1   done:=true
```

![Update Item](screenshots/13.png)

------------------------------------------------------------------------

## Delete Item

``` bash
http DELETE $BASE/todos/$TODO_ID/items/1
```

![Delete Item](screenshots/14.png)

------------------------------------------------------------------------

# Swagger Documentation

Το API περιλαμβάνει πλήρως παραγόμενο αρχείο προδιαγραφής OpenAPI 3.0 μέσω του **rswag**.
Για τη δημιουργία του αρχείου OpenAPI:

``` bash
bundle exec rake rswag:specs:swaggerize
```

Προσβάσιμο μέσω του browser στο:

http://localhost:3000/api-docs

