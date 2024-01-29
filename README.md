# Twitter Queries:🪢
# Assignment 3 : 📜

<img src = "https://github.com/PrinceSah09/Twitter-Database-Schema/assets/75531808/a085ddc8-b452-43bd-8046-67cfb6c1cf13" height = "480px" widht="260px">
<img src = "https://github.com/PrinceSah09/Twitter-Database-Schema/assets/75531808/56483983-4aed-43f7-bead-23f581060323" height = "480px" width = "860px">
<img src = "https://github.com/PrinceSah09/Twitter-Database-Schema/assets/75531808/15d1b6e4-eceb-4ab3-9197-406683279931" height = "480px" width = "800px">
<img src = "https://github.com/PrinceSah09/Twitter-Database-Schema/assets/75531808/ce5c641b-bf44-4cec-8e2d-4fc4b200b190" height = "480px" width = "860px">
<img src = "https://github.com/PrinceSah09/Twitter-Database-Schema/assets/75531808/62c9ac8d-f94d-4c5a-b14f-9dcaca273e65" height = "480px" width = "860px">
<img src = "https://github.com/PrinceSah09/Twitter-Database-Schema/assets/75531808/a60641a8-24b1-4334-bc95-25f27e46dfb4" height = "480px" width = "860px">
<img src = "https://github.com/PrinceSah09/Twitter-Database-Schema/assets/75531808/3ca81c95-db3c-44b5-b73c-65152e60792d" height = "480px" width = "860px">
<img src = "https://github.com/PrinceSah09/Twitter-Database-Schema/assets/75531808/edd05ff1-d432-4452-a5dc-4084eff93296" height = "480px" width = "860px">

-- Query_01: fetch all user name from database 🔆
 - select fullName from UserProfile;

-- Query_02: Fetch all tweets of user by user id most recent tweets first 🔆
- select Tweet.content, UserProfile.fullName, Tweet.timeStamps
from Tweet
Join UserProfile on Tweet.userID = UserProfile.userID
where Tweet.userID = 3
order by Tweet.timeStamps DESC;

-- Query_03: Fetch like count of particular tweet by tweetID 🔆
- select count(*) as LikeCount
from Likes where tweetID = 2;

-- Query_04: fetch retweet count of particular tweet by tweetID 🔆
- select count(*) as RetweetCount
from Retweet where originalTweetID = 2;

-- Query_05: Fetch comment count of particular tweet by tweetID 🔆
- SELECT COUNT(*) AS CommentCount
FROM Tweet
WHERE parentTweetID = 1;


-- Query_06: fetch all user's name who have retweeted particular tweet by tweetID 🔆
- select UserProfile.fullName 
from Retweet
JOIN UserProfile on Retweet.userID = UserProfile.userID
where Retweet.originalTweetID= 2;



-- Query_07 :Fetch all commented tweet's content for a particular tweet by tweet id 🔆
- SELECT CommentedTweet.content
FROM Tweet AS CommentedTweet
JOIN Tweet AS Comment ON CommentedTweet.tweetID = Comment.parentTweetID
WHERE Comment.parentTweetID = 2;


-- Query_08 :fetch user's timeline (All tweets from users whom I am following with content and user name who have tweeted it) 🔆
- SELECT Tweet.content, UserProfile.fullName AS UserName
FROM Tweet
JOIN UserProfile ON Tweet.userID = UserProfile.userID
WHERE Tweet.userID IN (
   SELECT followedUserID
   FROM follow
   WHERE followerUserID = 1
)
ORDER BY Tweet.timestamps DESC;
