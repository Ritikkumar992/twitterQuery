# Twitter Queries:🪢

### Assignment 3 : 📜
<br/>

## Queries 🔆

### Query_01:
- **fetch all user name from database**:
   - ```select fullName from UserProfile;```

### Query_02: 
- **Fetch all tweets of user by user id most recent tweets first**:
  - ```select Tweet.content, UserProfile.fullName, Tweet.timeStamps```
    ```from Tweet``
    Join UserProfile on Tweet.userID = UserProfile.userID
    where Tweet.userID = 3
    order by Tweet.timeStamps DESC;```

### Query_03: 
- **Fetch like count of particular tweet by tweetID**:
  - ```select count(*) as LikeCount```
    ```from Likes where tweetID = 2;```

### Query_04:  
- **fetch retweet count of particular tweet by tweetID**:
   - ```select count(*) as RetweetCount```
     ```from Retweet where originalTweetID = 2;```

### Query_05:   
- **Fetch comment count of particular tweet by tweetID**:
   - ```SELECT COUNT(*) AS CommentCount```
     ```FROM Tweet```
     ```WHERE parentTweetID = 1;```


### Query_06: 
- **fetch all user's name who have retweeted particular tweet by tweetID**
    - ```select UserProfile.fullName ```
      ```from Retweet```
      ```JOIN UserProfile on Retweet.userID = UserProfile.userID```
      ```where Retweet.originalTweetID= 2;```



### Query_07:
-  **Fetch all commented tweet's content for a particular tweet by tweet id**:
    - ```SELECT CommentedTweet.content```
     ``` FROM Tweet AS CommentedTweet```
      ```JOIN Tweet AS Comment ON CommentedTweet.tweetID = Comment.parentTweetID```
      ```WHERE Comment.parentTweetID = 2;```


### Query_08:
- **fetch user's timeline (All tweets from users whom I am following with content and user name who have tweeted it)**:
    - ```SELECT Tweet.content, UserProfile.fullName AS UserName```
      ```FROM Tweet```
      ```JOIN UserProfile ON Tweet.userID = UserProfile.userID```
      ```WHERE Tweet.userID IN (```
      ```SELECT followedUserID```
      ```FROM follow```
      ```WHERE followerUserID = 1```
     ```)```
     ```ORDER BY Tweet.timestamps DESC;```
