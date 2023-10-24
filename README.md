# Online Marketplace

## About The Project

This project is part of the TeachMeSkills RubyDeveloper course The goal of the project is to apply our knowledge of Ruby on Rails to create an online store that allows you to buy and sell products, leave reviews for products and sellers.
Main features:
* Autherization
* Adding products with photo, description and price
* Buyer user, seller user and admin user roles
* Adding reviews on products or sellers
* Search and filter products
* Email notification of new reviews

Created with:
- Ruby 3.0.2
- Ruby on Rails 7
- PostgreSQL 14.8

## Installation and setup

1. Download the project:
  ```
  $ git clone https://github.com/MihailMaiorov/TMSFinalProject.git
  $ cd TMSFinalProject
  ```
2. Install the libraries:
  ```bash
  $ # ruby dependencies
  $ bundle install

  $ # js dependencies
  $ yarn install
  ```
3. Create DB:
  ```
  $ rails db:create
  $ rails db:migrate
  ```
4. Fill the database with seeds:
  ```
  $ rails db:seed
  ```
5. Run application:
  ```
  $ rails s
  ```
6. Run Sidekiq:
 ```
 $ bundle exec sidekiq
 ```