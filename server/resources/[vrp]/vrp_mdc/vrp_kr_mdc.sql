CREATE TABLE `mdc_incidents` (
	`pk` int(11) NOT NULL AUTO_INCREMENT,
	`number` VARCHAR(255) NULL,
	`text` VARCHAR(255) NULL,
	`uploader` VARCHAR(255) NULL,
	`date` VARCHAR(255) NULL,
	PRIMARY KEY (`pk`)
);

CREATE TABLE `mdc_cardetails` (
	`pk` int(11) NOT NULL AUTO_INCREMENT,
  	`plate` varchar(255) NULL,
 	`owner` varchar(255) NULL,
  	`incident` varchar(255) NOT NULL DEFAULT '{}',
  	`inspected` varchar(255) NULL,
  	`identifier` varchar(255) NULL,
  	PRIMARY KEY (`pk`)
);

CREATE TABLE `mdc_logs` (
	`pk` int(11) NOT NULL AUTO_INCREMENT,
	`type` varchar(255) NULL,
	`remover` varchar(255) NULL,
	`wanted` varchar(255) NULL,
	PRIMARY KEY (`pk`)
);

CREATE TABLE `mdc_efterlysningar` (
	`pk` int(11) NOT NULL AUTO_INCREMENT,
	`wanted` VARCHAR(255) NULL,
	`dob` VARCHAR(255) NULL,
	`crime` VARCHAR(255) NULL,
	`uploader` VARCHAR(255) NULL,
	`date` VARCHAR(255) NULL,
	`incident` VARCHAR(255) NULL,
	PRIMARY KEY (`pk`)
);

CREATE TABLE `kr_criminalrecord` (
  `offense` varchar(160) NOT NULL,
  `date` varchar(255) DEFAULT NULL,
  `institution` varchar(255) DEFAULT NULL,
  `charge` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `term` varchar(255) DEFAULT NULL,
  `classified` int(2) NOT NULL DEFAULT '0',
  `identifier` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `warden` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`offense`)
);

CREATE TABLE `kr_criminaluserinfo` (
  `identifier` varchar(160) NOT NULL,
  `aliases` varchar(255) DEFAULT NULL,
  `recordid` varchar(255) DEFAULT NULL,
  `weight` varchar(255) DEFAULT NULL,
  `eyecolor` varchar(255) DEFAULT NULL,
  `haircolor` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `height` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
);