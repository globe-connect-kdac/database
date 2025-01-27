CREATE TABLE `user`(
    `user_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `username` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `mobile` VARCHAR(255) NOT NULL,
    `birth` DATE NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `gender` ENUM(
        'male',
        'female',
        'others',
        'prefer not to say'
    ) NOT NULL,
    `status` ENUM('active', 'inactive', 'banned') NOT NULL DEFAULT 'active',
    `profile_img` BLOB NULL,
    `bio` TEXT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NOT NULL DEFAULT 'created_at',
    `extra1` VARCHAR(255) NOT NULL,
    `extra2` VARCHAR(255) NOT NULL,
    `extra3` INT NOT NULL
);
ALTER TABLE
    `user` ADD INDEX `user_username_index`(`username`);
ALTER TABLE
    `user` ADD UNIQUE `user_username_unique`(`username`);
ALTER TABLE
    `user` ADD UNIQUE `user_email_unique`(`email`);
ALTER TABLE
    `user` ADD UNIQUE `user_mobile_unique`(`mobile`);
CREATE TABLE `community`(
    `community_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `rules` VARCHAR(255) NULL,
    `role` ENUM('member', 'owner', 'admin') NOT NULL DEFAULT 'member',
    `community_image` BLOB NULL,
    `status` ENUM('active', 'inactive', 'archived') NOT NULL DEFAULT 'active',
    `category` ENUM(
        'sports',
        'finance',
        'arts',
        'history',
        'news',
        'science&technology',
        'others'
    ) NOT NULL,
    `visibilty` ENUM('public', 'private') NOT NULL DEFAULT 'public',
    `created_at` TIMESTAMP NOT NULL DEFAULT 'timestamp',
    `updated_at` TIMESTAMP NOT NULL,
    `member_count` BIGINT UNSIGNED NOT NULL DEFAULT '1' AUTO_INCREMENT,
    `report_count` BIGINT NOT NULL DEFAULT '0',
    `engagement_score` ENUM(
        '0',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10'
    ) NOT NULL DEFAULT '10',
    `verified` BOOLEAN NOT NULL DEFAULT '0',
    `tags` JSON NOT NULL,
    `extra1` VARCHAR(255) NOT NULL,
    `extra2` VARCHAR(255) NOT NULL,
    `extra3` BIGINT NOT NULL
);
ALTER TABLE
    `community` ADD INDEX `community_status_index`(`status`);
ALTER TABLE
    `community` ADD INDEX `community_category_index`(`category`);
ALTER TABLE
    `community` ADD INDEX `community_tags_index`(`tags`);
ALTER TABLE
    `community` ADD INDEX `community_visibilty_index`(`visibilty`);
ALTER TABLE
    `community` ADD UNIQUE `community_title_unique`(`title`);
CREATE TABLE `post`(
    `post_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT NOT NULL,
    `community_id` BIGINT NULL,
    `title` TEXT NULL,
    `captions` TEXT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NOT NULL,
    `image` BLOB NULL,
    `video` BLOB NULL,
    `audio` BLOB NULL,
    `status` ENUM('active', 'inactive', 'archived') NOT NULL DEFAULT 'active',
    `extra1` VARCHAR(255) NULL,
    `extra2` VARCHAR(255) NULL,
    `extra3` BIGINT NULL,
    `CountComments` BIGINT NOT NULL,
    `CountUpvote` BIGINT NOT NULL,
    `CountDownvote` BIGINT NOT NULL
);
ALTER TABLE
    `post` ADD INDEX `post_user_id_index`(`user_id`);
ALTER TABLE
    `post` ADD INDEX `post_post_id_index`(`post_id`);
CREATE TABLE `comments`(
    `comment_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `post_id` BIGINT NOT NULL,
    `user_id` BIGINT NOT NULL,
    `parent_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `comment` TEXT NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NOT NULL,
    `status` ENUM('active', 'inactive', 'deleted') NOT NULL DEFAULT 'active',
    `extra1` VARCHAR(255) NULL,
    `extra2` VARCHAR(255) NULL,
    `extra3` BIGINT NULL
);
ALTER TABLE
    `comments` ADD INDEX `comments_comment_id_index`(`comment_id`);
ALTER TABLE
    `comments` ADD INDEX `comments_user_id_index`(`user_id`);
CREATE TABLE `vote`(
    `user_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `post_id` BIGINT NOT NULL,
    `upvote` ENUM('0', '1') NOT NULL DEFAULT '0',
    `downvote` ENUM('0', '1') NOT NULL DEFAULT '0',
    `status` BOOLEAN NOT NULL DEFAULT '1',
    `extra1` VARCHAR(255) NULL,
    `extra2` BIGINT NULL
);
ALTER TABLE
    `vote` ADD INDEX `vote_user_id_index`(`user_id`);
