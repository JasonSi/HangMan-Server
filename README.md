# HangMan-Server
Hangman game server based on rails.

## Intro

1. At the very beginning, I prefer to use UUID of every device to distinguish one from another, and just one session to keep a game.
2. The authorized app will own an app_key. When it requests the API "startGame", an app_key is needed.


## API

#### Start Game
> http://localhost:3000/startGame

POST Data Format:
```json
{
  "uid": "BE5BA3D0-971C-4427-9ECF-E2D1ABCC66BE",
  "appKey": "42725adecf47629878e89e31b2073d1af009c9c76f4140a064..."
}
```

Response:
```json
{
  "message": "The Game Is On",
  "numberOfWordsToGuess": 20,
  "numberOfGuessAllowedForEachWord": 10
}
```

#### Next Word
> http://localhost:3000/nextWord

POST Data Format:
```json
/* Nothing Needed */
```

Response:
```json
{
  "message": "This Is A New Word",
  "word": "*****",
  "wrongGuessCountOfCurrentWord": 0,
  "totalWordCount": 1,
  "correctWordCount": 0,
  "totalWrongGuessCount": 0,
  "score": 0
}
```

#### Guess Word
> http://localhost:3000/guessWord

POST Data Format:
```json
{
  "guess": "A"
}
```

Response:
```json
{
  "message": "Your Guess Is A",
  "word": "**A**",
  "wrongGuessCountOfCurrentWord": 0,
  "totalWordCount": 1,
  "correctWordCount": 0,
  "totalWrongGuessCount": 0,
  "score": 0
}
```

#### Submit Result
> http://localhost:3000/submitResult

POST Data Format:
```json
/* Nothing Needed */
```

Response:
```json
{
  "message": "Game Over",
  "uid": "BE5BA3D0-971C-4427-9ECF-E2D1ABCC66BE",
  "totalWordCount": 20,
  "correctWordCount": 18,
  "totalWrongGuessCount": 90,
  "score": 270
}
```

#### Quit Game
> http://localhost:3000/quitGame

POST Data Format:
```json
/* Nothing Needed */
```

Response:
```json
{
  "message": "Exit"
}
```

#### Feedback
> http://localhost:3000/feedback

POST Data Format:
```json
{
  "email": "me@jasonsi.com",
  "content": "你可真棒！"
}
```

Response:
```json
{
  "message": "Feedback Success!"
}
```


## Wrong Request

#### Wrong AppKey
Response:
```json
{
  "message": "No Access!"
}
```
**Reason:** Because this POST request did not get server's authority.You need to insert an app_key into the table app_keys, then the value of column **key** is what you need to carry.

#### Wrong Format of UUID
Response:
```json
{
  "message": "Wrong UID"
}
```
**Reason:** Maybe the UUID in the request is illegal.(Its format should be like this: BE5BA3D0-971C-4427-9ECF-E2D1ABCC66BE)

#### No Words Left
Response:
```json
{
  "message": "No Words Left!"
}
```
**Reason:** This means you have run out words.

#### Submit Result Failure
Response:
```json
{
  "message": "Score Saving Failed!"
}
```
**Reason:** Maybe it has trouble with database.

#### Session Close
Response:
```json
{
  "message": "No Session!"
}
```
**Reason:** Maybe just quit this game, or Cookie missing.

#### Feedback Failed
Response:
```json
{
  "message": "Feedback Failed!"
}
```
**Reason:** Maybe the format of email or content is illegal.


## Parameters
- **NumberOfWordsToGuess:** Total words count to guess.
- **NumberOfGuessAllowedForEachWord:** *Number* chances to guess wrong letter for each word.
- **TotalWordCount:** Words have been guessed till now.
- **CorrectWordCount:** Words have been cleared till now.
- **TotalWrongGuessCount:** Total wrong guesses from beginning to now.

##  TODO

- Add session function.  *OK*
- Create a table named "app_keys" to store keys for verifying the client. *OK*
- Add the real game logic. *OK*
- Save the feedback and Email it to myself. *OK*
- Give a regex to validate app_key and email. *OK*


## Usage

1. Install Ruby and Mysql.

    I suggest installing ruby by compiling the source code.And then

    ```bash
      sudo apt-get install mysql-client mysql-server libmysqlclient-dev
    ```

2. Use **ruby -v** , **gem -v** to ensure it is installed correctly.
3. Change the source of gem with [Ruby-Taobao](https://ruby.taobao.org) or [Ruby-China](https://gems.ruby-china.org/).
4. Install Rails.

  ```bash
    sudo gem install rails
  ```
5. Run **sudo gem install bundle** to install **bundler** .
6. Git clone this repo and run **bundle install** .
7. Set your MySQL username and password.

  - mysql -u root -p
  - CREATE USER hangman IDENTIFIED BY 'hangwoman';
  - GRANT ALL ON hangman_dev.* TO hangman;
  - GRANT ALL ON hangman.* TO hangman;
  - GRANT ALL ON hangman_test.* TO hangman;
  - flush privileges;

8. Run **rake db:setup** to initialize the database.
9. Run **rake db:seed** to insert vocabularies.
10. Create a file named **.env** in the root.There are some ENV variables in it like

    ```
    email_username=example@domain.com
    email_password=somepassword
    ```
11. Run **rails server** or **rails s** to start server.
