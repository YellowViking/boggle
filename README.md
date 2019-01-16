# boggle

Requirements:

1. Server generates a random 4 x 4 boggle board
2. Browser client displays board
3. Client has a text input & sends requests to server
4. Server responds affirmatively if text input is present on board, negatively if not
5. Must use React for front end client application and Rails for backend server application
6. **[Not Implemented]** Extra Credit, not required: Check to see if the text input is actually a word against a dictionary

# Dependencies
* Ruby
* npm
* Yarn
* gem
* bundle
* rails
# Installation
* ```bundle install```
* ```cd ui/boggle; yarn build; cp -r build/* ../../public```
* ```rails server -b 127.0.0.1 -p 3000 -e development```
# Browser
* [127:0.0.1:3000 boggle](127:0.0.1:3000)
