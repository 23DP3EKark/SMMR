# Registration And Login Guide

This file explains how your Vue form should connect to Laravel and the database.

It is only a guide. It does not change your app logic.

## 1. What you already have

Your project already includes:

- a `users` table migration in [database/migrations/0001_01_01_000000_create_users_table.php](/c:/Users/User/Desktop/Proj_SMMR/backend/my-laravel-app/database/migrations/0001_01_01_000000_create_users_table.php)
- a `User` model in [app/Models/User.php](/c:/Users/User/Desktop/Proj_SMMR/backend/my-laravel-app/app/Models/User.php)
- Vue pages in [resources/js/components/Register.vue](/c:/Users/User/Desktop/Proj_SMMR/backend/my-laravel-app/resources/js/components/Register.vue) and [resources/js/components/Login.vue](/c:/Users/User/Desktop/Proj_SMMR/backend/my-laravel-app/resources/js/components/Login.vue)

Important: your current `users` table has these fields:

- `id`
- `name`
- `email`
- `password`
- timestamps

It does **not** currently have separate `first_name` and `last_name` columns.

## 2. The full registration flow

The registration flow is normally:

1. User types into the Vue registration form.
2. Vue stores those values in reactive variables.
3. When the form is submitted, Vue sends a `POST` request to Laravel.
4. Laravel route receives the request.
5. Laravel controller validates the data.
6. Laravel controller creates a new `User` record.
7. Laravel saves the user into the `users` table.
8. Laravel returns a success response.

### Files usually involved

- Frontend form:
  [resources/js/components/Register.vue](/c:/Users/User/Desktop/Proj_SMMR/backend/my-laravel-app/resources/js/components/Register.vue)
- Route:
  `routes/api.php` or `routes/web.php`
- Controller:
  usually something like `app/Http/Controllers/AuthController.php`
- Model:
  [app/Models/User.php](/c:/Users/User/Desktop/Proj_SMMR/backend/my-laravel-app/app/Models/User.php)
- Database structure:
  [database/migrations/0001_01_01_000000_create_users_table.php](/c:/Users/User/Desktop/Proj_SMMR/backend/my-laravel-app/database/migrations/0001_01_01_000000_create_users_table.php)

## 3. How the registration form should map to the database

### Option A: Keep the current database structure

If you keep the default Laravel table, your form should end up sending:

- `name`
- `email`
- `password`
- `password_confirmation`

Because your form currently has:

- `first_name`
- `last_name`
- `email`
- `password`
- repeated password

you would combine:

- `name = first_name + " " + last_name`

Then Laravel stores `name`, `email`, and `password`.

### Option B: Use separate first and last name columns

If you want real separate fields in the database, you would need to update:

1. the `users` migration or add a new migration
2. the `User` model `$fillable`
3. the controller that saves the data

Then the database could store:

- `first_name`
- `last_name`
- `email`
- `password`

## 4. What `Register.vue` should do

Inside [Register.vue](/c:/Users/User/Desktop/Proj_SMMR/backend/my-laravel-app/resources/js/components/Register.vue), the form needs three things:

### A. Bind each input to data

Each input should be connected to a Vue variable with `v-model`.

Example idea:

- first name input -> `form.first_name`
- last name input -> `form.last_name`
- email input -> `form.email`
- password input -> `form.password`
- repeat password input -> `form.password_confirmation`

### B. Stop normal HTML form navigation

Right now your form has `action="login"`, which is just regular browser behavior.

For Vue + Laravel API flow, the form usually submits with:

- `@submit.prevent="register"`

That means:

- do not reload the page
- run a Vue method instead

### C. Send a request to Laravel

The `register` method usually sends a `POST` request to something like:

- `/api/register`

The request body would contain the form fields.

## 5. What Laravel should do for registration

Laravel needs a backend endpoint for registration.

Typical structure:

### Route

In `routes/api.php`, create a route for registration.

Example idea:

- `POST /api/register`

This route points to a controller method like:

- `AuthController@register`

### Controller

Inside the controller, registration usually does this:

