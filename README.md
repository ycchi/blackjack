# Blackjack

Blackjack app developed on Ruby on Rails

## Prerequisites

* Ruby 3.4.10 

## Setup

* Install dependencies: `bundle install`
* Set up the database: `bin/rails db:setup`

## Running

* Start the server: `bin/rails server`
* Acces the app: http://localhost:3000

## Rules

* Played with a single 52-card deck
* Each round deals 2 cards to the player and 2 to the dealer; one dealer card stays face down until the player stands
* Aces count as 11, and are automatically reduced to 1 if the hand would otherwise bust
* On their turn, the player may **Hit** (take another card) or **Stand** (end their turn)
* If a hand's total goes over 21, it busts
* Once the player stands, the dealer reveals their hidden card and hits until reaching 17 or higher
* Outcome: 
    - dealer busts → player wins 
    - player busts → dealer wins 
    - higher total wins
    - totals equal → push