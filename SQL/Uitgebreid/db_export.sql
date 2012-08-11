-- phpMyAdmin SQL Dump
-- version 3.3.7deb7
-- http://www.phpmyadmin.net
--
-- Machine: db.nstrien.com
-- Genereertijd: 19 Mei 2012 om 16:54
-- Serverversie: 5.1.61
-- PHP-Versie: 5.3.3-7+squeeze8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `md146266db215814`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `contributor`
--

CREATE TABLE IF NOT EXISTS `contributor` (
  `tweet_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  KEY `tweet_id` (`tweet_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `coordinate`
--

CREATE TABLE IF NOT EXISTS `coordinate` (
  `coordinates` point NOT NULL,
  `type` varchar(100) NOT NULL,
  `tweet_id` bigint(11) NOT NULL,
  KEY `tweet_id` (`tweet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `hashtag`
--

CREATE TABLE IF NOT EXISTS `hashtag` (
  `tweet_id` bigint(20) NOT NULL,
  `text` varchar(140) NOT NULL,
  `index_start` int(11) NOT NULL,
  `index_end` int(11) NOT NULL,
  KEY `tweet_id` (`tweet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `media`
--

CREATE TABLE IF NOT EXISTS `media` (
  `id` bigint(20) NOT NULL,
  `display_url` varchar(140) NOT NULL,
  `expanded_url` varchar(250) NOT NULL,
  `index_start` int(11) NOT NULL,
  `index_end` int(11) NOT NULL,
  `media_url` varchar(140) NOT NULL,
  `media_url_https` varchar(140) NOT NULL,
  `type` varchar(100) NOT NULL,
  `url` varchar(250) NOT NULL,
  `tweet_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tweet_id` (`tweet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `place`
--

CREATE TABLE IF NOT EXISTS `place` (
  `country` varchar(100) NOT NULL,
  `country_code` char(2) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `id` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `place_type` varchar(100) NOT NULL,
  `url` varchar(250) NOT NULL,
  `bounding_box_coordinates` polygon NOT NULL,
  `bounding_box_type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `sizes`
--

CREATE TABLE IF NOT EXISTS `sizes` (
  `media_id` bigint(20) NOT NULL,
  `thumb_h` int(11) NOT NULL,
  `thumb_resize` enum('fit','crop') NOT NULL,
  `thumb_w` int(11) NOT NULL,
  `large_h` int(11) NOT NULL,
  `large_resize` enum('fit','crop') NOT NULL,
  `large_w` int(11) NOT NULL,
  `medium_h` int(11) NOT NULL,
  `medium_resize` enum('fit','crop') NOT NULL,
  `medium_w` int(11) NOT NULL,
  `small_h` int(11) NOT NULL,
  `small_resize` enum('fit','crop') NOT NULL,
  `small_w` int(11) NOT NULL,
  KEY `media_id` (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `tweet`
--

CREATE TABLE IF NOT EXISTS `tweet` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `current_user_retweet_id` bigint(20) NOT NULL,
  `favorited` tinyint(1) DEFAULT NULL,
  `in_reply_to_screen_name` varchar(50) NOT NULL,
  `in_reply_to_status_id` bigint(20) NOT NULL,
  `in_reply_to_user_id` bigint(20) NOT NULL,
  `place` varchar(100) NOT NULL,
  `possibly_sensitive` tinyint(1) DEFAULT NULL,
  `retweet_count` bigint(20) NOT NULL,
  `retweeted` tinyint(1) NOT NULL,
  `source` varchar(250) NOT NULL,
  `text` varchar(250) NOT NULL,
  `truncated` tinyint(1) NOT NULL,
  `user` bigint(20) NOT NULL,
  `withheld_in_countries` varchar(250) NOT NULL,
  `withheld_scope` enum('user','status') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `place` (`place`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `URL`
--

CREATE TABLE IF NOT EXISTS `URL` (
  `tweet_id` bigint(20) NOT NULL,
  `display_url` varchar(140) NOT NULL,
  `expanded_url` varchar(250) NOT NULL,
  `index_start` int(11) NOT NULL,
  `index_end` int(11) NOT NULL,
  `url` varchar(140) NOT NULL,
  KEY `tweet_id` (`tweet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint(20) NOT NULL,
  `contributors_enabled` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `default_profile` tinyint(1) NOT NULL,
  `default_profile_image` tinyint(1) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `favourites_count` bigint(20) NOT NULL,
  `follow_request_sent` tinyint(1) DEFAULT NULL,
  `followers_count` bigint(20) NOT NULL,
  `friends_count` bigint(20) NOT NULL,
  `geo_enabled` tinyint(1) NOT NULL,
  `is_translator` tinyint(1) NOT NULL,
  `lang` char(2) NOT NULL,
  `listed_count` bigint(20) NOT NULL,
  `location` varchar(250) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `notifications` int(11) NOT NULL,
  `profile_background_color` varchar(100) NOT NULL,
  `profile_background_image_url` varchar(100) NOT NULL,
  `profile_background_image_url_https` varchar(100) NOT NULL,
  `profile_background_tile` tinyint(1) NOT NULL,
  `profile_image_url` varchar(100) NOT NULL,
  `profile_image_url_https` varchar(100) NOT NULL,
  `profile_link_color` char(6) NOT NULL,
  `profile_sidebar_border_color` char(6) NOT NULL,
  `profile_sidebar_fill_color` char(6) NOT NULL,
  `profile_text_color` char(6) NOT NULL,
  `profile_use_background_image` tinyint(1) NOT NULL,
  `protected` tinyint(1) NOT NULL,
  `screen_name` varchar(50) NOT NULL,
  `show_all_inline_media` tinyint(1) NOT NULL,
  `status` bigint(20) NOT NULL,
  `statuses_count` bigint(20) NOT NULL,
  `time_zone` varchar(100) DEFAULT NULL,
  `url` varchar(100) NOT NULL,
  `utc_offset` int(11) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `withheld_in_countries` varchar(250) NOT NULL,
  `withheld_scope` enum('user','status') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `user_mention`
--

CREATE TABLE IF NOT EXISTS `user_mention` (
  `user_id` bigint(11) NOT NULL,
  `index_begin` int(11) NOT NULL,
  `index_end` int(11) NOT NULL,
  `tweet_id` bigint(11) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `tweet_id` (`tweet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Beperkingen voor gedumpte tabellen
--

--
-- Beperkingen voor tabel `contributor`
--
ALTER TABLE `contributor`
  ADD CONSTRAINT `contributor_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `contributor_ibfk_1` FOREIGN KEY (`tweet_id`) REFERENCES `tweet` (`id`);

--
-- Beperkingen voor tabel `coordinate`
--
ALTER TABLE `coordinate`
  ADD CONSTRAINT `coordinate_ibfk_1` FOREIGN KEY (`tweet_id`) REFERENCES `tweet` (`id`);

--
-- Beperkingen voor tabel `hashtag`
--
ALTER TABLE `hashtag`
  ADD CONSTRAINT `hashtag_ibfk_2` FOREIGN KEY (`tweet_id`) REFERENCES `tweet` (`id`),
  ADD CONSTRAINT `hashtag_ibfk_1` FOREIGN KEY (`tweet_id`) REFERENCES `tweet` (`id`);

--
-- Beperkingen voor tabel `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `media_ibfk_2` FOREIGN KEY (`tweet_id`) REFERENCES `tweet` (`id`),
  ADD CONSTRAINT `media_ibfk_1` FOREIGN KEY (`tweet_id`) REFERENCES `tweet` (`id`);

--
-- Beperkingen voor tabel `sizes`
--
ALTER TABLE `sizes`
  ADD CONSTRAINT `sizes_ibfk_1` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`);

--
-- Beperkingen voor tabel `tweet`
--
ALTER TABLE `tweet`
  ADD CONSTRAINT `tweet_ibfk_3` FOREIGN KEY (`place`) REFERENCES `place` (`id`),
  ADD CONSTRAINT `tweet_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `tweet_ibfk_2` FOREIGN KEY (`user`) REFERENCES `user` (`id`);

--
-- Beperkingen voor tabel `URL`
--
ALTER TABLE `URL`
  ADD CONSTRAINT `URL_ibfk_1` FOREIGN KEY (`tweet_id`) REFERENCES `tweet` (`id`);

--
-- Beperkingen voor tabel `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`status`) REFERENCES `tweet` (`id`);

--
-- Beperkingen voor tabel `user_mention`
--
ALTER TABLE `user_mention`
  ADD CONSTRAINT `user_mention_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `user_mention_ibfk_1` FOREIGN KEY (`tweet_id`) REFERENCES `tweet` (`id`),
  ADD CONSTRAINT `user_mention_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `user_mention_ibfk_3` FOREIGN KEY (`tweet_id`) REFERENCES `tweet` (`id`);