1. Validate the request.
2. Check required fields.
3. Check email format.
4. Check that email is unique in `users`.
5. Check password confirmation.
6. Create the user.
7. Return JSON response.

### Password storage

Never save passwords as plain text.

Laravel should store a hashed password. In your project, [app/Models/User.php](/c:/Users/User/Desktop/Proj_SMMR/backend/my-laravel-app/app/Models/User.php) already has:

- `'password' => 'hashed'`

That means when you create a user through Eloquent, Laravel can hash it automatically.

## 6. How login works later

Login is similar, but instead of creating a user, Laravel checks whether the user exists and whether the password matches.

The login flow is usually:

1. User enters email and password in Vue.
2. Vue sends a `POST` request to Laravel.
3. Laravel finds the user by email.
4. Laravel checks the password against the hashed password in the database.
5. If correct, Laravel logs the user in or returns a token.
6. Vue stores login state and redirects the user.

## 7. What `Login.vue` should do

Inside [Login.vue](/c:/Users/User/Desktop/Proj_SMMR/backend/my-laravel-app/resources/js/components/Login.vue), the form should:

- bind `email`
- bind `password`
- submit with `@submit.prevent`
- send a `POST` request to Laravel, for example `/api/login`

## 8. What Laravel should do for login

Typical backend pieces:

### Route

In `routes/api.php`:

- `POST /api/login`

### Controller

The login method usually:

1. validates `email` and `password`
2. checks for a matching user
3. verifies the password
4. returns success or error

There are two common ways to handle login:

### Option A: Session login

Laravel creates a session and keeps the user logged in with cookies.

Good for:

- normal web apps
- same-domain frontend/backend setups

### Option B: Token login

Laravel returns a token after login.

Vue stores the token and sends it with future requests.

Good for:

- API-based apps
- frontend/backend separation

## 9. Important note about your current router

In [resources/js/router/index.js](/c:/Users/User/Desktop/Proj_SMMR/backend/my-laravel-app/resources/js/router/index.js), you currently check login with:

- `localStorage.getItem('user')`

That is only frontend state.

It does **not** actually verify the database by itself.

Real verification happens when:

- Laravel checks the email/password against the `users` table
- then Laravel returns success
- then frontend stores session info or token info

## 10. Registration example mapping for your current form

Because your current database has only `name`, `email`, and `password`, your registration save logic would conceptually look like this:

### Data coming from Vue

- `first_name`
- `last_name`
- `email`
- `password`
- `password_confirmation`

### Data saved into `users`

- `name = first_name + " " + last_name`
- `email = email`
- `password = hashed password`

## 11. Login example mapping

### Data coming from Vue

- `email`
- `password`

### Data checked in database

Laravel looks in `users` table for:

- matching `email`

Then it compares:

- entered password
- stored hashed password

If they match, login succeeds.

## 12. The minimum files you will probably create later

When you decide to implement this, the usual minimum is:

1. `routes/api.php`
2. `app/Http/Controllers/AuthController.php`
3. maybe a new migration if you want `first_name` and `last_name`
4. updates to `Register.vue`
5. updates to `Login.vue`

## 13. Suggested order to build it

1. Decide whether the database should use only `name` or separate `first_name` and `last_name`.
2. Make sure `.env` database settings are correct.
3. Run migrations.
4. Create registration route and controller method.
5. Connect `Register.vue` to send a `POST` request.
6. Test that a new row appears in `users`.
7. Create login route and controller method.
8. Connect `Login.vue` to send email/password.
9. After successful login, store session/token state in frontend.

## 14. Short answer

To save registration inputs into the database:

- Vue collects form values
- Vue sends them to Laravel with a `POST` request
- Laravel validates them
- Laravel creates a `User`
- Laravel saves that user into the `users` table

To check login credentials later:

- Vue sends email and password to Laravel
- Laravel finds the user by email
- Laravel compares the entered password with the hashed password in the database
- Laravel returns success or failure

## 15. Best next step

If you want, the next step I can do is make you a second file called something like `auth-implementation-checklist.md` that is even simpler and shows:

- which file to open
- what each file is responsible for
- in what order to edit them

without writing the real code yet.
