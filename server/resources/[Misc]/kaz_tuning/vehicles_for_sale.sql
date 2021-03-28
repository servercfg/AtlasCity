CREATE TABLE IF NOT EXISTS `vehicles_for_sale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sellerid` varchar(50) NOT NULL,
  `description` text CHARACTER SET utf8,
  `price` int(11) NOT NULL DEFAULT '0',
  `model` varchar(255) NOT NULL DEFAULT '',
  `vtype` varchar(255) NOT NULL DEFAULT '',
  `sellername` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

