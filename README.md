# Funny Movies App

## Introduction
This is a demo project where users can register and log in to use the movie sharing feature on the website. 
The project includes the following components:
- Using Action Cable to send notification messages to users via the socket protocol.
- Utilizing Sidekiq for handling background jobs, specifically for automatically retrieving title and description information from YouTube videos.
- Incorporating Google API to fetch video information from YouTube.

## Prerequisites
Requirement environment:
- Ruby and Rails
- Postgres SQL
- Redis
- Docker

Language and frameworks used in the project:
- Backend Side:
  - Ruby 3.0.0
  - Rails 7.0.6
  - Action Cable for Socket Connection
  - Database: Postgres and Redis
  - Background Job: Sidekiq
  - Testing: Rspec for unit tests, Cucumber for integration tests, Faker
  - Dockerfile and docker-compose to build container
  - google-api-client: to get title and description
  - Other libraries listed in the Gemfile
- Frontend Side:
  - HTML ERB (Embedded Ruby), CSS, Bootstrap
  - Javascript

## Installation & Configuration
1. Clone project form GIT repo:
> git clone https://github.com/finnpham20/funny-movies.git

2. Configure:

Add the development and test key credential to run the application.
In folder `config/credentials` add 2 keys below: (I'll attach it)
- `development.key`
- `test.key`

3. Install library:

> bundle install --path vendor/bundle

## Database Setup
To set up the database, you need to access the credentials file to configure it.

1. Config database

Edit credential file:
> EDITOR="vim" rails credentials:edit --environment development

Config DB:
```yml
db:
  host: <host db>
  username: <username db>
  password: <password db>
  db_name: <database name>
```

2. Create DB if not exist:

> rails db:create

3. Run migration:

With a new database, you need to run migrations to initialize the structure and tables of the database.

> rails db:migrate

## Running the Application:

### Run app in local:
Start funny movies app:
> rails s -p 4000

Start sidekiq job:
> bundle exec sidekiq -q fetch_video_ino

The app will be run at url: `http://127.0.0.1:4000/`

### Execute test:
Create DB test if not exist:
> RAILS ENV=test rails db:create # if not exist

Migrate DB test:
> RAILS ENV=test rails db:migrate

Run unit test:
> bundle exec rspec

Run integration test:
> bundle exec cucumber

## Docker Deployment:

Start app with docker compose

Build:
> docker-compose build

Start app:
> docker-compose up
 
## Usage:
- Registration:
  - On the homepage screen, the user fills in the new email and password information to proceed with the registration.
  - Upon successful registration, the user will be redirected back to the homepage and prompted to log in again.
  - Note: If the email already exists, this means the user should proceed with logging in.
- Login:
  - On the homepage screen, the user enters the registered email and password to log in.
  - Upon successful login, the user will be redirected back to the homepage and see the title 'Welcome email'.
- Logout: The user, who is already logged in, clicks on the logout button located on the right side of the header to log out of the current email.
- Share video:
  - The user, who is already logged in, clicks on the "Share a movie" button to share a new video.
  - The user proceeds to enter a YouTube URL into the form, ensuring that the URL is in the correct format.
  - After successful submission, the system automatically retrieves the video, title, and description information for the shared video.
  - Once the system finishes processing, a notification about the newly shared video will be sent to logged-in users through the socket.
  - The new video will be automatically added to the homepage.
- Homepage: display a list of movies shared by all users.

Demo link:
- Register, login and logout: 
https://www.loom.com/share/15a2e30c7e6c41e790a5b577d5250474?sid=8977abf4-8409-4717-93d6-baa3ac55def0

- Login and share a movies: 
https://www.loom.com/share/bb6cb5ad38424ceaa22c338568344632?sid=028266a8-5359-40c0-90fb-0820daa9dc80

- Received message when someone share new video:
https://www.loom.com/share/b3dee74629ec47bfa1aaa5aed4cbf82c?sid=9848b04f-b4ed-4380-b45f-f4fc81bdd60d

## Troubleshooting

- Redis Configuration: Sidekiq relies on Redis as its message broker and for job storage. Ensure that Redis is properly installed and configured in your Rails app's configuration files, such as config/redis.yml or config/application.rb.

Redis start
> redis-server

- Config credentials key: please make sure you are already to setup key before starting the app.

Add credentials key in `config/credentials`

- Run Sidekiq jobs before starting the web app. The video sharing feature relies on Sidekiq to fetch information, so if Sidekiq is not started, it won't be able to retrieve video details or send notifications to users.
