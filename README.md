# HangMan-Server
Hangman game server based on rails.

## Intro

1. At the very biginning, I prefer to use UUID of every device to distinguish one from another.
2. The authorized app will own an app_key. When it requests the API "startGame", an app_key is needed.


## API

### GameStart
> http://localhost:3000/startGame

POST Data Format:
>{
  "uid": UUID,
  "appKey": Auth key
}

Response:
> {
  "message": "THE GAME IS ON",
  "sessionId": session_id,
  "data": {
    "numberOfWordsToGuess": 20,
    "numberOfGuessAllowedForEachWord": 10
  }
}

### NextWord
> http://localhost:3000/nextWord

POST Data Format:
>{
  "sessionId": "4ac5de6f59868a427a0667f89452842e"
}

Response:
> {
  "sessionId": "4ac5de6f59868a427a0667f89452842e",
  "data": {
    "word": "*****",
    "totalWordCount": 1,
    "wrongGuessCountOfCurrentWord": 0
  }
}

### GuessWord
> http://localhost:3000/guessWord

POST Data Format:
>{
  "sessionId": "4ac5de6f59868a427a0667f89452842e",
  "guess": "A"
}

Response:
> {
  "sessionId": "4ac5de6f59868a427a0667f89452842e",
  "data": {
    "word": "\**A\**",
    "totalWordCount": 1,
    "wrongGuessCountOfCurrentWord": 0
  }
}

### GetResult
> http://localhost:3000/getResult

POST Data Format:
>{
  "sessionId": "4ac5de6f59868a427a0667f89452842e"
}

Response:
> {
  "sessionId": "4ac5de6f59868a427a0667f89452842e",
  "data": {
    "totalWordCount": 20,
    "correctWordCount": 18,
    "totalWrongGuessCount": 80,
    "score": 280
  }
}


##  TODO

- Add session function.  *ok*
- Create a table named "app_keys" to store keys for verifying the client. *ok*
- Add the real game logic.

## Usage

1. Install Ruby/Rails/Mysql
  I suggest installing ruby by compiling the source code.

```bash
  sudo apt-get install rails
  sudo apt-get install mysqlclient mysqlserver libmysqlclient-dev
```
2. Use **ruby -v** , **gem -v** to ensure it is installed correctly.
3. Change the source of gem with [Ruby Taobao](https://ruby.taobao.org) or [Ruby-China](https://gems.ruby-china.org/).
4. Run **sudo gem install bundle** to install **bundler** .
5. Git clone this repo and run **bundle install** .
6. Set your MySQL username and password.
7. Run **rake db:migrate** for migration.
8. Run **rake db:setup** to initialize the database.
9. Run **rails server** or **rails s** to start server.
