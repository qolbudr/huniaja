CREATE TABLE `withdraw` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`ownerId` INT(11) NULL DEFAULT NULL,
	`amount` INT(11) NULL DEFAULT NULL,
	`status` INT(11) NULL DEFAULT NULL,
	`created` DATE NOT NULL,
	`status_change` DATE NULL DEFAULT NULL,
	`description` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=5
;
