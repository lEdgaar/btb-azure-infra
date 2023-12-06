CREATE DATABASE IF NOT EXISTS BTB_DB;
USE BTB_DB;

CREATE TABLE `role_type` (
  `id` integer PRIMARY KEY AUTO_INCREMENT COMMENT 'Identificador autoincremental único para poder identificar los roles',
  `name` varchar(100) NOT NULL,
  `internal_code` varchar(3) NOT NULL
);

CREATE TABLE `organizations` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255),
  `url_picture` varchar(255),
  `created_at` timestamp NOT NULL,
  `is_deleted` boolean
);

CREATE TABLE `countrys` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `country_code` varchar(3) NOT NULL
);

CREATE TABLE `users` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL,
  `date_of_birth` timestamp NOT NULL,
  `gender` char,
  `password` varchar(25) NOT NULL,
  `last_password_date` timestamp NOT NULL,
  `role_type_id` integer NOT NULL,
  `organization_id` integer,
  `is_deleted` boolean NOT NULL,
  `date_deleted` timestamp,
  `is_blocked` boolean NOT NULL,
  `date_blocked` timestamp,
  `country_id` integer,
  FOREIGN KEY (`role_type_id`) REFERENCES `role_type`(`id`),
  FOREIGN KEY (`organization_id`) REFERENCES `organizations`(`id`),
  FOREIGN KEY (`country_id`) REFERENCES `countrys`(`id`)
);

CREATE TABLE `chats` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_sended_id` integer NOT NULL,
  `user_recived_id` integer NOT NULL,
  `message` varchar(2000),
  `created_at` timestamp,
  FOREIGN KEY (`user_sended_id`) REFERENCES `users`(`id`),
  FOREIGN KEY (`user_recived_id`) REFERENCES `users`(`id`)
);

CREATE TABLE `user_settings` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `send_notifications` boolean NOT NULL,
  `send_emails` boolean NOT NULL,
  `send_group_request` boolean NOT NULL,
  `show_briefcase` boolean NOT NULL,
  `show_assets` boolean NOT NULL,
  `show_actives` boolean NOT NULL,
  `user_id` integer,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
);

CREATE TABLE `ban_reasons` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `reason` varchar(255) NOT NULL,
  `is_visible` boolean NOT NULL
);

CREATE TABLE `banned_users` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer NOT NULL,
  `ban_reason_id` integer NOT NULL,
  `start_date` timestamp NOT NULL,
  `end_date` timestamp NOT NULL,
  `is_finished` boolean NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
  FOREIGN KEY (`ban_reason_id`) REFERENCES `ban_reasons`(`id`)
);


CREATE TABLE `organization_restriction` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `organization_id` integer NOT NULL,
  `limit_positions` double,
  `global_limit_positions` double,
  `risk_limit` integer,
  `share_information` boolean NOT NULL,
  FOREIGN KEY (`organization_id`) REFERENCES `organizations`(`id`)
);

CREATE TABLE `briefcase` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `user_id` integer NOT NULL,
  `created_at` timestamp NOT NULL,
  `is_active` boolean,
  `enable_social_trading` boolean NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
);

CREATE TABLE `asset_groups` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255),
  `is_enabled` boolean NOT NULL
);

CREATE TABLE `assets` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `market_code` varchar(10) NOT NULL,
  `data_source` varchar(255) NOT NULL,
  `asset_groups_id` integer NOT NULL,
  `is_enabled` boolean NOT NULL,
  FOREIGN KEY (`asset_groups_id`) REFERENCES `asset_groups`(`id`)
);

CREATE TABLE `opened_positions` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `briefcase_id` integer NOT NULL,
  `assed_id` integer NOT NULL,
  `stop_loss` double,
  `take_profit` double,
  `is_sandbox` boolean NOT NULL,
  FOREIGN KEY (`briefcase_id`) REFERENCES `briefcase`(`id`),
  FOREIGN KEY (`assed_id`) REFERENCES `assets`(`id`)
);

CREATE TABLE `transaction` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `created_at` timestamp NOT NULL,
  `transaction_type` integer,
  `quantity` integer NOT NULL,
  `asset_id` integer NOT NULL,
  `price_unit` double NOT NULL,
  `user_id` integer NOT NULL,
  FOREIGN KEY (`asset_id`) REFERENCES `assets`(`id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
);

CREATE TABLE `groups` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(2000) NOT NULL,
  `icon` varchar(255)
);

CREATE TABLE `group_requests` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `group_id` integer NOT NULL,
  `guest_user_id` integer NOT NULL,
  `request_sended_user_id` integer NOT NULL,
  `status` ENUM ('pending', 'rejected', 'waiting', 'accepted') NOT NULL,
  `sended_at` timestamp NOT NULL,
  FOREIGN KEY (`group_id`) REFERENCES `groups`(`id`),
  FOREIGN KEY (`guest_user_id`) REFERENCES `users`(`id`),
  FOREIGN KEY (`request_sended_user_id`) REFERENCES `users`(`id`)
);

