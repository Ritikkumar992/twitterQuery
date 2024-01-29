create database TwitterDb;
use TwitterDb;

-- create User table 
CREATE TABLE UserProfile(
    userID INT PRIMARY KEY,
    fullName VARCHAR(255),
    email VARCHAR(255),
    phoneNumber VARCHAR(15),
	timestamps DATETIME
);
-- create Tweet table 
CREATE TABLE Tweet (
    tweetID INT PRIMARY KEY,
    commentID INT,
    userID INT,
    content TEXT,
    parentTweetID INT,
	commentedContent TEXT,
    timestamps DATETIME,
    FOREIGN KEY (userID) REFERENCES UserProfile(userID),
	FOREIGN KEY (parentTweetID) REFERENCES Tweet(tweetID)
);
-- Create retweet table
CREATE TABLE Retweet (
    retweetID INT PRIMARY KEY,
    originalTweetID INT,
    userID INT,
    timestamps DATETIME,
    FOREIGN KEY (originalTweetID) REFERENCES Tweet(tweetID),
    FOREIGN KEY (userID) REFERENCES UserProfile(userID)
);

-- A like table containing data for liking tweets, comments( which are treated as tweet ) and also retweets
CREATE TABLE Likes (
    likeID INT PRIMARY KEY,
    tweetID INT,
    retweetID INT,
    userID INT,
    FOREIGN KEY (tweetID) REFERENCES Tweet(tweetID),
    FOREIGN KEY (retweetID) REFERENCES Retweet(retweetID),
    FOREIGN KEY (userID) REFERENCES UserProfile(userID)
);
-- Follow table for storing who followed whom
CREATE TABLE Follow (
    followID INT PRIMARY KEY,
    followerUserID INT,
    followedUserID INT,
    FOREIGN KEY (followerUserID) REFERENCES UserProfile(userID),
    FOREIGN KEY (followedUserID) REFERENCES UserProfile(userID)
);

-- Inserting records into user table
INSERT INTO UserProfile (userID, fullName, email, phoneNumber, timestamps)
VALUES
    (1, 'Ritik kumar', 'ritik@example.com', '123-456-7890', '2024-01-28 12:00:00'),
    (2, 'Tomo Datta', 'tomo@example.com', '987-654-3210', '2024-01-28 12:15:00'),
    (3, 'Paramita Datta', 'paro@example.com', '555-123-4567', '2024-01-28 12:30:00'),
    (4, 'Sannu', 'sannu@example.com', '888-999-0000', '2024-01-28 12:45:00');


-- Each tweet, whether an original post or a comment, is treated uniformly.
-- For original tweets, the comment_id is set to NULL. For comments, a separate
-- comment_id is generated along with the TweetId, maintaining consistency in the database.

-- Inserting tweets (including comments treated as tweets)
INSERT INTO Tweet (tweetID, commentID, userID, content, parentTweetID, commentedContent, timestamps)
VALUES
    (1, NULL, 1, 'First tweet by User 1', NULL, NULL, '2024-01-28 12:00:00'),
    (2, NULL, 2, 'Hello Twitter! User 2 here.', NULL, NULL, '2024-01-28 12:15:00'),
    (3, NULL, 3, 'Tweet from User 3. Exciting times!', NULL, NULL, '2024-01-28 12:30:00'),
    (4, NULL, 4, 'Another original tweet by User 4', NULL, NULL, '2024-01-28 12:45:00'),

    -- Commenting on tweets (treated as tweets)
    (5, 1, 2, NULL, 1, 'Replying to User 1\'s tweet. Cool!', '2024-01-28 13:00:00'),
    (6, 2, 3, NULL, 2, 'Replying to User 2\'s tweet. Hey there!', '2024-01-28 13:15:00'),
    (7, 5, 4, NULL, 1, 'Replying to User 1\'s tweet. Interesting!', '2024-01-28 13:30:00'),
    (8, 6, 1, NULL, 2, 'Replying to User 2\'s tweet. Nice!', '2024-01-28 13:45:00');



-- Retweet table
INSERT INTO Retweet (retweetID, originalTweetID, userID, timestamps)
VALUES
    (1, 1, 3, '2024-01-28 15:00:00'),    -- User 3 retweets Tweet 1
    (2, 2, 4, '2024-01-28 15:30:00');   -- User 4 retweets Tweet 2
    
-- Like table for liking tweet, comment (treated as tweet) and retweet also
INSERT INTO Likes (likeID, tweetID, retweetID, userID)
VALUES
    (1, 1, NULL, 2),    -- User 2 likes Tweet 1
    (2, NULL, 1, 3),    -- User 3 likes Retweet 1
    (3, 2, NULL, 4),    -- User 4 likes Tweet 2
    (4, 5, NULL, 1);    -- User 1 likes Tweet 5

-- Follow table 
INSERT INTO Follow (followID, followerUserID, followedUserID)
VALUES
    (1, 1, 2),    -- User 1 follows User 2
    (2, 2, 3),    -- User 2 follows User 3
    (3, 3, 4);    -- User 3 follows User 4
    
-- Assignment 3 :

-- Query_01: fetch all user name from database
select fullName from UserProfile;

-- Query_02: Fetch all tweets of user by user id most recent tweets first.
select Tweet.content, UserProfile.fullName, Tweet.timeStamps
from Tweet
Join UserProfile on Tweet.userID = UserProfile.userID
where Tweet.userID = 3
order by Tweet.timeStamps DESC;

-- Query_03: Fetch like count of particular tweet by tweetID.
select count(*) as LikeCount
from Likes where tweetID = 2;

-- Query_04: fetch retweet count of particular tweet by tweetID;
select count(*) as RetweetCount
from Retweet where originalTweetID = 2;

-- Query_05: Fetch comment count of particular tweet by tweetID.
SELECT COUNT(*) AS CommentCount
FROM Tweet
WHERE parentTweetID = 1;


-- Query_06: fetch all user's name who have retweeted particular tweet by tweetID.
select UserProfile.fullName 
from Retweet
JOIN UserProfile on Retweet.userID = UserProfile.userID
where Retweet.originalTweetID= 2;



-- Query_07 :Fetch all commented tweet's content for a particular tweet by tweet id.
SELECT CommentedTweet.content
FROM Tweet AS CommentedTweet
JOIN Tweet AS Comment ON CommentedTweet.tweetID = Comment.parentTweetID
WHERE Comment.parentTweetID = 2;


-- Query_08 :fetch user's timeline (All tweets from users whom I am following with content and user name who have tweeted it)
SELECT Tweet.content, UserProfile.fullName AS UserName
FROM Tweet
JOIN UserProfile ON Tweet.userID = UserProfile.userID
WHERE Tweet.userID IN (
   SELECT followedUserID
   FROM follow
   WHERE followerUserID = 1
)
ORDER BY Tweet.timestamps DESC;
