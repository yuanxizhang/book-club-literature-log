# Book Club Literature Log Project

## Objectives

Build a full scale Sinatra application that uses:

- A sqlite database
- ActiveRecord
- RESTful routes
- Sessions
- Login/Logout

## Overview

The goal of this project is to build a web app that allows book club members to keep a record of reading logs that include book title, book summary, analysis, and discussion questions.

We will have multiple objects that interact in this web app, including separate classes for book clubs, users(book club memebers), book club meetings, and users' reading logs.

Users will be able to sign up, log in, and log out. A user must have a unique username to sign up. A user should not be able to take any actions (except sign-up), unless they are logged in. 

Once a user is logged in, they should be able to create, read, update and delete their own logs, as well as view all the literature logs. Users can only edit and delete their own reading logs - not logs created by other users.

### Gemfile and environment.rb

This project is supported by Bundler and includes a `Gemfile`.

Run bundle install to get started on this project.

### Models

There are five models in `app/models` directory: `User` model, `Log` model, `BookClub` model, `Meeting` model, and `UserMeeting` model. All classes inherit from `ActiveRecord::Base`.

### Associations

A book club has many users(members). A user belongs to ONE book club.
A book club has many meetings. A meeting belongs to ONE book club.
A user has many literature logs. A log belongs to ONE user. 
A meeting has many users, A users goes to many meetings. 
User_meetings is the joint table that keep the records of which user goes to which meeting.

`User` model is in a `has_many` relationship with `Log` model. 
`User` model is in a `belongs_to` relationship with `BookClub` model.
`User` model is in a `many_to_many` relationship with `Meeting` model.
`Meeting` model is in a `belongs_to` relationship with `BookClub` model.

### Helper methods To Protect The Views

We will create a few helper methods `current_user` and `logged_in?`. We 
want to use these helper methods to block content if a user is not logged in.

It's especially important that a user should not be able to edit or delete the
logs created by a different user. A user can only modify their own literature logs.

### License