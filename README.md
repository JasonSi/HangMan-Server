# HangMan-Server
Hangman game server based on rails.

## Intro

1. At the very beginning, I prefer to use UUID of every device to distinguish one from another.
2. The authorized app will own an app_key. When it requests the API "startGame", an app_key is needed.


## API

### StartGame
> http://localhost:3000/startGame

POST Data Format:
```json
{
  "uid": "BE5BA3D0-971C-4427-9ECF-E2D1ABCC66BE",
  "appKey": "42f25adecf47629878e89e31b2073d1af009c9c76f4140a064..."
}
```

Response:
```json
{
  "message": "THE GAME IS ON",
  "sessionId": "4ac5de6f59868a427a0667f89452842e",
  "data": {
    "numberOfWordsToGuess": 20,
    "numberOfGuessAllowedForEachWord": 10
  }
}
```

### NextWord
> http://localhost:3000/nextWord

POST Data Format:
```json
{
  "sessionId": "4ac5de6f59868a427a0667f89452842e"
}
```

Response:
```json
{
  "sessionId": "4ac5de6f59868a427a0667f89452842e",
  "data": {
    "word": "*****",
    "totalWordCount": 1,
    "wrongGuessCountOfCurrentWord": 0
  }
}
```

### GuessWord
> http://localhost:3000/guessWord

POST Data Format:
```json
{
  "sessionId": "4ac5de6f59868a427a0667f89452842e",
  "guess": "A"
}
```

Response:
```json
{
  "sessionId": "4ac5de6f59868a427a0667f89452842e",
  "data": {
    "word": "**A**",
    "totalWordCount": 1,
    "wrongGuessCountOfCurrentWord": 0
  }
}
```


### GetResult
> http://localhost:3000/getResult

POST Data Format:
```json
{
  "sessionId": "4ac5de6f59868a427a0667f89452842e"
}
```

Response:
```json
{
  "sessionId": "4ac5de6f59868a427a0667f89452842e",
  "data": {
    "totalWordCount": 20,
    "correctWordCount": 18,
    "totalWrongGuessCount": 80,
    "score": 280
  }
}
```

### SubmitResult
> http://localhost:3000/submitResult

POST Data Format:
```json
{
  "sessionId": "4ac5de6f59868a427a0667f89452842e"
}
```

Response:
```json
{
  "message": "GAME OVER",
  "sessionId": "4ac5de6f59868a427a0667f89452842e",
  "data": {
    "uid": "BE5BA3D0-971C-4427-9ECF-E2D1ABCC66BE",
    "totalWordCount": 20,
    "correctWordCount": 18,
    "totalWrongGuessCount": 80,
    "score": 280,
    "datetime": "2016-05-30T12:18:00.427+08:00"
  }
}
```


##  TODO

- Add session function.  *ok*
- Create a table named "app_keys" to store keys for verifying the client. *ok*
- Add the real game logic.

## Usage

1. Install Ruby and Mysql.

    I suggest installing ruby by compiling the source code.And then

    ```bash
      sudo apt-get install mysqlclient mysqlserver libmysqlclient-dev
    ```

2. Use **ruby -v** , **gem -v** to ensure it is installed correctly.
3. Change the source of gem with [Ruby Taobao](https://ruby.taobao.org) or [Ruby-China](https://gems.ruby-china.org/).
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

8. Run **rake db:migrate** for migration.
9. Run **rake db:setup** to initialize the database.
10. Run **rails server** or **rails s** to start server.