ALTER TABLE
    `vote` ADD INDEX `vote_post_id_index`(`post_id`);
ALTER TABLE
    `vote` ADD UNIQUE `vote_post_id_unique`(`post_id`);
CREATE TABLE `community_report`(
    `report_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `report_owner` BIGINT NOT NULL,
    `report_title` TEXT NOT NULL,
    `report_content` TEXT NOT NULL,
    `community_id` BIGINT NOT NULL,
    `post_id` BIGINT NOT NULL,
    `extra1` VARCHAR(255) NOT NULL,
    `extra2` BIGINT NOT NULL
);
ALTER TABLE
    `community_report` ADD INDEX `community_report_report_owner_index`(`report_owner`);
ALTER TABLE
    `community_report` ADD INDEX `community_report_community_id_index`(`community_id`);
ALTER TABLE
    `community_report` ADD INDEX `community_report_post_id_index`(`post_id`);
CREATE TABLE `trending_topics`(
    `trending_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `category_id` BIGINT NOT NULL,
    `is_hashtag` BOOLEAN NOT NULL DEFAULT '0',
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NOT NULL,
    `popularity_score` ENUM(
        '0',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10'
    ) NOT NULL DEFAULT '0'
);
ALTER TABLE
    `trending_topics` ADD UNIQUE `trending_topics_category_id_unique`(`category_id`);
CREATE TABLE `faq`(
    `faq_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `question` TEXT NOT NULL,
    `answer` TEXT NOT NULL
);
ALTER TABLE
    `comments` ADD CONSTRAINT `comments_comment_id_foreign` FOREIGN KEY(`comment_id`) REFERENCES `post`(`post_id`);
ALTER TABLE
    `post` ADD CONSTRAINT `post_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `user`(`user_id`);
ALTER TABLE
    `comments` ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `user`(`user_id`);
ALTER TABLE
    `post` ADD CONSTRAINT `post_post_id_foreign` FOREIGN KEY(`post_id`) REFERENCES `community`(`community_id`);
ALTER TABLE
    `comments` ADD CONSTRAINT `comments_parent_id_foreign` FOREIGN KEY(`parent_id`) REFERENCES `comments`(`parent_id`);
ALTER TABLE
    `vote` ADD CONSTRAINT `vote_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `user`(`user_id`);
ALTER TABLE
    `post` ADD CONSTRAINT `post_community_id_foreign` FOREIGN KEY(`community_id`) REFERENCES `community`(`community_id`);
ALTER TABLE
    `vote` ADD CONSTRAINT `vote_post_id_foreign` FOREIGN KEY(`post_id`) REFERENCES `post`(`post_id`);
ALTER TABLE
    `community` ADD CONSTRAINT `community_community_id_foreign` FOREIGN KEY(`community_id`) REFERENCES `user`(`user_id`);
ALTER TABLE
    `post` ADD CONSTRAINT `post_post_id_foreign` FOREIGN KEY(`post_id`) REFERENCES `user`(`user_id`);
ALTER TABLE
    `comments` ADD CONSTRAINT `comments_post_id_foreign` FOREIGN KEY(`post_id`) REFERENCES `post`(`post_id`);