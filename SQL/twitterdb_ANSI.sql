-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 11, 2012 at 03:00 PM
-- Server version: 5.5.24
-- PHP Version: 5.3.10-1ubuntu3.2

SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `twitterdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `tweet`
--

CREATE TABLE IF NOT EXISTS "tweet" (
  "id" bigint(20) NOT NULL,
  "created_at" datetime DEFAULT NULL,
  "favorited" tinyint(1) DEFAULT NULL,
  "in_reply_to_screen_name" varchar(50) DEFAULT NULL,
  "in_reply_to_status_id" bigint(20) DEFAULT NULL,
  "in_reply_to_user_id" bigint(20) DEFAULT NULL,
  "place" varchar(100) DEFAULT NULL,
  "retweet_count" bigint(20) DEFAULT NULL,
  "retweeted" tinyint(1) DEFAULT NULL,
  "source" varchar(250) DEFAULT NULL,
  "text" varchar(250) DEFAULT NULL,
  "truncated" tinyint(1) DEFAULT NULL,
  "user" bigint(20) DEFAULT NULL,
  PRIMARY KEY ("id"),
  KEY "user" ("user"),
  KEY "place" ("place")
);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS "user" (
  "id" bigint(20) NOT NULL,
  "created_at" datetime DEFAULT NULL,
  "default_profile" tinyint(1) DEFAULT NULL,
  "default_profile_image" tinyint(1) DEFAULT NULL,
  "description" varchar(250) DEFAULT NULL,
  "favourites_count" bigint(20) DEFAULT NULL,
  "follow_request_sent" tinyint(1) DEFAULT NULL,
  "followers_count" bigint(20) DEFAULT NULL,
  "friends_count" bigint(20) DEFAULT NULL,
  "geo_enabled" tinyint(1) DEFAULT NULL,
  "is_translator" tinyint(1) DEFAULT NULL,
  "lang" char(2) DEFAULT NULL,
  "listed_count" bigint(20) DEFAULT NULL,
  "location" varchar(250) DEFAULT NULL,
  "name" varchar(50) DEFAULT NULL,
  "profile_background_color" varchar(100) DEFAULT NULL,
  "profile_background_image_url" varchar(100) DEFAULT NULL,
  "profile_background_image_url_https" varchar(100) DEFAULT NULL,
  "profile_background_tile" tinyint(1) DEFAULT NULL,
  "profile_image_url" varchar(100) DEFAULT NULL,
  "profile_image_url_https" varchar(100) DEFAULT NULL,
  "profile_link_color" char(6) DEFAULT NULL,
  "profile_sidebar_border_color" char(6) DEFAULT NULL,
  "profile_sidebar_fill_color" char(6) DEFAULT NULL,
  "profile_text_color" char(6) DEFAULT NULL,
  "profile_use_background_image" tinyint(1) DEFAULT NULL,
  "protected" tinyint(1) DEFAULT NULL,
  "screen_name" varchar(50) DEFAULT NULL,
  "show_all_inline_media" tinyint(1) DEFAULT NULL,
  "statuses_count" bigint(20) DEFAULT NULL,
  "time_zone" varchar(100) DEFAULT NULL,
  "url" varchar(100) DEFAULT NULL,
  "utc_offset" int(11) DEFAULT NULL,
  "verified" tinyint(1) DEFAULT NULL,
  PRIMARY KEY ("id")
);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tweet`
--
ALTER TABLE `tweet`
  ADD CONSTRAINT "tweet_ibfk_1" FOREIGN KEY ("user") REFERENCES "user" ("id"),
  ADD CONSTRAINT "tweet_ibfk_2" FOREIGN KEY ("user") REFERENCES "user" ("id");

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