CREATE TABLE `membership_types` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `internal_code` varchar(3) NOT NULL
);

CREATE TABLE `group_membership` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `group_id` integer,
  `user_id` integer,
  `membership_type_id` integer,
  FOREIGN KEY (`group_id`) REFERENCES `groups`(`id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
  FOREIGN KEY (`membership_type_id`) REFERENCES `membership_types`(`id`)
);

CREATE TABLE `privacy_levels` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` integer NOT NULL,
  `description` varchar(255) NOT NULL
);

CREATE TABLE `group_settings` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `group_id` integer NOT NULL,
  `privacy_level_id` integer NOT NULL,
  `description` varchar(2000) NOT NULL,
  FOREIGN KEY (`group_id`) REFERENCES `groups`(`id`),
  FOREIGN KEY (`privacy_level_id`) REFERENCES `privacy_levels`(`id`)
);

CREATE TABLE `canals` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `user_created_id` integer NOT NULL,
  `description` varchar(50),
  `created_at` timestamp NOT NULL,
  `group_id` integer NOT NULL,
  `organization_id` integer NOT NULL,
  FOREIGN KEY (`user_created_id`) REFERENCES `users`(`id`),
  FOREIGN KEY (`group_id`) REFERENCES `groups`(`id`),
  FOREIGN KEY (`organization_id`) REFERENCES `organizations`(`id`)
);

CREATE TABLE `group_canal_messages` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer NOT NULL,
  `canal_id` integer NOT NULL,
  `message` varchar(1000) NOT NULL,
  `created_at` timestamp,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
  FOREIGN KEY (`canal_id`) REFERENCES `canals`(`id`)
);

CREATE TABLE `event_types` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `internal_code` varchar(3) NOT NULL
);

CREATE TABLE `history_events` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer NOT NULL,
  `event_type_id` integer NOT NULL,
  `at_datetime` timestamp NOT NULL,
  `description` varchar(2000),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
  FOREIGN KEY (`event_type_id`) REFERENCES `event_types`(`id`)
);

CREATE TABLE `favorite_assets` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer,
  `asset_id` integer,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
  FOREIGN KEY (`asset_id`) REFERENCES `assets`(`id`)
);

CREATE TABLE `social_trading_followers` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer NOT NULL,
  `follower_id` integer NOT NULL,
  `briefcase_id` integer NOT NULL,
  `time_at` timestamp NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
  FOREIGN KEY (`follower_id`) REFERENCES `users`(`id`),
  FOREIGN KEY (`briefcase_id`) REFERENCES `briefcase`(`id`)
);

CREATE TABLE `dashboards_type` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `internal_code` varchar(3) NOT NULL
);

CREATE TABLE `dashboards_briefcase` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `dashboards_type_id` integer NOT NULL,
  `briefcase_id` integer NOT NULL,
  `filter_column` varchar(15) NOT NULL,
  `order` varchar(4) NOT NULL,
  FOREIGN KEY (`dashboards_type_id`) REFERENCES `dashboards_type`(`id`),
  FOREIGN KEY (`briefcase_id`) REFERENCES `briefcase`(`id`)
);

CREATE TABLE `taxes` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `country_id` integer NOT NULL,
  `tax` double NOT NULL,
  FOREIGN KEY (`country_id`) REFERENCES `countrys`(`id`)
);

CREATE TABLE `notifications` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `action` varchar(300) NOT NULL,
  `via_mail` boolean NOT NULL,
  `is_alert` boolean NOT NULL,
  `is_active` boolean NOT NULL,
  `create_at` timestamp NOT NULL,
  `end_time_at` timestamp,
  `user_id` integer NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
);

CREATE TABLE `assets_favorite_assets` (
  `assets_id` integer,
  `favorite_assets_asset_id` integer,
  PRIMARY KEY (`assets_id`, `favorite_assets_asset_id`),
  FOREIGN KEY (`assets_id`) REFERENCES `assets`(`id`),
  FOREIGN KEY (`favorite_assets_asset_id`) REFERENCES `favorite_assets`(`asset_id`)
);

CREATE TABLE `users_favorite_assets` (
  `users_id` integer,
  `favorite_assets_user_id` integer,
  PRIMARY KEY (`users_id`, `favorite_assets_user_id`),
  FOREIGN KEY (`users_id`) REFERENCES `users`(`id`),
  FOREIGN KEY (`favorite_assets_user_id`) REFERENCES `favorite_assets`(`user_id`)
);