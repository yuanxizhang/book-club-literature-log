# Book Club Literature Log Project

## Objectives

1.  Build a full scale Sinatra application that uses:

- A sqlite database
- ActiveRecord
- RESTful routes
- Sessions
- Login/Logout

## Overview

The goal of this project is to build a web app that allows book club members to keep a record of book summary, analysis, and discussion questions.

There are multiple objects that interact in this web app, including separate classes for User and Log.

A user should not be able to take any actions (except sign-up), unless they are logged in. Once a user is logged in, they should be able to create, edit and delete their own logs, as well as view all the literature logs.

### Gemfile and environment.rb

This project is supported by Bundler and includes a `Gemfile`.

Run bundle install to get started on this project.

### Models

There are four models in `app/models` directory: `User` model, `Log` model, 'BookClub' model, and 'Meeting' model. All classes inherit from `ActiveRecord::Base`.

### Associations

Users have a username, email, and password. 
Users have many literature logs.
Users belongs to a book club.

Book Clubs have many members/users, each book club has a name.
Book Clubs have many meetings.

Meetings have a date, location, start time and end time.
Users go to many meetings.
meetings are attended by many members/users. 
Users and Meetings are in a many-to-many relationship.

### Helper methods To Protect The Views

We need to create two helper methods `current_user` and `logged_in?`. We 
want to use these helper methods to block content if a user is not logged in.

It's especially important that a user should not be able to edit or delete the
logs created by a different user. A user can only modify their own literature logs.

