# README
---
## Table of contents
* [General info](#general-info)
* [Video - Testing the website](#video---testing-the-website)
* [Technologies](#technologies)
* [Setup](#setup)
* [Features](#features)
* [Modeling](#modeling)
* [Status](#status)
* [Testing the deployed application](#testing-the-deployed-application)
* [On production](#on-production)
***
## General info
### Flix
A website that allows its users to review and favorite movies.
This app is the result of a [PragmaticStudio](https://pragmaticstudio.com/) course called [Ruby on Rails 7](https://pragmaticstudio.com/rails).
***
### [Video](https://www.loom.com/share/8a7619d58204486ab15572ffa950a350) - Testing the website

https://user-images.githubusercontent.com/97359453/213900888-a70f3f11-c668-464f-afbf-e6f1b47076f0.mp4

---
## Technologies
The project is created with/makes use of:
* Bundler
* Git
* Ruby on Rails
* Ruby
* Heroku - Deployment
* PostgreSQL 12 (Production Environment) & Sqlite3 (Development Environment)
---
## Setup
To run this project - locally - on your machine:
```
$ cd your-folder/eventz
$ bundle install
$ yarn install
$ rails db:create
$ rails db:migrate
$ rails db:seed
$ rails server
```
If you want to be able to **store your image files using amazon AWS S3**:

 * Go to the [amazon aws website](https://aws.amazon.com/) and create a new account.
 * Once logged in, click on **"IAM"** (Identity Account Management)
	 * Set up a new user - Select **Programmatic Access**
	 * Create a new group - Select **AmazonS3FullAccess**
	 * On the Review Page, click on **Create New User**
		 * This will give you an **Access key ID** and also a **Secret access key**, they are like a username and a password for **S3**
		 * Make sure to copy both and save them somewhere so that we can use them to set up our Rails AWS credentials.
* Now, look for the service **"S3"** and click on it.
	* Click on **Create bucket**, give it a name, leave the region as it is - use the default.
	* Copy and **save the bucket name** where you saved the other two AWS keys/credentials.
	* In manage public permissions, make sure you select **grant public read access to your bucket**
	* Make the bucket public by default.
	* You can follow the instructions on this answer [here](https://stackoverflow.com/a/70603995) to make sure you allow ACLs and AWS S3 can be properly used with your deployed app on Heroku.
* Open the file where you temporarily saved your AWS credentials you copied from the AWS website (**Access key ID**, **Secret access key**, **your bucket's name**) so that we can add them to our Rails application credentials file.
 * Open your credentials file running the following command:
	+  In the example below I used the vim editor to edit my credentials, you can replace "vim" with your text editor of preference.
	+ ```$ EDITOR=vim rails credentials:edit```
```
aws:
  access_key_id: add_your_aws_access_key_here
  secret_access_key: add_your_aws_secret_access_key_here

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: this_will_have_a_value_here
```
 * Save and close your credentials file, now your API keys are safely stored and can be indirectly referenced in your Rails application as explained in the following Rails [documentation](https://guides.rubyonrails.org/security.html#custom-credentials).
---
Go to ```config/storage.yml``` file
  * If the code bellow is commented in the file, ucomment it.
  * Fill out the code according to your credentials, bucket region, and bucket name.
```
amazon:
  service: S3
  access_key_id: <%= Rails.application.credentials.dig(:aws, :access_key_id) %>
  secret_access_key: <%= Rails.application.credentials.dig(:aws, :secret_access_key) %>
  region: the_region_of_your_bucket_here # us-east-1
  bucket: your_bucket_name_here #your_own_bucket-<%= Rails.env %>
```
***
## Features
* Create/Read/Update/Delete a user account - Login and Logout.
* As a user, I can:
    * Create, edit, update and delete a review about a movie.
    * Favorite an unfavorite a movie.
* As a user with admin permission, I can:
    * Create, edit, update and delete a movie.
---
## Modeling
* User - It is focused on the user (name, email, admin (is this user an admin?) );
* Movie - It is created by an admin user.
  * Has different fields (title, rating, total_gross, description...)
  * A Movie has many
    * reviews
    * favorites
    * characterizations
    * fans (users who favorite a movie) through favorites
    * genres through characterizations
* Genre - It relates to the genre a Movie can have. It has one field (name)
  * A Genre has many
    * characterizations
    * movies through characterizations
* Characterization - It is the connection between an Event and a Category.
  * It has the fields "movie_id" and "genre_id".
  * It belongs to
    * Movie
    * Genre
* Favorite
  * Belongs to
    * Movie
    * User
* Review
  * Belongs to
    * Movie
    * User
***
## Status
* This project is complete, but I am still looking for new ways/features to improve it.
***
## Testing the deployed application
* Go tho the website: [whispering-headland-52759.herokuapp.com](https://whispering-headland-52759.herokuapp.com/)
* Login with the example info as a regular user:
    > Email: maria@example.com\
    > Password: passwordpassword
* Login with the example info as an admin user:
    > Email: carlos@example.com\
    > Password: passwordpassword
## On production
Make sure you set your Rails Master Key value for Heroku so that it knows how to read your encrypted API keys.
* Your master key value can be found in ```app/config/master.key```
	+ Once you copy that value, run the following command replacing ```VALUE_INSIDE_OF_YOUR_MASTER_KEY_FILE``` with the value you copied from ```master.key```
		+ ```$ heroku config:set RAILS_MASTER_KEY=VALUE_INSIDE_OF_YOUR_MASTER_KEY_FILE```
