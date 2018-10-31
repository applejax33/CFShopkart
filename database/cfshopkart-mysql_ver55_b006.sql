/*
SQLyog Community v9.33 GA
MySQL - 5.5.18-log : Database - cfhowto_cfsk
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `accesscodes` */

CREATE TABLE `accesscodes` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `authcode` varchar(50) DEFAULT NULL,
  `pincode` varchar(50) DEFAULT NULL,
  `partnerid` varchar(50) DEFAULT NULL,
  `wasused` varchar(50) DEFAULT '0',
  `username` varchar(255) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `dateused` datetime DEFAULT NULL,
  `dateissued` datetime DEFAULT NULL,
  `maxamount` varchar(50) DEFAULT NULL,
  `ordernumber` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`authcode`,`pincode`,`wasused`,`userid`,`ordernumber`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `accesscodes` */

/*Table structure for table `afl_affiliates` */

CREATE TABLE `afl_affiliates` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DateSignup` datetime DEFAULT NULL,
  `groupid` varchar(150) DEFAULT NULL,
  `accountid` varchar(150) DEFAULT NULL,
  `affiliateid` varchar(150) DEFAULT NULL,
  `Password` varchar(150) DEFAULT NULL,
  `Company` varchar(150) DEFAULT NULL,
  `DateStarted` varchar(45) DEFAULT NULL,
  `FirstName` varchar(150) DEFAULT NULL,
  `LastName` varchar(150) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Phone` varchar(150) DEFAULT NULL,
  `Address1` varchar(150) DEFAULT NULL,
  `Address2` varchar(150) DEFAULT NULL,
  `City` varchar(150) DEFAULT NULL,
  `State` varchar(150) DEFAULT NULL,
  `Zip` varchar(150) DEFAULT NULL,
  `Country` varchar(255) DEFAULT NULL,
  `SiteName` varchar(255) DEFAULT NULL,
  `SiteURL` varchar(255) DEFAULT NULL,
  `SiteDesc` varchar(255) DEFAULT NULL,
  `Commission` double DEFAULT NULL,
  `CheckName` varchar(150) DEFAULT NULL,
  `TaxID` varchar(150) DEFAULT NULL,
  `Level` int(11) DEFAULT NULL,
  `SubAffiliateOf` varchar(255) DEFAULT NULL,
  `SubAffiliate` varchar(60) DEFAULT NULL,
  `CommLevel` varchar(60) DEFAULT NULL,
  `HasPurchased` varchar(60) DEFAULT NULL,
  `Birthdate` varchar(36) DEFAULT NULL,
  `pnumber` varchar(150) DEFAULT NULL,
  `activedate` datetime DEFAULT NULL,
  `earnedpoints` int(11) DEFAULT NULL,
  `earnedcash` double DEFAULT NULL,
  `earnedrewards` double DEFAULT NULL,
  `discounts` double DEFAULT NULL,
  `rebates` double DEFAULT NULL,
  `commissions` double DEFAULT NULL,
  `cellphone` varchar(150) DEFAULT NULL,
  `cellcarrier` varchar(150) DEFAULT NULL,
  `skype` varchar(255) DEFAULT NULL,
  `im` varchar(255) DEFAULT NULL,
  `sms` varchar(255) DEFAULT NULL,
  `hits` int(11) DEFAULT NULL,
  `sales` int(11) DEFAULT NULL,
  `paymethod` varchar(150) DEFAULT NULL,
  `path` longtext,
  `cEarned` double DEFAULT NULL,
  `cPaid` double DEFAULT NULL,
  `cPending` double DEFAULT NULL,
  `photo` varchar(255) DEFAULT 'bio_nopic.png',
  `c_override` varchar(50) DEFAULT '0',
  `c_override_2` varchar(50) DEFAULT '0',
  `c_override_99` varchar(50) DEFAULT '0',
  `c_override_99_2` varchar(50) DEFAULT '0',
  `c_override_199` varchar(50) DEFAULT '0',
  `c_override_199_2` varchar(50) DEFAULT '0',
  `c_override_type` varchar(50) DEFAULT 'flat',
  `c_override_on` varchar(50) DEFAULT 'No',
  `has1099` varchar(50) DEFAULT 'Yes',
  `account_status` varchar(5) DEFAULT '1',
  `contacthours` longtext,
  PRIMARY KEY (`ID`),
  KEY `affiliates` (`groupid`,`affiliateid`,`Password`,`Email`,`SubAffiliateOf`,`has1099`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `afl_affiliates` */

/*Table structure for table `afl_banners` */

CREATE TABLE `afl_banners` (
  `banner_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL DEFAULT '0',
  `type` varchar(10) NOT NULL DEFAULT 'img',
  `location` varchar(124) NOT NULL DEFAULT '',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `descr` text NOT NULL,
  PRIMARY KEY (`banner_id`),
  KEY `affiliateid` (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `afl_banners` */

/*Table structure for table `afl_groupassign` */

CREATE TABLE `afl_groupassign` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `affiliateid` varchar(255) DEFAULT NULL,
  `groupid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`affiliateid`,`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `afl_groupassign` */

/*Table structure for table `afl_groups` */

CREATE TABLE `afl_groups` (
  `groupid` int(10) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`groupid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `afl_groups` */

/*Table structure for table `afl_menu` */

CREATE TABLE `afl_menu` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `link_title` varchar(255) DEFAULT NULL,
  `link_url` longtext,
  `link_target` varchar(255) DEFAULT '_top',
  `ordervalue` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `afl_menu` */

/*Table structure for table `afl_messages` */

CREATE TABLE `afl_messages` (
  `msgid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender` varchar(50) DEFAULT NULL,
  `sendername` varchar(255) DEFAULT NULL,
  `recipient` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `body` text,
  `wasread` varchar(50) DEFAULT NULL,
  `DateSent` varchar(50) DEFAULT NULL,
  `Archived` varchar(50) DEFAULT NULL,
  `SentTo` longtext,
  PRIMARY KEY (`msgid`),
  KEY `NewIndex1` (`sender`,`recipient`,`wasread`,`Archived`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `afl_messages` */

/*Table structure for table `afl_messages_sent` */

CREATE TABLE `afl_messages_sent` (
  `msgid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `body` text,
  `DateSent` varchar(50) NOT NULL DEFAULT '',
  `SentTo` longtext NOT NULL,
  PRIMARY KEY (`msgid`,`DateSent`,`SentTo`(10)),
  KEY `NewIndex1` (`sender`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `afl_messages_sent` */

/*Table structure for table `afl_transactions` */

CREATE TABLE `afl_transactions` (
  `TransID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AffiliateID` varchar(50) DEFAULT NULL,
  `TransDate` date DEFAULT NULL,
  `TransMonth` int(2) DEFAULT NULL,
  `TransYear` int(4) DEFAULT NULL,
  `TransType` int(10) DEFAULT '0',
  `TransDesc` varchar(255) DEFAULT NULL,
  `OrderNumber` varchar(255) DEFAULT NULL,
  `Payout` float(20,4) DEFAULT '0.0000',
  `SaleAmount` float(20,4) DEFAULT '0.0000',
  `OrderStatus` varchar(100) DEFAULT '',
  `Commission` float(20,4) DEFAULT '0.0000',
  `Parent_Affil` int(10) DEFAULT '0',
  `CheckNumber` int(15) DEFAULT NULL,
  `paid` varchar(50) DEFAULT NULL,
  `csv_file` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`TransID`),
  KEY `NewIndex1` (`AffiliateID`,`TransDate`,`TransMonth`,`TransYear`,`CheckNumber`,`paid`,`csv_file`)
) ENGINE=MyISAM AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;

/*Data for the table `afl_transactions` */

/*Table structure for table `blog_admins` */

CREATE TABLE `blog_admins` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `blog_users` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `blog_password` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `blog_admins` */

/*Table structure for table `blog_category` */

CREATE TABLE `blog_category` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `blog_cat_id` varchar(35) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `blog_cat_name` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `blog_category` */

/*Table structure for table `blog_links` */

CREATE TABLE `blog_links` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `blog_link_id` varchar(35) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `blog_link_name` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `blog_link_url` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `blog_links` */

/*Table structure for table `blog_posts` */

CREATE TABLE `blog_posts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `blog_id` varchar(35) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `blog_date` datetime DEFAULT NULL,
  `blog_time` time DEFAULT NULL,
  `blog_year` int(4) NOT NULL DEFAULT '0',
  `blog_month` int(2) NOT NULL DEFAULT '0',
  `blog_headlines` varchar(60) NOT NULL DEFAULT '',
  `blog_contents` text CHARACTER SET latin1,
  `blog_cat` varchar(35) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `urlrw` longtext,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`blog_id`,`blog_date`,`blog_year`,`blog_month`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `blog_posts` */

/*Table structure for table `blog_reply` */

CREATE TABLE `blog_reply` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `reply_id` varchar(35) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `reply_date` date DEFAULT NULL,
  `reply_blog_id` varchar(35) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `reply_email` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `reply_name` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `reply_contents` text CHARACTER SET latin1,
  `display_email` tinyint(1) NOT NULL DEFAULT '1',
  `approved` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`reply_id`,`reply_email`,`approved`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `blog_reply` */

/*Table structure for table `blog_settings` */

CREATE TABLE `blog_settings` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `notify` varchar(50) DEFAULT NULL,
  `notifyemail` varchar(50) DEFAULT NULL,
  `dmc_count` varchar(50) DEFAULT NULL,
  `index_count` varchar(50) DEFAULT NULL,
  `tbacks` varchar(50) DEFAULT NULL,
  `tbacksaccount` varchar(50) DEFAULT NULL,
  `rss_sitename` varchar(255) DEFAULT NULL,
  `rss_sitelink` varchar(255) DEFAULT NULL,
  `rss_sitedescription` varchar(255) DEFAULT NULL,
  `blog_owner` varchar(255) DEFAULT NULL,
  `blog_owner_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `blog_settings` */

insert  into `blog_settings`(`id`,`notify`,`notifyemail`,`dmc_count`,`index_count`,`tbacks`,`tbacksaccount`,`rss_sitename`,`rss_sitelink`,`rss_sitedescription`,`blog_owner`,`blog_owner_email`) values (1,'1','blog@madesomemoney.com','3','4','0','account_name','MadeSomeMoney.com','http://www.yourdomain.com','Make Money Online with MadeSomeMoney.com','Jon Wallen','blog@madesomemoney.com');

/*Table structure for table `brochures` */

CREATE TABLE `brochures` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) DEFAULT NULL,
  `itemid` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`itemid`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `brochures` */

/*Table structure for table `categories` */

CREATE TABLE `categories` (
  `CategoryID` int(10) NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(50) DEFAULT 'Category',
  `CategoryImage` varchar(50) DEFAULT 'None',
  `CategoryRImage` varchar(50) DEFAULT 'None',
  `SubCategoryOf` varchar(50) DEFAULT '0',
  `CategoryPath` longtext,
  `OrderValue` int(10) DEFAULT '1',
  `CategoryLayout` varchar(50) DEFAULT '1',
  `ShowSubCats` varchar(50) DEFAULT 'Yes',
  `Details` longtext,
  `permissions` varchar(50) DEFAULT 'public',
  `ImportKey` varchar(255) DEFAULT NULL,
  `linkimage` varchar(255) DEFAULT 'None',
  `linkrimage` varchar(255) DEFAULT 'None',
  `urlrw` longtext,
  PRIMARY KEY (`CategoryID`),
  KEY `NewIndex1` (`CategoryName`,`SubCategoryOf`,`OrderValue`,`ImportKey`)
) ENGINE=MyISAM AUTO_INCREMENT=100398 DEFAULT CHARSET=latin1;

/*Data for the table `categories` */

insert  into `categories`(`CategoryID`,`CategoryName`,`CategoryImage`,`CategoryRImage`,`SubCategoryOf`,`CategoryPath`,`OrderValue`,`CategoryLayout`,`ShowSubCats`,`Details`,`permissions`,`ImportKey`,`linkimage`,`linkrimage`,`urlrw`) values (100394,'Demo Products 1','None','None','0','/',1,'2','No',NULL,'0',NULL,'None','None','Demo-Products-1-100394'),(100395,'Demo Products 2','None','None','0','/',2,'2','No',NULL,'0',NULL,'None','None','Demo-Products-2-100395'),(100396,'Demo Products 3','None','None','0','/',3,'2','No',NULL,'0',NULL,'None','None','Demo-Products-3-100396'),(100397,'Demo Sub Category','None','None','100394','/100394/',1,'2','No',NULL,'0',NULL,'None','None','Demo-Sub-Category-100394-100397');

/*Table structure for table `cfsk_processors` */

CREATE TABLE `cfsk_processors` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `p_name` varchar(255) DEFAULT NULL,
  `p_displayname` varchar(255) DEFAULT NULL,
  `p_adminname` varchar(255) DEFAULT NULL,
  `p_image` varchar(255) DEFAULT NULL,
  `p_token` varchar(255) DEFAULT NULL,
  `p_user` varchar(255) DEFAULT NULL,
  `p_id` varchar(255) DEFAULT NULL,
  `p_pass` varchar(255) DEFAULT NULL,
  `p_type` varchar(50) DEFAULT 'gateway',
  `p_hash` varchar(255) DEFAULT NULL,
  `p_custom` varchar(255) DEFAULT NULL,
  `use_token` int(5) DEFAULT '0',
  `use_user` int(5) DEFAULT '0',
  `use_id` int(5) DEFAULT '0',
  `use_pass` int(5) DEFAULT '0',
  `use_hash` int(5) DEFAULT '0',
  `use_custom` int(5) DEFAULT '0',
  `use_echecks` int(5) DEFAULT '0',
  `use_testmode` int(5) DEFAULT '0',
  `use_cvs` int(5) DEFAULT '1',
  `custom_name` varchar(255) DEFAULT NULL,
  `test_mode` varchar(50) DEFAULT 'false',
  `store_info` varchar(50) DEFAULT 'No',
  `script_pay` varchar(255) DEFAULT NULL,
  `script_subscribe` varchar(255) DEFAULT NULL,
  `script_callbacks` varchar(255) DEFAULT NULL,
  `script_button` varchar(255) DEFAULT NULL,
  `askforcard` varchar(50) DEFAULT 'No',
  `accept_echecks` varchar(50) DEFAULT 'No',
  `use_this` int(10) DEFAULT '0',
  `instructions` longtext,
  `is_enabled` int(5) DEFAULT '1',
  `allowed_to_storeit` int(5) DEFAULT '0',
  `orders_icon` varchar(255) DEFAULT 'credit_cards_16.gif',
  `ordervalue` int(10) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`p_name`,`use_this`,`is_enabled`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

/*Data for the table `cfsk_processors` */

insert  into `cfsk_processors`(`id`,`p_name`,`p_displayname`,`p_adminname`,`p_image`,`p_token`,`p_user`,`p_id`,`p_pass`,`p_type`,`p_hash`,`p_custom`,`use_token`,`use_user`,`use_id`,`use_pass`,`use_hash`,`use_custom`,`use_echecks`,`use_testmode`,`use_cvs`,`custom_name`,`test_mode`,`store_info`,`script_pay`,`script_subscribe`,`script_callbacks`,`script_button`,`askforcard`,`accept_echecks`,`use_this`,`instructions`,`is_enabled`,`allowed_to_storeit`,`orders_icon`,`ordervalue`) values (1,'2checkoutoptional','Pay Securely Through 2Checkout','2Checkout','2checkout.gif',NULL,NULL,NULL,NULL,'3rdparty',NULL,NULL,0,0,0,0,0,1,0,0,1,'Store Name','false','No',NULL,NULL,NULL,'2checkout.cfm','0','0',0,'<h3>\r\n	Instructions</h3>\r\n<p>\r\n	You will need to specify a return URL in your 2checkout control panel (in the Cart Details section). This return URL will be the complete URL to your secure folder and the index.cfm file.</p>\r\n<p>\r\n	How to do this:</p>\r\n<p>\r\n	1. Login to your account.<br />\r\n	2. Under the &#39;Helpful Links&#39; section, click on &#39;Settings&#39; near the &#39;Look and Feel&#39; section.<br />\r\n	3. Input the proper URL into the approved and pending approval boxes on this page.<br />\r\n	4. Click &#39;Save Changes&#39;.</p>\r\n<p>\r\n	Note: The page you are attempting to pass back to MUST be located within the domain as specified on the contact information page of your account. If your website URL is incorrect and you need it to be changed, you will need to contact 2checkout to change it. The URL you will enter is shown below:</p>\r\n<p>\r\n	Example: http://www.yourdomain.com//index.cfm?action=finalize</p>\r\n',1,0,'credit_cards_16.gif',1),(2,'paypal','Pay Securely With Paypal','PayPal with PDT and IPN','paypal.gif','',NULL,NULL,NULL,'3rdparty',NULL,'',1,0,0,0,0,1,0,1,1,'Business','True','No','','','paypalPDT.cfm','paypal.cfm','0','0',1,'<h3>\r\n	Instructions</h3>\r\n<p>\r\n	If you do not have IPN turned on in your account, you will need to that.&nbsp; If it already is then you don&#39;t need to do anything or change the URL.&nbsp; If you have no URL set then just point it to ipn.cfm in /checkou/listeners/ipn.cfm</p>\r\n<p>\r\n	If you do no have PDT turned on, turn it on and make sure you set auto return to &#39;Yes&quot;.&nbsp; You will be given an identiy token.&nbsp; Insert the identity token into the field called &#39;Token&quot;.&nbsp; If you haven&#39;t set a return url already, set it.&nbsp; Example:<br />\r\n	http://www.yourdomain.com/index.cfm?action=finalize</p>\r\n<p>\r\n	Put in test mode if you want to test your website via the PayPal Sandobx (you must have a PayPal Sandbox test account).</p>\r\n',1,0,'paypal_tiny.gif',1),(3,'paypalpaymentspro','Major Credit Card','PayPal Payments Pro','majorcccard.gif',NULL,NULL,NULL,NULL,'gateway',NULL,NULL,0,1,0,1,0,1,0,1,1,'API Signature','false','No',NULL,NULL,NULL,NULL,'1','0',0,'<h2>\r\n	Instructions</h2>\r\n<p>\r\n	To use the PayPal APIs, you need a set of credentials to identify yourself to PayPal.</p>\r\n<p>\r\n	Create an API signature for your business account. For instructions on setting up API credentials for the business account, go to<br />\r\n	<a href=\"https://www.paypal.com/IntegrationCenter/ic_certificate.html\" target=\"_blank\">https://www.paypal.com/IntegrationCenter/ic_certificate.html</a></p>\r\n',1,0,'credit_cards_16.gif',1),(4,'linkpoint','Major Credit Card','LinkPoint Connect','paymentsbylinkpoint.gif',NULL,NULL,NULL,NULL,'gateway',NULL,NULL,0,0,0,0,0,1,0,1,1,'Store Name','false','No','','','linkpoint.cfm','','0','0',0,'<h3>\r\n	Instructions</h3>\r\n<p>\r\n	In order for LinkPoint Connect to function properly, you will need to complete the following steps.</p>\r\n<p>\r\n	1. Login to your LinkPoint account at https://www.linkpointcentral.com/</p>\r\n<p>\r\n	2. Got to Administration --&gt; Connect Settings</p>\r\n<p>\r\n	3. In Submission Form URL box enter: http://www.<em>yourdomain</em>.com/index.cfm</p>\r\n<p>\r\n	4. In Confirmation Page URL box enter: http://www.<em>yourname</em>.com/index.cfm</p>\r\n<p>\r\n	5. Place a checkmark in the &quot;Url is a CGI Script&quot; box under Confirmation Page.</p>\r\n<p>\r\n	6. You can optionally create and specify a failure/cancel URL which could be the homepage of your website.<br />\r\n	<em>Click the Submit button</em> at the bottom of the page to save your settings</p>\r\n<p>\r\n	7. Go back to the Administration menu and choose &quot;Connect Setup&quot;.</p>\r\n<p>\r\n	8. Under Custom Fields add two fields to pass back (so the system knows what order to update):</p>\r\n<table border=\"0\" cellpadding=\"4\" cellspacing=\"0\" width=\"450\">\r\n	<tbody>\r\n		<tr>\r\n			<td bgcolor=\"#336681\" width=\"5%\">\r\n				<div align=\"center\">\r\n					&nbsp;</div>\r\n			</td>\r\n			<td bgcolor=\"#336681\">\r\n				<div align=\"center\" class=\"style1\">\r\n					Name</div>\r\n			</td>\r\n			<td bgcolor=\"#336681\" width=\"25%\">\r\n				<div align=\"center\" class=\"style1\">\r\n					Make Viewable</div>\r\n			</td>\r\n			<td bgcolor=\"#336681\">\r\n				<div align=\"center\" class=\"style1\">\r\n					Caption</div>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				<div align=\"center\">\r\n					1</div>\r\n			</td>\r\n			<td>\r\n				<div align=\"center\">\r\n					OrderNumber</div>\r\n			</td>\r\n			<td>\r\n				<div align=\"center\">\r\n					X (Yes)</div>\r\n			</td>\r\n			<td>\r\n				<div align=\"center\">\r\n					Order Number</div>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				<div align=\"center\">\r\n					2</div>\r\n			</td>\r\n			<td>\r\n				<div align=\"center\">\r\n					action</div>\r\n			</td>\r\n			<td>\r\n				<div align=\"center\">\r\n					(No)</div>\r\n			</td>\r\n			<td>\r\n				<div align=\"center\">\r\n					[leave blank]</div>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	9. Click the submit button to save your changes.</p>\r\n<p>\r\n	If you still have problems with Linkpoint, make sure the settings above are correct..</p>\r\n',1,0,'credit_cards_16.gif',1),(6,'psigate','Pay Securely Through PSIGate','PSIGate','majorcccard.gif',NULL,NULL,NULL,NULL,'3rdparty',NULL,NULL,0,0,0,0,0,1,0,0,1,'Merchant ID','false','No',NULL,NULL,NULL,NULL,'0','0',0,'<br />\r\n',1,0,'credit_cards_16.gif',1),(7,'skipjack','Pay Securely Through SkipJack','SkipJack','majorcccard.gif',NULL,NULL,NULL,NULL,'gateway',NULL,NULL,0,0,0,0,0,1,0,0,1,'Serial Number','false','No','','','','','0','0',0,'<h3>\r\n	Instructions</h3>\r\n<p>\r\n	You will need to specify a backend response URL for SkipJack. To update your Backend Response URL, login to your Skipjack account, select Preferences, then Response Files. Scroll down to the section &quot;Backend Response URL.&quot;</p>\r\n',0,0,'credit_cards_16.gif',1),(8,'yourpay','Major Credit Card','YourPay Connect','majorcccard.gif',NULL,NULL,NULL,NULL,'gateway',NULL,NULL,0,0,0,0,0,1,0,1,1,'Store Name','false','No',NULL,NULL,NULL,NULL,'1','0',0,'<h3>\r\n	Instructions</h3>\r\n<p>\r\n	In order for YourPay Connect to function properly, you will need to complete the following steps.</p>\r\n<p>\r\n	1. Login to your YourPay account at https://www.linkpointcentral.com/</p>\r\n<p>\r\n	2. Got to Administration --&gt; Connect Settings</p>\r\n<p>\r\n	3. In Submission Form URL box enter: http://www.<em>yourdomain</em>.com/index.cfm</p>\r\n<p>\r\n	4. In Confirmation Page URL box enter: http://www.<em>yourdomain</em>.com/index.cfm</p>\r\n<p>\r\n	5. Place a checkmark in the &quot;Url is a CGI Script&quot; box under Confirmation Page.</p>\r\n<p>\r\n	6. You can optionally create and specify a failure/cancel URL which could be the homepage of your website.<br />\r\n	<em>Click the Submit button</em> at the bottom of the page to save your settings</p>\r\n<p>\r\n	7. Go back to the Administration menu and choose &quot;Connect Setup&quot;.</p>\r\n<p>\r\n	8. Under Custom Fields add two fields to pass back (so the system knows what order to update):</p>\r\n<table border=\"0\" cellpadding=\"4\" cellspacing=\"0\" width=\"450\">\r\n	<tbody>\r\n		<tr>\r\n			<td bgcolor=\"#336681\" width=\"5%\">\r\n				<div align=\"center\">\r\n					&nbsp;</div>\r\n			</td>\r\n			<td bgcolor=\"#336681\">\r\n				<div align=\"center\" class=\"style1\">\r\n					Name</div>\r\n			</td>\r\n			<td bgcolor=\"#336681\" width=\"25%\">\r\n				<div align=\"center\" class=\"style1\">\r\n					Make Viewable</div>\r\n			</td>\r\n			<td bgcolor=\"#336681\">\r\n				<div align=\"center\" class=\"style1\">\r\n					Caption</div>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				<div align=\"center\">\r\n					1</div>\r\n			</td>\r\n			<td>\r\n				<div align=\"center\">\r\n					OrderNumber</div>\r\n			</td>\r\n			<td>\r\n				<div align=\"center\">\r\n					X (Yes)</div>\r\n			</td>\r\n			<td>\r\n				<div align=\"center\">\r\n					Order Number</div>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				<div align=\"center\">\r\n					2</div>\r\n			</td>\r\n			<td>\r\n				<div align=\"center\">\r\n					action</div>\r\n			</td>\r\n			<td>\r\n				<div align=\"center\">\r\n					(No)</div>\r\n			</td>\r\n			<td>\r\n				<div align=\"center\">\r\n					[leave blank]</div>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	9. Click the submit button to save your changes.</p>\r\n<p>\r\n	If you still have problems with YourPay, make sure the settings above are correct..</p>\r\n',1,0,'credit_cards_16.gif',1),(10,'authorizenet','Major Credit Card','Authorize.Net','majorcccard.gif','','',NULL,NULL,'gateway','',NULL,1,1,0,0,1,0,0,1,1,'','True','No','pauthorizenet.cfm','pauthorizenet_p.cfm','pauthorizenet.cfm','','1','0',0,'<h3>\r\n	<strong>Setup Instructions</strong></h3>\r\n<p style=\"font-weight: bold;\">\r\n	To obtain your API Login ID (Username):</p>\r\n<ol type=\"1\">\r\n	<li>\r\n		<p>\r\n			Log into the Merchant Interface at <a href=\"https://secure.authorize.net/\" target=\"_blank\">https://secure.authorize.net</a></p>\r\n	</li>\r\n	<li>\r\n		<p>\r\n			Select Settings under Account in the main menu on the left</p>\r\n	</li>\r\n	<li>\r\n		<p>\r\n			Click API Login ID and Transaction Key in the Security Settings section</p>\r\n	</li>\r\n	<li>\r\n		<p>\r\n			If you have not already obtained an API Login ID and Transaction Key for your account, you will need to enter the secret answer to the secret question you configured at account activation.</p>\r\n	</li>\r\n	<li>\r\n		<p>\r\n			Click Submit.</p>\r\n	</li>\r\n</ol>\r\n<p>\r\n	The API Login ID for your account is displayed on the API Login ID and Transaction Key page.</p>\r\n<p>\r\n	It is highly recommended that you reset your API Login ID regularly, such as every six months, to strengthen the security of your payment gateway account. To reset your API Login ID you will need to contact Authorize.Net Customer Support. You will then need to enter the API Login ID into the settings above and Save them.</p>\r\n<p style=\"font-weight: bold;\">\r\n	To obtain your Transaction Key (Token):</p>\r\n<ol type=\"1\">\r\n	<li>\r\n		<p>\r\n			Log into the Merchant Interface at <a href=\"https://secure.authorize.net/\" target=\"_blank\">https://secure.authorize.net</a></p>\r\n	</li>\r\n	<li>\r\n		<p>\r\n			Select Settings under Account in the main menu on the left</p>\r\n	</li>\r\n	<li>\r\n		<p>\r\n			Click API Login ID and Transaction Key in the Security Settings section</p>\r\n	</li>\r\n	<li>\r\n		<p>\r\n			Enter the secret answer to the secret question you configured when you activated your user account</p>\r\n	</li>\r\n	<li>\r\n		<p>\r\n			Click Submit</p>\r\n	</li>\r\n</ol>\r\n<p style=\"font-weight: bold;\">\r\n	To configure an MD5 Hash value for your account (Hash Value):</p>\r\n<ol type=\"1\">\r\n	<li>\r\n		<p>\r\n			Log into the Merchant Interface at <a href=\"https://secure.authorize.net/\" target=\"_blank\">https://secure.authorize.net</a></p>\r\n	</li>\r\n	<li>\r\n		<p>\r\n			Click Settings under Account in the main menu on the left</p>\r\n	</li>\r\n	<li>\r\n		<p>\r\n			Click MD5-Hash in the Security Settings section</p>\r\n	</li>\r\n	<li>\r\n		<p>\r\n			Enter any random value to use for your MD5 Hash Value. Enter the value again to confirm</p>\r\n	</li>\r\n	<li>\r\n		<p>\r\n			Click Submit</p>\r\n	</li>\r\n</ol>\r\n',1,0,'credit_cards_16.gif',1),(17,'payflowlink','Major Credit Card','PayFlow Link',NULL,NULL,NULL,NULL,NULL,'gateway',NULL,NULL,0,1,0,0,0,1,0,0,1,'Partner ID','false','No','','','','','0','No',0,'<h3>\r\n	<strong>Instructions</strong></h3>\r\n<p>\r\n	For Payflow Link to be more secure, you can login to your Payflow Link account and update the settings for restricted URLs. Enter your <strong>Submission Form URL </strong> link:</p>\r\n<p>\r\n	Enter you Login in the User field and Patner ID above.</p>\r\n<p>\r\n	http://www.<em>yourdomain</em>.com//index.cfm?action=finalize</p>\r\n',1,0,'credit_cards_16.gif',1),(11,'payflowpro','Major Credit Card','PayFlow Pro','',NULL,NULL,NULL,NULL,'gateway',NULL,NULL,0,1,0,1,0,1,0,1,1,'Partner ID','false','No','ppayflowpro.cfm','','','','1','0',0,'<p>\r\n	Put your Login in the Username field.</p>\r\n',1,0,'credit_cards_16.gif',1),(13,'moneris','Major Credit Card','Moneris',NULL,NULL,NULL,NULL,NULL,'gateway',NULL,NULL,1,0,0,0,0,0,0,0,0,'Store ID','false','No','pmoneris.cfm','','','','0','No',0,'',1,0,'credit_cards_16.gif',1),(16,'processoffline','Major Credit Card','Process Offline',NULL,NULL,NULL,NULL,NULL,'gateway',NULL,NULL,0,0,0,0,0,0,0,0,1,'','false','Yes','poffline.cfm','','','','1','No',1,'<p>\r\n	This processor requires no setup. Cards will be stored encrypted in your database so that you can retrieve them and then process them offline.&nbsp; It is NOT recommended that you use this payment method.&nbsp; You should ask your processing company if they offer a gateway to process credit cards on the internet.</p>\r\n',1,0,'credit_cards_16.gif',1),(22,'paypalexpress','Pay Securely Through PayPal','PayPal Express','paypal.gif',NULL,'43A61961D6D57C771AFC1DEAEAC046F1BAB1869C6B5E0B08985C9FA170EF8FB6969FB5988691',NULL,'1A9A2207BFD2151C1DF8768397BA52D2','3rdparty',NULL,'68A7425094D6043C41F8698E889D4EA796B988B6517D73128A53D8E45EF98193DDD9F9C3D99696AE5884C158A478D09995A58C9E2604A709',0,1,0,1,0,1,0,1,1,'API Signature','true','No','paypalexpress.cfm','','paypalexpress.cfm','paypalexpress.cfm','0','No',0,'<p>\r\n	PayPal Express is an alternative to using PayPal Standard.&nbsp; You must have a Business or Premier Account to use it.&nbsp; To set this up:</p>\r\n<p>\r\n	1. Go to your Profile in your PayPal Account.&nbsp; Click <strong>API Access</strong> under <strong>Account Information</strong></p>\r\n<p>\r\n	2. Click the <strong>Request API Credentials</strong></p>\r\n<p>\r\n	3. Select <strong>Request API Signature</strong></p>\r\n<p>\r\n	4.&nbsp; Copy and Past the credentials into the matching fields.</p>\r\n<p style=\"margin-left: 40px;\">\r\n	API Username goes in the User Field<br />\r\n	API Password goes in&nbsp; the Password Field<br />\r\n	Signature goes in the API Signature Field.</p>\r\n<p>\r\n	5. Back in your PayPal account click on the <strong>Done</strong> button.</p>\r\n<p>\r\n	6. Click on the link <strong>Enable Express Checkout</strong></p>\r\n<p>\r\n	7. If you are NOT using this PayPal account on any other website then choose <strong>Block payments from uncredentialed shopping carts </strong>and click<strong> Submit.</strong></p>\r\n',1,0,'paypal_tiny.gif',1),(26,'ponumber','PO Number','PO Number','',NULL,NULL,NULL,NULL,'3rdparty',NULL,NULL,0,0,0,0,0,0,0,0,1,'','false','No','ponumber.cfm','','ponumber.cfm','','0','No',0,'<p>\r\n	This processor has no settings.</p>\r\n',1,0,'credit_cards_16.gif',999),(25,'checkormoneyorder','Check or Money Order','Check or Money Order','checkmoneyorder.gif',NULL,NULL,NULL,NULL,'3rdparty',NULL,NULL,0,0,0,0,0,0,0,0,1,'','false','No','checkormoneyorder.cfm','','checkormoneyorder.cfm','','0','No',0,'<p>\r\n	This processor has no settings that need to be configured.</p>\r\n',1,0,'credit_cards_16.gif',1);

/*Table structure for table `comments` */

CREATE TABLE `comments` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `poster_name` varchar(255) DEFAULT NULL,
  `poster_email` varchar(255) DEFAULT NULL,
  `comment` longtext,
  `replyto` varchar(50) DEFAULT NULL,
  `approved` varchar(10) DEFAULT '0',
  `post_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `comments` */

/*Table structure for table `companyinfo` */

CREATE TABLE `companyinfo` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `CompanyName` varchar(255) DEFAULT NULL,
  `FirstName` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Apt` varchar(255) DEFAULT NULL,
  `City` varchar(255) DEFAULT NULL,
  `State` varchar(255) DEFAULT NULL,
  `Zip` varchar(150) DEFAULT NULL,
  `Country` varchar(255) DEFAULT NULL,
  `PhoneNumber1` varchar(150) DEFAULT NULL,
  `PhoneNumber2` varchar(150) DEFAULT NULL,
  `EmailAddress` varchar(150) DEFAULT NULL,
  `LicenseID` varchar(255) DEFAULT NULL,
  `contactname` varchar(255) DEFAULT NULL,
  `storename` varchar(255) DEFAULT NULL,
  `memberid` varchar(255) DEFAULT NULL,
  `parentstorename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `companyinfo` */

insert  into `companyinfo`(`id`,`CompanyName`,`FirstName`,`LastName`,`Address`,`Apt`,`City`,`State`,`Zip`,`Country`,`PhoneNumber1`,`PhoneNumber2`,`EmailAddress`,`LicenseID`,`contactname`,`storename`,`memberid`,`parentstorename`) values (1,'Your Company Name','Firstname','Lastname','Address','','City','OH','44444','US','888-888-8888','','pleasechangetoyouremail@cfshopkart.com','cfshopkart','Your Name',NULL,NULL,NULL);

/*Table structure for table `components` */

CREATE TABLE `components` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `urlrw` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `components` */

insert  into `components`(`id`,`name`,`action`,`urlrw`) values (1,'Home Page','loadhomepage','home'),(2,'Show Blog','blog_default','blog'),(3,'View Cart','view','viewcart'),(4,'Checkout','checkout','storecheckout'),(8,'Account Logout','logout','logout'),(5,'Contact Form','contactform_show','contactform'),(11,'Site Map','sitemap','sitemap'),(10,'Best Sellers','showbestsellers','bestsellers'),(6,'Affiliates','affiliates_default','affiliates'),(9,'Featured Items','showfeatured','featureditems'),(7,'My Account','myaccount','myaccount'),(14,'View Wish List','editwishlist','viewwishlist'),(15,'View Comments','comments','comments');

/*Table structure for table `contactform_data` */

CREATE TABLE `contactform_data` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `from_name` varchar(255) DEFAULT NULL,
  `from_email` varchar(255) DEFAULT NULL,
  `from_phone` varchar(255) DEFAULT NULL,
  `from_message` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`from_email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `contactform_data` */

/*Table structure for table `contactform_settings` */

CREATE TABLE `contactform_settings` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `emails_goto` varchar(255) DEFAULT NULL,
  `send_emails` varchar(50) DEFAULT 'Yes',
  `store_indb` varchar(50) DEFAULT 'Yes',
  `UseDefaultServer` varchar(50) DEFAULT 'Yes',
  `UseMailServer` varchar(255) DEFAULT NULL,
  `UseMailLogin` varchar(50) DEFAULT 'No',
  `mailuser` varchar(255) DEFAULT NULL,
  `mailpassword` varchar(255) DEFAULT NULL,
  `usecaptcha` varchar(255) DEFAULT 'No',
  `thanks_page` varchar(255) DEFAULT 'thankyou.cfm',
  `subject_line` varchar(255) DEFAULT 'Contact Form Response',
  `captcha_difficulty` varchar(50) DEFAULT 'medium',
  `mailserver` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `contactform_settings` */

insert  into `contactform_settings`(`id`,`emails_goto`,`send_emails`,`store_indb`,`UseDefaultServer`,`UseMailServer`,`UseMailLogin`,`mailuser`,`mailpassword`,`usecaptcha`,`thanks_page`,`subject_line`,`captcha_difficulty`,`mailserver`) values (1,'','Yes','No','Yes','No','No','','','Yes','','Contact Form Response','Low','');

/*Table structure for table `contacts` */

CREATE TABLE `contacts` (
  `ContactID` int(10) NOT NULL AUTO_INCREMENT,
  `CompanyName` varchar(255) DEFAULT NULL,
  `FirstName` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `City` varchar(255) DEFAULT NULL,
  `StateOrProvince` varchar(50) DEFAULT NULL,
  `PostalCode` varchar(20) DEFAULT NULL,
  `PhoneNumber` varchar(255) DEFAULT NULL,
  `PhoneExtension` varchar(20) DEFAULT NULL,
  `MobilePhone` varchar(255) DEFAULT NULL,
  `FaxNumber` varchar(255) DEFAULT NULL,
  `EmailAddress` varchar(255) DEFAULT NULL,
  `InternetSite` varchar(255) DEFAULT NULL,
  `Notes` longtext,
  PRIMARY KEY (`ContactID`),
  KEY `NewIndex1` (`CompanyName`,`LastName`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `contacts` */

/*Table structure for table `countries` */

CREATE TABLE `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `countryCode` varchar(50) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `showthis` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`showthis`,`countryCode`)
) ENGINE=MyISAM AUTO_INCREMENT=195 DEFAULT CHARSET=latin1;

/*Data for the table `countries` */

insert  into `countries`(`id`,`countryCode`,`Country`,`showthis`) values (2,'AL','Albania','Yes'),(3,'AS','American Samoa','Yes'),(4,'AD','Andorra','Yes'),(5,'AO','Angola','Yes'),(6,'AI','Anguilla','Yes'),(7,'AG','Antigua/Barbuda','Yes'),(8,'AR','Argentina','Yes'),(9,'AM','Armenia','Yes'),(10,'AW','Aruba','Yes'),(11,'AU','Australia','Yes'),(12,'AT','Austria','Yes'),(13,'AZ','Azerbaijan','Yes'),(14,'BS','Bahamas','Yes'),(15,'BH','Bahrain','Yes'),(16,'BD','Bangladesh','Yes'),(17,'BB','Barbados','Yes'),(18,'BY','Belarus','Yes'),(19,'BE','Belgium','Yes'),(20,'BZ','Belize','Yes'),(21,'BJ','Benin','Yes'),(22,'BM','Bermuda','Yes'),(23,'BT','Bhutan','Yes'),(24,'BO','Bolivia','Yes'),(25,'BA','Bosnia-Herzegovina','Yes'),(26,'BW','Botswana','Yes'),(27,'BR','Brazil','Yes'),(28,'VG','British Virgin Islands','Yes'),(29,'BN','Brunei','Yes'),(30,'BG','Bulgaria','Yes'),(31,'BF','Burkina Faso','Yes'),(32,'BI','Burundi','Yes'),(33,'KH','Cambodia','Yes'),(34,'CM','Cameroon','Yes'),(35,'CA','Canada','Yes'),(36,'CV','Cape Verde','Yes'),(37,'KY','Cayman Islands','Yes'),(38,'TD','Chad','Yes'),(39,'CL','Chile','Yes'),(40,'CN','China','Yes'),(41,'CO','Colombia','Yes'),(42,'CG','Congo Brazzaville','Yes'),(43,'CD','Congo Democratic Rep of','Yes'),(44,'CK','Cook Islands','Yes'),(45,'CR','Costa Rica','Yes'),(46,'HR','Croatia','Yes'),(47,'CY','Cyprus','Yes'),(48,'CZ','Czech Republic','Yes'),(49,'DK','Denmark','Yes'),(50,'DJ','Djibouti','Yes'),(51,'DM','Dominica','Yes'),(52,'DO','Dominican Republic','Yes'),(53,'EC','Ecuador','Yes'),(54,'EG','Egypt','Yes'),(55,'SV','El Salvador','Yes'),(56,'GQ','Equatorial Guinea','Yes'),(57,'ER','Eritrea','Yes'),(58,'EE','Estonia','Yes'),(59,'ET','Ethiopia','Yes'),(60,'FO','Faeroe Islands','Yes'),(61,'FJ','Fiji','Yes'),(62,'FI','Finland','Yes'),(63,'FR','France','Yes'),(64,'GF','French Guiana','Yes'),(65,'PF','French Polynesia','Yes'),(66,'GA','Gabon','Yes'),(67,'GM','Gambia','Yes'),(68,'GE','Georgia','Yes'),(69,'DE','Germany','Yes'),(70,'GH','Ghana','Yes'),(71,'GI','Gibraltar','Yes'),(72,'GR','Greece','Yes'),(73,'GL','Greenland','Yes'),(74,'GD','Grenada','Yes'),(75,'GP','Guadeloupe','Yes'),(76,'GU','Guam','Yes'),(77,'GT','Guatemala','Yes'),(78,'GN','Guinea','Yes'),(79,'GY','Guyana','Yes'),(80,'HT','Haiti','Yes'),(81,'HN','Honduras','Yes'),(82,'HK','Hong Kong','Yes'),(83,'HU','Hungary','Yes'),(84,'IS','Iceland','Yes'),(85,'IN','India','Yes'),(86,'ID','Indonesia','Yes'),(87,'IE','Ireland','Yes'),(88,'IL','Israel','Yes'),(89,'IT','Italy/Vatican City','Yes'),(90,'CI','Ivory Coast','Yes'),(91,'JM','Jamaica','Yes'),(92,'JP','Japan','Yes'),(93,'JO','Jordan','Yes'),(94,'KZ','Kazakhstan','Yes'),(95,'KE','Kenya','Yes'),(96,'KW','Kuwait','Yes'),(97,'KG','Kyrgyzstan','Yes'),(98,'LA','Laos','Yes'),(99,'LV','Latvia','Yes'),(100,'LB','Lebanon','Yes'),(101,'LS','Lesotho','Yes'),(102,'LR','Liberia','Yes'),(103,'LI','Liechtenstein','Yes'),(104,'LT','Lithuania','Yes'),(105,'LU','Luxembourg','Yes'),(106,'MO','Macau','Yes'),(107,'MK','Macedonia','Yes'),(108,'MW','Malawi','Yes'),(109,'MY','Malaysia','Yes'),(110,'MV','Maldives','Yes'),(111,'ML','Mali','Yes'),(112,'MT','Malta','Yes'),(113,'MH','Marshall Islands','Yes'),(114,'MQ','Martinique','Yes'),(115,'MR','Mauritania','Yes'),(116,'MU','Mauritius','Yes'),(117,'MX','Mexico','Yes'),(118,'FM','Micronesia','Yes'),(119,'MD','Moldova','Yes'),(120,'MC','Monaco','Yes'),(121,'MN','Mongolia','Yes'),(122,'MS','Montserrat','Yes'),(123,'MA','Morocco','Yes'),(124,'MZ','Mozambique','Yes'),(125,'NA','Namibia','Yes'),(126,'NP','Nepal','Yes'),(127,'NL','Netherlands','Yes'),(128,'AN','Netherlands Antilles','Yes'),(129,'NC','New Caledonia','Yes'),(130,'NZ','New Zealand','Yes'),(131,'NI','Nicaragua','Yes'),(132,'NE','Niger','Yes'),(133,'NG','Nigeria','Yes'),(134,'NO','Norway','Yes'),(135,'OM','Oman','Yes'),(136,'PK','Pakistan','Yes'),(137,'PW','Palau','Yes'),(138,'PS','Palestine Autonomous','Yes'),(139,'PA','Panama','Yes'),(140,'PG','Papua New Guinea','Yes'),(141,'PY','Paraguay','Yes'),(142,'PE','Peru','Yes'),(143,'PH','Philippines','Yes'),(144,'PL','Poland','Yes'),(145,'PT','Portugal','Yes'),(146,'PR','Puerto Rico','Yes'),(147,'QA','Qatar','Yes'),(148,'RE','Reunion','Yes'),(149,'RO','Romania','Yes'),(150,'RU','Russian Federation','Yes'),(151,'RW','Rwanda','Yes'),(152,'MP','Saipan','Yes'),(153,'SA','Saudi Arabia','Yes'),(154,'SN','Senegal','Yes'),(155,'SC','Seychelles','Yes'),(156,'SG','Singapore','Yes'),(157,'SK','Slovak Republic','Yes'),(158,'SI','Slovenia','Yes'),(159,'ZA','South Africa','Yes'),(160,'KR','South Korea','Yes'),(161,'ES','Spain','Yes'),(162,'LK','Sri Lanka','Yes'),(163,'KN','St. Kitts/Nevis','Yes'),(164,'LC','St. Lucia','Yes'),(165,'VC','St. Vincent','Yes'),(166,'SR','Suriname','Yes'),(167,'SZ','Swaziland','Yes'),(168,'SE','Sweden','Yes'),(169,'CH','Switzerland','Yes'),(170,'SY','Syria','Yes'),(171,'TW','Taiwan','Yes'),(172,'TZ','Tanzania','Yes'),(173,'TH','Thailand','Yes'),(174,'TG','Togo','Yes'),(175,'TT','Trinidad/Tobago','Yes'),(176,'TN','Tunisia','Yes'),(177,'TR','Turkey','Yes'),(178,'TM','Turkmenistan','Yes'),(179,'TC','Turks & Caicos Islands','Yes'),(180,'VI','U.S. Virgin Islands','Yes'),(181,'US','United States','Yes'),(182,'UG','Uganda','Yes'),(183,'UA','Ukraine','Yes'),(184,'AE','United Arab Emirates','Yes'),(185,'GB','United Kingdom','Yes'),(186,'UY','Uruguay','Yes'),(187,'UZ','Uzbekistan','Yes'),(188,'VU','Vanuatu','Yes'),(189,'VE','Venezuela','Yes'),(190,'VN','Vietnam','Yes'),(191,'WF','Wallis &amp; Futuna','Yes'),(192,'YE','Yemen','Yes'),(193,'YU','Yugoslavia','Yes'),(194,'ZM','Zambia','Yes');

/*Table structure for table `creditapps` */

CREATE TABLE `creditapps` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `request_date` date DEFAULT NULL,
  `biz_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `work` varchar(255) DEFAULT NULL,
  `cell` varchar(255) DEFAULT NULL,
  `yearsinbiz` varchar(255) DEFAULT NULL,
  `dbrate` varchar(255) DEFAULT NULL,
  `trade_name1` varchar(255) DEFAULT NULL,
  `trade_name2` varchar(255) DEFAULT NULL,
  `trade_name3` varchar(255) DEFAULT NULL,
  `telephone1` varchar(255) DEFAULT NULL,
  `telephone2` varchar(255) DEFAULT NULL,
  `telephone3` varchar(255) DEFAULT NULL,
  `account1` varchar(255) DEFAULT NULL,
  `account2` varchar(255) DEFAULT NULL,
  `account3` varchar(255) DEFAULT NULL,
  `creditline` varchar(255) DEFAULT NULL,
  `terms` varchar(255) DEFAULT NULL,
  `approved` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `amount` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `reason` longtext,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`approved`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `creditapps` */

/*Table structure for table `custom_buttons` */

CREATE TABLE `custom_buttons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `button_name` varchar(255) DEFAULT NULL,
  `image_file` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`button_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `custom_buttons` */

insert  into `custom_buttons`(`id`,`button_name`,`image_file`) values (1,'AddToCart','add_to_cart.gif'),(2,'UpdateCart','button_update_cart.gif'),(3,'SearchButton','button_search.gif'),(4,'CheckoutButton','button_checkout.gif'),(5,'ReviewOrder','button_continue_checkout.gif'),(6,'ProcessOrder','button_confirm_order.gif'),(7,'PrintButton','print.gif'),(8,'LoginButton','button_login.gif'),(9,'ContinueShopping','button_continue_shopping.gif');

/*Table structure for table `customerhistory` */

CREATE TABLE `customerhistory` (
  `CustomerID` int(10) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `BusinessName` varchar(50) DEFAULT NULL,
  `Address` longtext,
  `Address2` longtext,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `Country` longtext,
  `ZipCode` varchar(50) DEFAULT NULL,
  `PhoneNumber` varchar(50) DEFAULT NULL,
  `EmailAddress` varchar(50) NOT NULL DEFAULT '',
  `CreditCardType` varchar(50) DEFAULT NULL,
  `CreditCardNumber` varchar(50) DEFAULT NULL,
  `CreditCardExpire` varchar(50) DEFAULT NULL,
  `CCConfirmationNumber` varchar(50) DEFAULT NULL,
  `ShippingMethod` varchar(50) DEFAULT NULL,
  `Txn_id` varchar(50) NOT NULL DEFAULT '',
  `Payment_status` varchar(50) NOT NULL DEFAULT '',
  `Pending_reason` varchar(50) DEFAULT NULL,
  `PayPalFee` varchar(50) DEFAULT NULL,
  `First_name` varchar(50) DEFAULT NULL,
  `Last_name` varchar(50) DEFAULT NULL,
  `Address_status` varchar(50) DEFAULT NULL,
  `Receiver_email` varchar(50) DEFAULT NULL,
  `Payer_status` varchar(50) DEFAULT NULL,
  `Payment_type` varchar(50) DEFAULT NULL,
  `For_auction` varchar(50) DEFAULT NULL,
  `Invoice` varchar(50) DEFAULT NULL,
  `Custom` varchar(50) DEFAULT NULL,
  `Memo` longtext,
  `ShipFirstName` varchar(50) DEFAULT NULL,
  `ShipLastName` varchar(50) DEFAULT NULL,
  `ShipBusinessName` varchar(50) DEFAULT NULL,
  `ShipAddress` longtext,
  `ShipAddress2` longtext,
  `ShipCity` varchar(50) DEFAULT NULL,
  `ShipState` varchar(50) DEFAULT NULL,
  `ShipZip` varchar(50) DEFAULT NULL,
  `ShipCountry` varchar(50) DEFAULT NULL,
  `CustPassword` varchar(50) NOT NULL DEFAULT '',
  `repstore` varchar(255) DEFAULT NULL,
  `pricelevel` int(10) DEFAULT '0',
  `referrals` int(10) DEFAULT '0',
  `gateway_tid` varchar(255) NOT NULL DEFAULT '',
  `gateway_sid` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`CustomerID`,`EmailAddress`,`Txn_id`,`Payment_status`,`CustPassword`,`gateway_tid`,`gateway_sid`),
  KEY `NewIndex1` (`EmailAddress`,`CustPassword`)
) ENGINE=MyISAM AUTO_INCREMENT=124 DEFAULT CHARSET=latin1;

/*Data for the table `customerhistory` */

/*Table structure for table `customers_subscriptions` */

CREATE TABLE `customers_subscriptions` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `r_id` varchar(50) DEFAULT NULL,
  `customerid` varchar(50) DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `cardnumber` varchar(255) DEFAULT NULL,
  `cardcode` varchar(50) DEFAULT NULL,
  `cardexpiremonth` varchar(50) DEFAULT NULL,
  `cardexpireyear` varchar(50) DEFAULT NULL,
  `lastbilledon` varchar(50) DEFAULT NULL,
  `ordernumber` varchar(255) DEFAULT NULL,
  `expiredate` date DEFAULT NULL,
  `subscription_length` varchar(255) DEFAULT NULL,
  `pricing_level` varchar(50) DEFAULT '0',
  `payment_status` varchar(50) DEFAULT 'None',
  `gateway_sid` varchar(255) DEFAULT NULL,
  `gateway_tid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `NewIndex1` (`r_id`,`customerid`,`status`,`pricing_level`,`payment_status`,`gateway_sid`,`gateway_tid`),
  KEY `NewIndex2` (`ordernumber`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

/*Data for the table `customers_subscriptions` */

/*Table structure for table `customstyles` */

CREATE TABLE `customstyles` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `TextColor_Highlight` varchar(50) DEFAULT NULL,
  `TextColor_Normal` varchar(50) DEFAULT NULL,
  `TextColor_Links` varchar(50) DEFAULT NULL,
  `TextColor_LinksHover` varchar(50) DEFAULT NULL,
  `TextColor_Navbar` varchar(50) DEFAULT NULL,
  `TextColor_NavbarLinks` varchar(50) DEFAULT NULL,
  `TextColor_NavbarLinksHover` varchar(50) DEFAULT NULL,
  `TextColor_Widget` varchar(255) DEFAULT NULL,
  `TextColor_WidgetLinks` varchar(50) DEFAULT NULL,
  `TextColor_WidgetLinksHover` varchar(50) DEFAULT NULL,
  `TextColor_WidgetTitles` varchar(50) DEFAULT NULL,
  `TextColor_Header` varchar(50) DEFAULT NULL,
  `TextColor_Footer` varchar(50) DEFAULT NULL,
  `TextColor_CategoryTitles` varchar(50) DEFAULT NULL,
  `TextColor_H3` varchar(50) DEFAULT NULL,
  `TextColor_H4` varchar(50) DEFAULT NULL,
  `Textcolor_H2` varchar(50) DEFAULT NULL,
  `Textcolor_H1` varchar(50) DEFAULT NULL,
  `Textcolor_Price` varchar(50) DEFAULT NULL,
  `Textcolor_Wholesale` varchar(50) DEFAULT NULL,
  `Textcolor_ListPrice` varchar(50) DEFAULT NULL,
  `Textcolor_FormFields` varchar(50) DEFAULT NULL,
  `Textcolor_Options` varchar(50) DEFAULT NULL,
  `Textcolor_OptionsTitles` varchar(50) DEFAULT NULL,
  `Textcolor_ColumnHeaders` varchar(50) DEFAULT NULL,
  `TextSize_Normal` varchar(50) DEFAULT NULL,
  `TextSize_Links` varchar(50) DEFAULT NULL,
  `TextSize_H3` varchar(50) DEFAULT NULL,
  `TextSize_H4` varchar(50) DEFAULT NULL,
  `TextSize_H2` varchar(50) DEFAULT NULL,
  `TextSize_H5` varchar(50) DEFAULT NULL,
  `TextSize_LinksHover` varchar(50) DEFAULT NULL,
  `TextSize_ColumnHeaders` varchar(50) DEFAULT NULL,
  `TextSize_WidgetTitles` varchar(50) DEFAULT NULL,
  `TextSize_Widget` varchar(50) DEFAULT NULL,
  `TextSize_WidgetLinks` varchar(50) DEFAULT NULL,
  `TextSize_WidgetLinksHover` varchar(50) DEFAULT NULL,
  `TextSize_FormFields` varchar(50) DEFAULT NULL,
  `TextSize_Price` varchar(50) DEFAULT NULL,
  `TextSize_WholesalePrice` varchar(50) DEFAULT NULL,
  `TextSize_ListPrice` varchar(50) DEFAULT NULL,
  `TextSize_Options` varchar(50) DEFAULT NULL,
  `TextSize_OptionsTitles` varchar(50) DEFAULT NULL,
  `TextSize_CategoryTitles` varchar(50) DEFAULT NULL,
  `TextSize_Header` varchar(50) DEFAULT NULL,
  `TextSize_Footer` varchar(50) DEFAULT NULL,
  `TextSize_Navbar` varchar(50) DEFAULT NULL,
  `TextSize_NavbarLinks` varchar(50) DEFAULT NULL,
  `TextSize_NavbarLinksHover` varchar(50) DEFAULT NULL,
  `Font_normal` varchar(255) DEFAULT NULL,
  `Font_links` varchar(255) DEFAULT NULL,
  `Font_linkshover` varchar(255) DEFAULT NULL,
  `Font_Navbar` varchar(255) DEFAULT NULL,
  `Font_NavbarLinks` varchar(255) DEFAULT NULL,
  `Font_NavbarLinksHover` varchar(255) DEFAULT NULL,
  `Font_Widget` varchar(255) DEFAULT NULL,
  `Font_WidgetTitles` varchar(255) DEFAULT NULL,
  `Font_WidgetLink` varchar(255) DEFAULT NULL,
  `Font_WidgetLinkHover` varchar(255) DEFAULT NULL,
  `Font_ColumnHeaders` varchar(255) DEFAULT NULL,
  `Font_H2` varchar(255) DEFAULT NULL,
  `Font_h3` varchar(255) DEFAULT NULL,
  `Font_h4` varchar(255) DEFAULT NULL,
  `Font_h5` varchar(255) DEFAULT NULL,
  `Font_Price` varchar(255) DEFAULT NULL,
  `Font_WholesalePrice` varchar(255) DEFAULT NULL,
  `Font_ListPrice` varchar(255) DEFAULT NULL,
  `Font_Options` varchar(255) DEFAULT NULL,
  `Font_OptionsTitles` varchar(255) DEFAULT NULL,
  `Font_Header` varchar(255) DEFAULT NULL,
  `Font_Footer` varchar(255) DEFAULT NULL,
  `Font_CategoryTitles` varchar(255) DEFAULT NULL,
  `Font_FormFields` varchar(255) DEFAULT NULL,
  `bgColor_Website` varchar(50) DEFAULT NULL,
  `bgColor_Header` varchar(50) DEFAULT NULL,
  `bgColor_Footer` varchar(50) DEFAULT NULL,
  `bgColor_WidgetColumn` varchar(50) DEFAULT NULL,
  `bgColor_body` varchar(50) DEFAULT NULL,
  `bgColor_Links` varchar(50) DEFAULT NULL,
  `bgColor_LinksHover` varchar(50) DEFAULT NULL,
  `bgColor_WidgetTitles` varchar(50) DEFAULT NULL,
  `bgColor_Widget` varchar(50) DEFAULT NULL,
  `bgColor_WidgetFooters` varchar(50) DEFAULT NULL,
  `bgColor_Navbar` varchar(50) DEFAULT NULL,
  `bgColor_WidgetLinks` varchar(50) DEFAULT NULL,
  `bgColor_WidgetLinksHover` varchar(50) DEFAULT NULL,
  `bgColor_NavbarLinks` varchar(50) DEFAULT NULL,
  `bgColor_NavbarLinksHover` varchar(50) DEFAULT NULL,
  `bgColor_OptionsTitles` varchar(50) DEFAULT NULL,
  `bgColor_Options` varchar(50) DEFAULT NULL,
  `bgColor_FormFields` varchar(50) DEFAULT NULL,
  `bgColor_CategoryTitles` varchar(50) DEFAULT NULL,
  `bgColor_ColumnHeaders` varchar(50) DEFAULT NULL,
  `bgImage_Header` longtext,
  `bgImage_Footer` longtext,
  `bgImage_Website` longtext,
  `bgImage_CategoryTitles` longtext,
  `bgImage_Navbar` longtext,
  `bgImage_WidgetTitles` longtext,
  `bgImage_Widget` longtext,
  `bgImage_ColumnHeaders` longtext,
  `bgImage_WidgetFooters` longtext,
  `border_contentsize` varchar(50) DEFAULT NULL,
  `border_contentcolor` varchar(50) DEFAULT NULL,
  `border_contentstyle` varchar(50) DEFAULT NULL,
  `border_widgetboxsize` varchar(50) DEFAULT NULL,
  `border_widgetboxcolor` varchar(50) DEFAULT NULL,
  `border_widgetboxstyle` varchar(50) DEFAULT NULL,
  `contentshadowonoff` varchar(50) DEFAULT NULL,
  `Width_Container` varchar(50) DEFAULT NULL,
  `Width_WidgetColumn` varchar(50) DEFAULT NULL,
  `Width_SearchBox` varchar(50) DEFAULT NULL,
  `Height_Header` varchar(50) DEFAULT NULL,
  `Height_Footer` varchar(50) DEFAULT NULL,
  `Height_Body` varchar(50) DEFAULT NULL,
  `Height_NavBar` varchar(50) DEFAULT NULL,
  `Height_ColumnHeaders` varchar(50) DEFAULT NULL,
  `Height_WidgetTitle` varchar(50) DEFAULT NULL,
  `Height_WidgetBody` varchar(50) DEFAULT NULL,
  `Display_NavBar` varchar(50) DEFAULT NULL,
  `Display_WidgetColumn` varchar(50) DEFAULT NULL,
  `Display_Header` varchar(50) DEFAULT NULL,
  `Display_Footer` varchar(50) DEFAULT NULL,
  `Display_Search` varchar(50) DEFAULT NULL,
  `Align_Container` varchar(50) DEFAULT NULL,
  `Align_Header` varchar(50) DEFAULT NULL,
  `Align_Footer` varchar(50) DEFAULT NULL,
  `Align_WidgetTitles` varchar(50) DEFAULT NULL,
  `Align_ColumnTitles` varchar(50) DEFAULT NULL,
  `FontWeight_Normal` varchar(50) DEFAULT NULL,
  `FontWeight_Links` varchar(50) DEFAULT NULL,
  `FontWeight_LinksHover` varchar(50) DEFAULT NULL,
  `FontWeight_NavBar` varchar(50) DEFAULT NULL,
  `FontWeight_NavBarLinks` varchar(50) DEFAULT NULL,
  `FontWeight_NavBarLinksHover` varchar(50) DEFAULT NULL,
  `FontWeight_WidgetTitles` varchar(50) DEFAULT NULL,
  `FontWeight_Widget` varchar(50) DEFAULT NULL,
  `FontWeight_WidgetLinks` varchar(50) DEFAULT NULL,
  `FontWeight_WidgetLinksHover` varchar(50) DEFAULT NULL,
  `FontWeight_FormFields` varchar(50) DEFAULT NULL,
  `FontWeight_OptionsTitles` varchar(50) DEFAULT NULL,
  `FontWeight_Price` varchar(50) DEFAULT NULL,
  `FontWeight_CategoryTitles` varchar(50) DEFAULT NULL,
  `FontWeight_WholesalePrice` varchar(50) DEFAULT NULL,
  `FontWeight_ListPrice` varchar(50) DEFAULT NULL,
  `FontWeight_h2` varchar(50) DEFAULT NULL,
  `FontWeight_h3` varchar(50) DEFAULT NULL,
  `FontWeight_h4` varchar(50) DEFAULT NULL,
  `FontWeight_h5` varchar(50) DEFAULT NULL,
  `FontWeight_ColumnHeaders` varchar(50) DEFAULT NULL,
  `TextDecor_Links` varchar(50) DEFAULT NULL,
  `TextDecor_LinksHover` varchar(50) DEFAULT NULL,
  `TextDecor_WidgetLinks` varchar(50) DEFAULT NULL,
  `TextDecor_WidgetLinksHover` varchar(50) DEFAULT NULL,
  `TextDecor_NavBarLinks` varchar(50) DEFAULT NULL,
  `TextDecor_NavBarLinksHover` varchar(50) DEFAULT NULL,
  `FontStyle_NavBar` varchar(50) DEFAULT NULL,
  `FontStyle_NavBarLinks` varchar(50) DEFAULT NULL,
  `FontStyle_NavBarLinksHover` varchar(50) DEFAULT NULL,
  `FontStyle_WidgetTitles` varchar(50) DEFAULT NULL,
  `FontStyle_WidgetLinks` varchar(50) DEFAULT NULL,
  `FontStyle_WidgetLinksHover` varchar(50) DEFAULT NULL,
  `FontStyle_CategoryTitles` varchar(50) DEFAULT NULL,
  `FontStyle_Price` varchar(50) DEFAULT NULL,
  `FontStyle_WholesalePrice` varchar(50) DEFAULT NULL,
  `FontStyle_ListPrice` varchar(50) DEFAULT NULL,
  `FontStyle_OptionsTitles` varchar(50) DEFAULT NULL,
  `FontStyle_ColumnHeaders` varchar(50) DEFAULT NULL,
  `FontStyle_FormFields` varchar(50) DEFAULT NULL,
  `bgColor_SelectRow` varchar(50) DEFAULT NULL,
  `TextColor_SelectRow` varchar(50) DEFAULT NULL,
  `header_bgposition` varchar(50) DEFAULT NULL,
  `footer_bgposition` varchar(50) DEFAULT NULL,
  `header_bgrepeat` varchar(50) DEFAULT NULL,
  `footer_bgrepeat` varchar(50) DEFAULT NULL,
  `site_bgposition` varchar(50) DEFAULT NULL,
  `site_bgrepeat` varchar(50) DEFAULT NULL,
  `site_bgvposition` varchar(50) DEFAULT NULL,
  `shadowstrength` varchar(50) DEFAULT NULL,
  `shadowwidth` varchar(50) DEFAULT NULL,
  `CustomStyles` longtext,
  `action` varchar(255) DEFAULT NULL,
  `submitbutton` varchar(255) DEFAULT NULL,
  `themetouse` varchar(255) DEFAULT NULL,
  `bodyshadow` varchar(255) DEFAULT NULL,
  `widget_title_pad` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `customstyles` */

insert  into `customstyles`(`ID`,`TextColor_Highlight`,`TextColor_Normal`,`TextColor_Links`,`TextColor_LinksHover`,`TextColor_Navbar`,`TextColor_NavbarLinks`,`TextColor_NavbarLinksHover`,`TextColor_Widget`,`TextColor_WidgetLinks`,`TextColor_WidgetLinksHover`,`TextColor_WidgetTitles`,`TextColor_Header`,`TextColor_Footer`,`TextColor_CategoryTitles`,`TextColor_H3`,`TextColor_H4`,`Textcolor_H2`,`Textcolor_H1`,`Textcolor_Price`,`Textcolor_Wholesale`,`Textcolor_ListPrice`,`Textcolor_FormFields`,`Textcolor_Options`,`Textcolor_OptionsTitles`,`Textcolor_ColumnHeaders`,`TextSize_Normal`,`TextSize_Links`,`TextSize_H3`,`TextSize_H4`,`TextSize_H2`,`TextSize_H5`,`TextSize_LinksHover`,`TextSize_ColumnHeaders`,`TextSize_WidgetTitles`,`TextSize_Widget`,`TextSize_WidgetLinks`,`TextSize_WidgetLinksHover`,`TextSize_FormFields`,`TextSize_Price`,`TextSize_WholesalePrice`,`TextSize_ListPrice`,`TextSize_Options`,`TextSize_OptionsTitles`,`TextSize_CategoryTitles`,`TextSize_Header`,`TextSize_Footer`,`TextSize_Navbar`,`TextSize_NavbarLinks`,`TextSize_NavbarLinksHover`,`Font_normal`,`Font_links`,`Font_linkshover`,`Font_Navbar`,`Font_NavbarLinks`,`Font_NavbarLinksHover`,`Font_Widget`,`Font_WidgetTitles`,`Font_WidgetLink`,`Font_WidgetLinkHover`,`Font_ColumnHeaders`,`Font_H2`,`Font_h3`,`Font_h4`,`Font_h5`,`Font_Price`,`Font_WholesalePrice`,`Font_ListPrice`,`Font_Options`,`Font_OptionsTitles`,`Font_Header`,`Font_Footer`,`Font_CategoryTitles`,`Font_FormFields`,`bgColor_Website`,`bgColor_Header`,`bgColor_Footer`,`bgColor_WidgetColumn`,`bgColor_body`,`bgColor_Links`,`bgColor_LinksHover`,`bgColor_WidgetTitles`,`bgColor_Widget`,`bgColor_WidgetFooters`,`bgColor_Navbar`,`bgColor_WidgetLinks`,`bgColor_WidgetLinksHover`,`bgColor_NavbarLinks`,`bgColor_NavbarLinksHover`,`bgColor_OptionsTitles`,`bgColor_Options`,`bgColor_FormFields`,`bgColor_CategoryTitles`,`bgColor_ColumnHeaders`,`bgImage_Header`,`bgImage_Footer`,`bgImage_Website`,`bgImage_CategoryTitles`,`bgImage_Navbar`,`bgImage_WidgetTitles`,`bgImage_Widget`,`bgImage_ColumnHeaders`,`bgImage_WidgetFooters`,`border_contentsize`,`border_contentcolor`,`border_contentstyle`,`border_widgetboxsize`,`border_widgetboxcolor`,`border_widgetboxstyle`,`contentshadowonoff`,`Width_Container`,`Width_WidgetColumn`,`Width_SearchBox`,`Height_Header`,`Height_Footer`,`Height_Body`,`Height_NavBar`,`Height_ColumnHeaders`,`Height_WidgetTitle`,`Height_WidgetBody`,`Display_NavBar`,`Display_WidgetColumn`,`Display_Header`,`Display_Footer`,`Display_Search`,`Align_Container`,`Align_Header`,`Align_Footer`,`Align_WidgetTitles`,`Align_ColumnTitles`,`FontWeight_Normal`,`FontWeight_Links`,`FontWeight_LinksHover`,`FontWeight_NavBar`,`FontWeight_NavBarLinks`,`FontWeight_NavBarLinksHover`,`FontWeight_WidgetTitles`,`FontWeight_Widget`,`FontWeight_WidgetLinks`,`FontWeight_WidgetLinksHover`,`FontWeight_FormFields`,`FontWeight_OptionsTitles`,`FontWeight_Price`,`FontWeight_CategoryTitles`,`FontWeight_WholesalePrice`,`FontWeight_ListPrice`,`FontWeight_h2`,`FontWeight_h3`,`FontWeight_h4`,`FontWeight_h5`,`FontWeight_ColumnHeaders`,`TextDecor_Links`,`TextDecor_LinksHover`,`TextDecor_WidgetLinks`,`TextDecor_WidgetLinksHover`,`TextDecor_NavBarLinks`,`TextDecor_NavBarLinksHover`,`FontStyle_NavBar`,`FontStyle_NavBarLinks`,`FontStyle_NavBarLinksHover`,`FontStyle_WidgetTitles`,`FontStyle_WidgetLinks`,`FontStyle_WidgetLinksHover`,`FontStyle_CategoryTitles`,`FontStyle_Price`,`FontStyle_WholesalePrice`,`FontStyle_ListPrice`,`FontStyle_OptionsTitles`,`FontStyle_ColumnHeaders`,`FontStyle_FormFields`,`bgColor_SelectRow`,`TextColor_SelectRow`,`header_bgposition`,`footer_bgposition`,`header_bgrepeat`,`footer_bgrepeat`,`site_bgposition`,`site_bgrepeat`,`site_bgvposition`,`shadowstrength`,`shadowwidth`,`CustomStyles`,`action`,`submitbutton`,`themetouse`,`bodyshadow`,`widget_title_pad`) values (1,NULL,'#000000','#333399','#000000','#000000','#000000','#336600','#000000','#990099','#FA7507','#FFFFFF','#000000','#FFFFFF',NULL,NULL,NULL,NULL,NULL,'#009900',NULL,'','','#000000','','#FFFFFF','12px','12px',NULL,NULL,NULL,NULL,NULL,'12px','12px','12px','12px',NULL,'12px','12pt','14pt','14pt',NULL,'12px',NULL,NULL,NULL,'12px','12px',NULL,'Geneva, Arial, Helvetica, sans-serif','Geneva, Arial, Helvetica, sans-serif',NULL,'Geneva, Arial, Helvetica, sans-serif','Geneva, Arial, Helvetica, sans-serif',NULL,'Geneva, Arial, Helvetica, sans-serif','Verdana, Arial, Helvetica, sans-serif','Geneva, Arial, Helvetica, sans-serif',NULL,'Geneva, Arial, Helvetica, sans-serif',NULL,NULL,NULL,NULL,'Geneva, Arial, Helvetica, sans-serif','Geneva, Arial, Helvetica, sans-serif','Geneva, Arial, Helvetica, sans-serif',NULL,'Geneva, Arial, Helvetica, sans-serif',NULL,NULL,NULL,'Geneva, Arial, Helvetica, sans-serif','#FFFFFF','#192C64','#192C64','#FFFFFF','#FFFFFF','','#FA7507','#FA7507','#FFFFFF','','','','','','','','',' #FA750',NULL,'#192C64','','','',NULL,'images/navbarbgwithshadow2.png','images/index09.gif',' ','',' ','0px','#000000',NULL,'1px','#990000',NULL,NULL,'1024px','200px',NULL,'','50px',NULL,'45px','0','30px',NULL,'block',NULL,NULL,NULL,NULL,'center',NULL,NULL,'left',NULL,NULL,'normal',NULL,'normal','bold',NULL,'bold','normal','normal','normal','normal','bold','bold',NULL,'normal','normal',NULL,NULL,NULL,NULL,'normal','none','underline','none','underline','none','underline',NULL,NULL,NULL,'normal',NULL,NULL,NULL,'normal','normal','normal','italics',NULL,'normal',NULL,NULL,'left','left','repeat-x','no-repeat','center','repeat','top','50','25',' \r\n','UpdateColors','Update Style Settings','sky_blue','On','6px');

/*Table structure for table `discounts` */

CREATE TABLE `discounts` (
  `DiscountID` int(10) NOT NULL AUTO_INCREMENT,
  `DiscountType` varchar(50) DEFAULT NULL,
  `AmountOff` varchar(50) DEFAULT NULL,
  `MinQ` int(10) DEFAULT NULL,
  `ItemID` varchar(50) DEFAULT NULL,
  `level` int(10) DEFAULT '0',
  PRIMARY KEY (`DiscountID`),
  KEY `NewIndex1` (`DiscountType`,`MinQ`,`ItemID`,`level`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;

/*Data for the table `discounts` */

/*Table structure for table `errorlog` */

CREATE TABLE `errorlog` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `errordetail` longtext,
  `errordate` datetime DEFAULT NULL,
  `brief` longtext,
  `submitted` varchar(50) DEFAULT NULL,
  `resolution` longtext,
  `resolved` varchar(50) DEFAULT 'No',
  `support_id` varchar(255) DEFAULT NULL,
  `errorid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`resolved`,`errorid`)
) ENGINE=MyISAM AUTO_INCREMENT=9341 DEFAULT CHARSET=latin1;

/*Data for the table `errorlog` */

insert  into `errorlog`(`id`,`errordetail`,`errordate`,`brief`,`submitted`,`resolution`,`resolved`,`support_id`,`errorid`) values (9340,'\r\n<style>\r\ntd,th{font:11px verdana;}\r\nth{text-align:left;font-weight:bold;background-color:#EEE;}\r\nth,td{vertical-align:top;}\r\n</style>\r\n<h4>Error Report</h4>\r\n<table cellpadding=\"5\" cellspacing=\"1\" border=\"0\" width=\"100%\">\r\n	<tr>\r\n		<th>Date:</th>\r\n		<td>5/2/12 7:50 PM</td>\r\n	</tr>\r\n	<tr>\r\n		<th>URL:</th>\r\n		<td> \r\n			<a href=\"http:cfskdemo.cfhowto.com/index.cfm?carttoken=XPQ23SW050212070532&action=ViewDetails&ItemID=13704&category=100394&viewby=ordervalue&sortorder=ASC\">http:cfskdemo.cfhowto.com/index.cfm?carttoken=XPQ23SW050212070532&action=ViewDetails&ItemID=13704&category=100394&viewby=ordervalue&sortorder=ASC</a>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<th>Visitor IP:</th>\r\n		<td>98.28.95.219\r\n	  </td>\r\n	</tr>    \r\n	<tr>\r\n		<th>Browser:</th>\r\n		<td>Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0\r\n	  </td>\r\n	</tr>   \r\n	<tr>\r\n		<th>Application:</th>\r\n		<td></td>\r\n	</tr>\r\n	\r\n		<tr>\r\n			<th>Message:</th>\r\n			<td> <style>\r\n\r\n\r\n	table.cfdump_wddx,\r\n	table.cfdump_xml,\r\n	table.cfdump_struct,\r\n	table.cfdump_varundefined,\r\n	table.cfdump_array,\r\n	table.cfdump_query,\r\n	table.cfdump_cfc,\r\n	table.cfdump_object,\r\n	table.cfdump_binary,\r\n	table.cfdump_udf,\r\n	table.cfdump_udfbody,\r\n	table.cfdump_udfarguments {\r\n		font-size: xx-small;\r\n		font-family: verdana, arial, helvetica, sans-serif;\r\n		cell-spacing: 2px;\r\n	}\r\n\r\n	table.cfdump_wddx th,\r\n	table.cfdump_xml th,\r\n	table.cfdump_struct th,\r\n	table.cfdump_varundefined th,\r\n	table.cfdump_array th,\r\n	table.cfdump_query th,\r\n	table.cfdump_cfc th,\r\n	table.cfdump_object th,\r\n	table.cfdump_binary th,\r\n	table.cfdump_udf th,\r\n	table.cfdump_udfbody th,\r\n	table.cfdump_udfarguments th {\r\n		text-align: left;\r\n		color: white;\r\n		padding: 5px;\r\n	}\r\n\r\n	table.cfdump_wddx td,\r\n	table.cfdump_xml td,\r\n	table.cfdump_struct td,\r\n	table.cfdump_varundefined  td,\r\n	table.cfdump_array td,\r\n	table.cfdump_query td,\r\n	table.cfdump_cfc td,\r\n	table.cfdump_object td,\r\n	table.cfdump_binary td,\r\n	table.cfdump_udf td,\r\n	table.cfdump_udfbody td,\r\n	table.cfdump_udfarguments td {\r\n		padding: 3px;\r\n		background-color: #ffffff;\r\n		vertical-align : top;\r\n	}\r\n\r\n	table.cfdump_wddx {\r\n		background-color: #000000;\r\n	}\r\n	table.cfdump_wddx th.wddx {\r\n		background-color: #444444;\r\n	}\r\n\r\n\r\n	table.cfdump_xml {\r\n		background-color: #888888;\r\n	}\r\n	table.cfdump_xml th.xml {\r\n		background-color: #aaaaaa;\r\n	}\r\n	table.cfdump_xml td.xml {\r\n		background-color: #dddddd;\r\n	}\r\n\r\n	table.cfdump_struct {\r\n		background-color: #0000cc ;\r\n	}\r\n	table.cfdump_struct th.struct {\r\n		background-color: #4444cc ;\r\n	}\r\n	table.cfdump_struct td.struct {\r\n		background-color: #ccddff;\r\n	}\r\n\r\n	table.cfdump_varundefined {\r\n		background-color: #CC3300 ;\r\n	}\r\n	table.cfdump_varundefined th.varundefined {\r\n		background-color: #CC3300 ;\r\n	}\r\n	table.cfdump_varundefined td.varundefined {\r\n		background-color: #ccddff;\r\n	}\r\n\r\n	table.cfdump_array {\r\n		background-color: #006600 ;\r\n	}\r\n	table.cfdump_array th.array {\r\n		background-color: #009900 ;\r\n	}\r\n	table.cfdump_array td.array {\r\n		background-color: #ccffcc ;\r\n	}\r\n\r\n	table.cfdump_query {\r\n		background-color: #884488 ;\r\n	}\r\n	table.cfdump_query th.query {\r\n		background-color: #aa66aa ;\r\n	}\r\n	table.cfdump_query td.query {\r\n		background-color: #ffddff ;\r\n	}\r\n\r\n\r\n	table.cfdump_cfc {\r\n		background-color: #ff0000;\r\n	}\r\n	table.cfdump_cfc th.cfc{\r\n		background-color: #ff4444;\r\n	}\r\n	table.cfdump_cfc td.cfc {\r\n		background-color: #ffcccc;\r\n	}\r\n\r\n\r\n	table.cfdump_object {\r\n		background-color : #ff0000;\r\n	}\r\n	table.cfdump_object th.object{\r\n		background-color: #ff4444;\r\n	}\r\n\r\n	table.cfdump_binary {\r\n		background-color : #eebb00;\r\n	}\r\n	table.cfdump_binary th.binary {\r\n		background-color: #ffcc44;\r\n	}\r\n	table.cfdump_binary td {\r\n		font-size: x-small;\r\n	}\r\n	table.cfdump_udf {\r\n		background-color: #aa4400;\r\n	}\r\n	table.cfdump_udf th.udf {\r\n		background-color: #cc6600;\r\n	}\r\n	table.cfdump_udfarguments {\r\n		background-color: #dddddd;\r\n		cell-spacing: 3;\r\n	}\r\n	table.cfdump_udfarguments th {\r\n		background-color: #eeeeee;\r\n		color: #000000;\r\n	}\r\n\r\n</style> <script language=\"javascript\">\r\n\r\n\r\n// for queries we have more than one td element to collapse/expand\r\n	var expand = \"open\";\r\n\r\n	dump = function( obj ) {\r\n		var out = \"\" ;\r\n		if ( typeof obj == \"object\" ) {\r\n			for ( key in obj ) {\r\n				if ( typeof obj[key] != \"function\" ) out += key + \': \' + obj[key] + \'<br>\' ;\r\n			}\r\n		}\r\n	}\r\n\r\n\r\n	cfdump_toggleRow = function(source) {\r\n		//target is the right cell\r\n		if(document.all) target = source.parentElement.cells[1];\r\n		else {\r\n			var element = null;\r\n			var vLen = source.parentNode.childNodes.length;\r\n			for(var i=vLen-1;i>0;i--){\r\n				if(source.parentNode.childNodes[i].nodeType == 1){\r\n					element = source.parentNode.childNodes[i];\r\n					break;\r\n				}\r\n			}\r\n			if(element == null)\r\n				target = source.parentNode.lastChild;\r\n			else\r\n				target = element;\r\n		}\r\n		//target = source.parentNode.lastChild ;\r\n		cfdump_toggleTarget( target, cfdump_toggleSource( source ) ) ;\r\n	}\r\n\r\n	cfdump_toggleXmlDoc = function(source) {\r\n\r\n		var caption = source.innerHTML.split( \' [\' ) ;\r\n\r\n		// toggle source (header)\r\n		if ( source.style.fontStyle == \'italic\' ) {\r\n			// closed -> short\r\n			source.style.fontStyle = \'normal\' ;\r\n			source.innerHTML = caption[0] + \' [short version]\' ;\r\n			source.title = \'click to maximize\' ;\r\n			switchLongToState = \'closed\' ;\r\n			switchShortToState = \'open\' ;\r\n		} else if ( source.innerHTML.indexOf(\'[short version]\') != -1 ) {\r\n			// short -> full\r\n			source.innerHTML = caption[0] + \' [long version]\' ;\r\n			source.title = \'click to collapse\' ;\r\n			switchLongToState = \'open\' ;\r\n			switchShortToState = \'closed\' ;\r\n		} else {\r\n			// full -> closed\r\n			source.style.fontStyle = \'italic\' ;\r\n			source.title = \'click to expand\' ;\r\n			source.innerHTML = caption[0] ;\r\n			switchLongToState = \'closed\' ;\r\n			switchShortToState = \'closed\' ;\r\n		}\r\n\r\n		// Toggle the target (everething below the header row).\r\n		// First two rows are XMLComment and XMLRoot - they are part\r\n		// of the long dump, the rest are direct children - part of the\r\n		// short dump\r\n		if(document.all) {\r\n			var table = source.parentElement.parentElement ;\r\n			for ( var i = 1; i < table.rows.length; i++ ) {\r\n				target = table.rows[i] ;\r\n				if ( i < 3 ) cfdump_toggleTarget( target, switchLongToState ) ;\r\n				else cfdump_toggleTarget( target, switchShortToState ) ;\r\n			}\r\n		}\r\n		else {\r\n			var table = source.parentNode.parentNode ;\r\n			var row = 1;\r\n			for ( var i = 1; i < table.childNodes.length; i++ ) {\r\n				target = table.childNodes[i] ;\r\n				if( target.style ) {\r\n					if ( row < 3 ) {\r\n						cfdump_toggleTarget( target, switchLongToState ) ;\r\n					} else {\r\n						cfdump_toggleTarget( target, switchShortToState ) ;\r\n					}\r\n					row++;\r\n				}\r\n			}\r\n		}\r\n	}\r\n\r\n	cfdump_toggleTable = function(source) {\r\n\r\n		var switchToState = cfdump_toggleSource( source ) ;\r\n		if(document.all) {\r\n			var table = source.parentElement.parentElement ;\r\n			for ( var i = 1; i < table.rows.length; i++ ) {\r\n				target = table.rows[i] ;\r\n				cfdump_toggleTarget( target, switchToState ) ;\r\n			}\r\n		}\r\n		else {\r\n			var table = source.parentNode.parentNode ;\r\n			for ( var i = 1; i < table.childNodes.length; i++ ) {\r\n				target = table.childNodes[i] ;\r\n				if(target.style) {\r\n					cfdump_toggleTarget( target, switchToState ) ;\r\n				}\r\n			}\r\n		}\r\n	}\r\n\r\n	cfdump_toggleSource = function( source ) {\r\n		if ( source.style.fontStyle == \'italic\' || source.style.fontStyle == null) {\r\n			source.style.fontStyle = \'normal\' ;\r\n			source.title = \'click to collapse\' ;\r\n			return \'open\' ;\r\n		} else {\r\n			source.style.fontStyle = \'italic\' ;\r\n			source.title = \'click to expand\' ;\r\n			return \'closed\' ;\r\n		}\r\n	}\r\n\r\n	cfdump_toggleTarget = function( target, switchToState ) {\r\n		if ( switchToState == \'open\' )	target.style.display = \'\' ;\r\n		else target.style.display = \'none\' ;\r\n	}\r\n\r\n	// collapse all td elements for queries\r\n	cfdump_toggleRow_qry = function(source) {\r\n		expand = (source.title == \"click to collapse\") ? \"closed\" : \"open\";\r\n		if(document.all) {\r\n			var nbrChildren = source.parentElement.cells.length;\r\n			if(nbrChildren > 1){\r\n				for(i=nbrChildren-1;i>0;i--){\r\n					target = source.parentElement.cells[i];\r\n					cfdump_toggleTarget( target,expand ) ;\r\n					cfdump_toggleSource_qry(source);\r\n				}\r\n			}\r\n			else {\r\n				//target is the right cell\r\n				target = source.parentElement.cells[1];\r\n				cfdump_toggleTarget( target, cfdump_toggleSource( source ) ) ;\r\n			}\r\n		}\r\n		else{\r\n			var target = null;\r\n			var vLen = source.parentNode.childNodes.length;\r\n			for(var i=vLen-1;i>1;i--){\r\n				if(source.parentNode.childNodes[i].nodeType == 1){\r\n					target = source.parentNode.childNodes[i];\r\n					cfdump_toggleTarget( target,expand );\r\n					cfdump_toggleSource_qry(source);\r\n				}\r\n			}\r\n			if(target == null){\r\n				//target is the last cell\r\n				target = source.parentNode.lastChild;\r\n				cfdump_toggleTarget( target, cfdump_toggleSource( source ) ) ;\r\n			}\r\n		}\r\n	}\r\n\r\n	cfdump_toggleSource_qry = function(source) {\r\n		if(expand == \"closed\"){\r\n			source.title = \"click to expand\";\r\n			source.style.fontStyle = \"italic\";\r\n		}\r\n		else{\r\n			source.title = \"click to collapse\";\r\n			source.style.fontStyle = \"normal\";\r\n		}\r\n	}\r\n\r\n</script> Element ITEMID is undefined in QRYOPTION. </td>\r\n		</tr>\r\n\r\n        \r\n		<tr>\r\n			<th>Type:</th>\r\n			<td> <style>\r\n\r\n\r\n	table.cfdump_wddx,\r\n	table.cfdump_xml,\r\n	table.cfdump_struct,\r\n	table.cfdump_varundefined,\r\n	table.cfdump_array,\r\n	table.cfdump_query,\r\n	table.cfdump_cfc,\r\n	table.cfdump_object,\r\n	table.cfdump_binary,\r\n	table.cfdump_udf,\r\n	table.cfdump_udfbody,\r\n	table.cfdump_udfarguments {\r\n		font-size: xx-small;\r\n		font-family: verdana, arial, helvetica, sans-serif;\r\n		cell-spacing: 2px;\r\n	}\r\n\r\n	table.cfdump_wddx th,\r\n	table.cfdump_xml th,\r\n	table.cfdump_struct th,\r\n	table.cfdump_varundefined th,\r\n	table.cfdump_array th,\r\n	table.cfdump_query th,\r\n	table.cfdump_cfc th,\r\n	table.cfdump_object th,\r\n	table.cfdump_binary th,\r\n	table.cfdump_udf th,\r\n	table.cfdump_udfbody th,\r\n	table.cfdump_udfarguments th {\r\n		text-align: left;\r\n		color: white;\r\n		padding: 5px;\r\n	}\r\n\r\n	table.cfdump_wddx td,\r\n	table.cfdump_xml td,\r\n	table.cfdump_struct td,\r\n	table.cfdump_varundefined  td,\r\n	table.cfdump_array td,\r\n	table.cfdump_query td,\r\n	table.cfdump_cfc td,\r\n	table.cfdump_object td,\r\n	table.cfdump_binary td,\r\n	table.cfdump_udf td,\r\n	table.cfdump_udfbody td,\r\n	table.cfdump_udfarguments td {\r\n		padding: 3px;\r\n		background-color: #ffffff;\r\n		vertical-align : top;\r\n	}\r\n\r\n	table.cfdump_wddx {\r\n		background-color: #000000;\r\n	}\r\n	table.cfdump_wddx th.wddx {\r\n		background-color: #444444;\r\n	}\r\n\r\n\r\n	table.cfdump_xml {\r\n		background-color: #888888;\r\n	}\r\n	table.cfdump_xml th.xml {\r\n		background-color: #aaaaaa;\r\n	}\r\n	table.cfdump_xml td.xml {\r\n		background-color: #dddddd;\r\n	}\r\n\r\n	table.cfdump_struct {\r\n		background-color: #0000cc ;\r\n	}\r\n	table.cfdump_struct th.struct {\r\n		background-color: #4444cc ;\r\n	}\r\n	table.cfdump_struct td.struct {\r\n		background-color: #ccddff;\r\n	}\r\n\r\n	table.cfdump_varundefined {\r\n		background-color: #CC3300 ;\r\n	}\r\n	table.cfdump_varundefined th.varundefined {\r\n		background-color: #CC3300 ;\r\n	}\r\n	table.cfdump_varundefined td.varundefined {\r\n		background-color: #ccddff;\r\n	}\r\n\r\n	table.cfdump_array {\r\n		background-color: #006600 ;\r\n	}\r\n	table.cfdump_array th.array {\r\n		background-color: #009900 ;\r\n	}\r\n	table.cfdump_array td.array {\r\n		background-color: #ccffcc ;\r\n	}\r\n\r\n	table.cfdump_query {\r\n		background-color: #884488 ;\r\n	}\r\n	table.cfdump_query th.query {\r\n		background-color: #aa66aa ;\r\n	}\r\n	table.cfdump_query td.query {\r\n		background-color: #ffddff ;\r\n	}\r\n\r\n\r\n	table.cfdump_cfc {\r\n		background-color: #ff0000;\r\n	}\r\n	table.cfdump_cfc th.cfc{\r\n		background-color: #ff4444;\r\n	}\r\n	table.cfdump_cfc td.cfc {\r\n		background-color: #ffcccc;\r\n	}\r\n\r\n\r\n	table.cfdump_object {\r\n		background-color : #ff0000;\r\n	}\r\n	table.cfdump_object th.object{\r\n		background-color: #ff4444;\r\n	}\r\n\r\n	table.cfdump_binary {\r\n		background-color : #eebb00;\r\n	}\r\n	table.cfdump_binary th.binary {\r\n		background-color: #ffcc44;\r\n	}\r\n	table.cfdump_binary td {\r\n		font-size: x-small;\r\n	}\r\n	table.cfdump_udf {\r\n		background-color: #aa4400;\r\n	}\r\n	table.cfdump_udf th.udf {\r\n		background-color: #cc6600;\r\n	}\r\n	table.cfdump_udfarguments {\r\n		background-color: #dddddd;\r\n		cell-spacing: 3;\r\n	}\r\n	table.cfdump_udfarguments th {\r\n		background-color: #eeeeee;\r\n		color: #000000;\r\n	}\r\n\r\n</style> <script language=\"javascript\">\r\n\r\n\r\n// for queries we have more than one td element to collapse/expand\r\n	var expand = \"open\";\r\n\r\n	dump = function( obj ) {\r\n		var out = \"\" ;\r\n		if ( typeof obj == \"object\" ) {\r\n			for ( key in obj ) {\r\n				if ( typeof obj[key] != \"function\" ) out += key + \': \' + obj[key] + \'<br>\' ;\r\n			}\r\n		}\r\n	}\r\n\r\n\r\n	cfdump_toggleRow = function(source) {\r\n		//target is the right cell\r\n		if(document.all) target = source.parentElement.cells[1];\r\n		else {\r\n			var element = null;\r\n			var vLen = source.parentNode.childNodes.length;\r\n			for(var i=vLen-1;i>0;i--){\r\n				if(source.parentNode.childNodes[i].nodeType == 1){\r\n					element = source.parentNode.childNodes[i];\r\n					break;\r\n				}\r\n			}\r\n			if(element == null)\r\n				target = source.parentNode.lastChild;\r\n			else\r\n				target = element;\r\n		}\r\n		//target = source.parentNode.lastChild ;\r\n		cfdump_toggleTarget( target, cfdump_toggleSource( source ) ) ;\r\n	}\r\n\r\n	cfdump_toggleXmlDoc = function(source) {\r\n\r\n		var caption = source.innerHTML.split( \' [\' ) ;\r\n\r\n		// toggle source (header)\r\n		if ( source.style.fontStyle == \'italic\' ) {\r\n			// closed -> short\r\n			source.style.fontStyle = \'normal\' ;\r\n			source.innerHTML = caption[0] + \' [short version]\' ;\r\n			source.title = \'click to maximize\' ;\r\n			switchLongToState = \'closed\' ;\r\n			switchShortToState = \'open\' ;\r\n		} else if ( source.innerHTML.indexOf(\'[short version]\') != -1 ) {\r\n			// short -> full\r\n			source.innerHTML = caption[0] + \' [long version]\' ;\r\n			source.title = \'click to collapse\' ;\r\n			switchLongToState = \'open\' ;\r\n			switchShortToState = \'closed\' ;\r\n		} else {\r\n			// full -> closed\r\n			source.style.fontStyle = \'italic\' ;\r\n			source.title = \'click to expand\' ;\r\n			source.innerHTML = caption[0] ;\r\n			switchLongToState = \'closed\' ;\r\n			switchShortToState = \'closed\' ;\r\n		}\r\n\r\n		// Toggle the target (everething below the header row).\r\n		// First two rows are XMLComment and XMLRoot - they are part\r\n		// of the long dump, the rest are direct children - part of the\r\n		// short dump\r\n		if(document.all) {\r\n			var table = source.parentElement.parentElement ;\r\n			for ( var i = 1; i < table.rows.length; i++ ) {\r\n				target = table.rows[i] ;\r\n				if ( i < 3 ) cfdump_toggleTarget( target, switchLongToState ) ;\r\n				else cfdump_toggleTarget( target, switchShortToState ) ;\r\n			}\r\n		}\r\n		else {\r\n			var table = source.parentNode.parentNode ;\r\n			var row = 1;\r\n			for ( var i = 1; i < table.childNodes.length; i++ ) {\r\n				target = table.childNodes[i] ;\r\n				if( target.style ) {\r\n					if ( row < 3 ) {\r\n						cfdump_toggleTarget( target, switchLongToState ) ;\r\n					} else {\r\n						cfdump_toggleTarget( target, switchShortToState ) ;\r\n					}\r\n					row++;\r\n				}\r\n			}\r\n		}\r\n	}\r\n\r\n	cfdump_toggleTable = function(source) {\r\n\r\n		var switchToState = cfdump_toggleSource( source ) ;\r\n		if(document.all) {\r\n			var table = source.parentElement.parentElement ;\r\n			for ( var i = 1; i < table.rows.length; i++ ) {\r\n				target = table.rows[i] ;\r\n				cfdump_toggleTarget( target, switchToState ) ;\r\n			}\r\n		}\r\n		else {\r\n			var table = source.parentNode.parentNode ;\r\n			for ( var i = 1; i < table.childNodes.length; i++ ) {\r\n				target = table.childNodes[i] ;\r\n				if(target.style) {\r\n					cfdump_toggleTarget( target, switchToState ) ;\r\n				}\r\n			}\r\n		}\r\n	}\r\n\r\n	cfdump_toggleSource = function( source ) {\r\n		if ( source.style.fontStyle == \'italic\' || source.style.fontStyle == null) {\r\n			source.style.fontStyle = \'normal\' ;\r\n			source.title = \'click to collapse\' ;\r\n			return \'open\' ;\r\n		} else {\r\n			source.style.fontStyle = \'italic\' ;\r\n			source.title = \'click to expand\' ;\r\n			return \'closed\' ;\r\n		}\r\n	}\r\n\r\n	cfdump_toggleTarget = function( target, switchToState ) {\r\n		if ( switchToState == \'open\' )	target.style.display = \'\' ;\r\n		else target.style.display = \'none\' ;\r\n	}\r\n\r\n	// collapse all td elements for queries\r\n	cfdump_toggleRow_qry = function(source) {\r\n		expand = (source.title == \"click to collapse\") ? \"closed\" : \"open\";\r\n		if(document.all) {\r\n			var nbrChildren = source.parentElement.cells.length;\r\n			if(nbrChildren > 1){\r\n				for(i=nbrChildren-1;i>0;i--){\r\n					target = source.parentElement.cells[i];\r\n					cfdump_toggleTarget( target,expand ) ;\r\n					cfdump_toggleSource_qry(source);\r\n				}\r\n			}\r\n			else {\r\n				//target is the right cell\r\n				target = source.parentElement.cells[1];\r\n				cfdump_toggleTarget( target, cfdump_toggleSource( source ) ) ;\r\n			}\r\n		}\r\n		else{\r\n			var target = null;\r\n			var vLen = source.parentNode.childNodes.length;\r\n			for(var i=vLen-1;i>1;i--){\r\n				if(source.parentNode.childNodes[i].nodeType == 1){\r\n					target = source.parentNode.childNodes[i];\r\n					cfdump_toggleTarget( target,expand );\r\n					cfdump_toggleSource_qry(source);\r\n				}\r\n			}\r\n			if(target == null){\r\n				//target is the last cell\r\n				target = source.parentNode.lastChild;\r\n				cfdump_toggleTarget( target, cfdump_toggleSource( source ) ) ;\r\n			}\r\n		}\r\n	}\r\n\r\n	cfdump_toggleSource_qry = function(source) {\r\n		if(expand == \"closed\"){\r\n			source.title = \"click to expand\";\r\n			source.style.fontStyle = \"italic\";\r\n		}\r\n		else{\r\n			source.title = \"click to collapse\";\r\n			source.style.fontStyle = \"normal\";\r\n		}\r\n	}\r\n\r\n</script> Expression </td>\r\n		</tr>\r\n\r\n        \r\n		<tr>\r\n			<th>Tagcontext:</th>\r\n			<td> <style>\r\n\r\n\r\n	table.cfdump_wddx,\r\n	table.cfdump_xml,\r\n	table.cfdump_struct,\r\n	table.cfdump_varundefined,\r\n	table.cfdump_array,\r\n	table.cfdump_query,\r\n	table.cfdump_cfc,\r\n	table.cfdump_object,\r\n	table.cfdump_binary,\r\n	table.cfdump_udf,\r\n	table.cfdump_udfbody,\r\n	table.cfdump_udfarguments {\r\n		font-size: xx-small;\r\n		font-family: verdana, arial, helvetica, sans-serif;\r\n		cell-spacing: 2px;\r\n	}\r\n\r\n	table.cfdump_wddx th,\r\n	table.cfdump_xml th,\r\n	table.cfdump_struct th,\r\n	table.cfdump_varundefined th,\r\n	table.cfdump_array th,\r\n	table.cfdump_query th,\r\n	table.cfdump_cfc th,\r\n	table.cfdump_object th,\r\n	table.cfdump_binary th,\r\n	table.cfdump_udf th,\r\n	table.cfdump_udfbody th,\r\n	table.cfdump_udfarguments th {\r\n		text-align: left;\r\n		color: white;\r\n		padding: 5px;\r\n	}\r\n\r\n	table.cfdump_wddx td,\r\n	table.cfdump_xml td,\r\n	table.cfdump_struct td,\r\n	table.cfdump_varundefined  td,\r\n	table.cfdump_array td,\r\n	table.cfdump_query td,\r\n	table.cfdump_cfc td,\r\n	table.cfdump_object td,\r\n	table.cfdump_binary td,\r\n	table.cfdump_udf td,\r\n	table.cfdump_udfbody td,\r\n	table.cfdump_udfarguments td {\r\n		padding: 3px;\r\n		background-color: #ffffff;\r\n		vertical-align : top;\r\n	}\r\n\r\n	table.cfdump_wddx {\r\n		background-color: #000000;\r\n	}\r\n	table.cfdump_wddx th.wddx {\r\n		background-color: #444444;\r\n	}\r\n\r\n\r\n	table.cfdump_xml {\r\n		background-color: #888888;\r\n	}\r\n	table.cfdump_xml th.xml {\r\n		background-color: #aaaaaa;\r\n	}\r\n	table.cfdump_xml td.xml {\r\n		background-color: #dddddd;\r\n	}\r\n\r\n	table.cfdump_struct {\r\n		background-color: #0000cc ;\r\n	}\r\n	table.cfdump_struct th.struct {\r\n		background-color: #4444cc ;\r\n	}\r\n	table.cfdump_struct td.struct {\r\n		background-color: #ccddff;\r\n	}\r\n\r\n	table.cfdump_varundefined {\r\n		background-color: #CC3300 ;\r\n	}\r\n	table.cfdump_varundefined th.varundefined {\r\n		background-color: #CC3300 ;\r\n	}\r\n	table.cfdump_varundefined td.varundefined {\r\n		background-color: #ccddff;\r\n	}\r\n\r\n	table.cfdump_array {\r\n		background-color: #006600 ;\r\n	}\r\n	table.cfdump_array th.array {\r\n		background-color: #009900 ;\r\n	}\r\n	table.cfdump_array td.array {\r\n		background-color: #ccffcc ;\r\n	}\r\n\r\n	table.cfdump_query {\r\n		background-color: #884488 ;\r\n	}\r\n	table.cfdump_query th.query {\r\n		background-color: #aa66aa ;\r\n	}\r\n	table.cfdump_query td.query {\r\n		background-color: #ffddff ;\r\n	}\r\n\r\n\r\n	table.cfdump_cfc {\r\n		background-color: #ff0000;\r\n	}\r\n	table.cfdump_cfc th.cfc{\r\n		background-color: #ff4444;\r\n	}\r\n	table.cfdump_cfc td.cfc {\r\n		background-color: #ffcccc;\r\n	}\r\n\r\n\r\n	table.cfdump_object {\r\n		background-color : #ff0000;\r\n	}\r\n	table.cfdump_object th.object{\r\n		background-color: #ff4444;\r\n	}\r\n\r\n	table.cfdump_binary {\r\n		background-color : #eebb00;\r\n	}\r\n	table.cfdump_binary th.binary {\r\n		background-color: #ffcc44;\r\n	}\r\n	table.cfdump_binary td {\r\n		font-size: x-small;\r\n	}\r\n	table.cfdump_udf {\r\n		background-color: #aa4400;\r\n	}\r\n	table.cfdump_udf th.udf {\r\n		background-color: #cc6600;\r\n	}\r\n	table.cfdump_udfarguments {\r\n		background-color: #dddddd;\r\n		cell-spacing: 3;\r\n	}\r\n	table.cfdump_udfarguments th {\r\n		background-color: #eeeeee;\r\n		color: #000000;\r\n	}\r\n\r\n</style> <script language=\"javascript\">\r\n\r\n\r\n// for queries we have more than one td element to collapse/expand\r\n	var expand = \"open\";\r\n\r\n	dump = function( obj ) {\r\n		var out = \"\" ;\r\n		if ( typeof obj == \"object\" ) {\r\n			for ( key in obj ) {\r\n				if ( typeof obj[key] != \"function\" ) out += key + \': \' + obj[key] + \'<br>\' ;\r\n			}\r\n		}\r\n	}\r\n\r\n\r\n	cfdump_toggleRow = function(source) {\r\n		//target is the right cell\r\n		if(document.all) target = source.parentElement.cells[1];\r\n		else {\r\n			var element = null;\r\n			var vLen = source.parentNode.childNodes.length;\r\n			for(var i=vLen-1;i>0;i--){\r\n				if(source.parentNode.childNodes[i].nodeType == 1){\r\n					element = source.parentNode.childNodes[i];\r\n					break;\r\n				}\r\n			}\r\n			if(element == null)\r\n				target = source.parentNode.lastChild;\r\n			else\r\n				target = element;\r\n		}\r\n		//target = source.parentNode.lastChild ;\r\n		cfdump_toggleTarget( target, cfdump_toggleSource( source ) ) ;\r\n	}\r\n\r\n	cfdump_toggleXmlDoc = function(source) {\r\n\r\n		var caption = source.innerHTML.split( \' [\' ) ;\r\n\r\n		// toggle source (header)\r\n		if ( source.style.fontStyle == \'italic\' ) {\r\n			// closed -> short\r\n			source.style.fontStyle = \'normal\' ;\r\n			source.innerHTML = caption[0] + \' [short version]\' ;\r\n			source.title = \'click to maximize\' ;\r\n			switchLongToState = \'closed\' ;\r\n			switchShortToState = \'open\' ;\r\n		} else if ( source.innerHTML.indexOf(\'[short version]\') != -1 ) {\r\n			// short -> full\r\n			source.innerHTML = caption[0] + \' [long version]\' ;\r\n			source.title = \'click to collapse\' ;\r\n			switchLongToState = \'open\' ;\r\n			switchShortToState = \'closed\' ;\r\n		} else {\r\n			// full -> closed\r\n			source.style.fontStyle = \'italic\' ;\r\n			source.title = \'click to expand\' ;\r\n			source.innerHTML = caption[0] ;\r\n			switchLongToState = \'closed\' ;\r\n			switchShortToState = \'closed\' ;\r\n		}\r\n\r\n		// Toggle the target (everething below the header row).\r\n		// First two rows are XMLComment and XMLRoot - they are part\r\n		// of the long dump, the rest are direct children - part of the\r\n		// short dump\r\n		if(document.all) {\r\n			var table = source.parentElement.parentElement ;\r\n			for ( var i = 1; i < table.rows.length; i++ ) {\r\n				target = table.rows[i] ;\r\n				if ( i < 3 ) cfdump_toggleTarget( target, switchLongToState ) ;\r\n				else cfdump_toggleTarget( target, switchShortToState ) ;\r\n			}\r\n		}\r\n		else {\r\n			var table = source.parentNode.parentNode ;\r\n			var row = 1;\r\n			for ( var i = 1; i < table.childNodes.length; i++ ) {\r\n				target = table.childNodes[i] ;\r\n				if( target.style ) {\r\n					if ( row < 3 ) {\r\n						cfdump_toggleTarget( target, switchLongToState ) ;\r\n					} else {\r\n						cfdump_toggleTarget( target, switchShortToState ) ;\r\n					}\r\n					row++;\r\n				}\r\n			}\r\n		}\r\n	}\r\n\r\n	cfdump_toggleTable = function(source) {\r\n\r\n		var switchToState = cfdump_toggleSource( source ) ;\r\n		if(document.all) {\r\n			var table = source.parentElement.parentElement ;\r\n			for ( var i = 1; i < table.rows.length; i++ ) {\r\n				target = table.rows[i] ;\r\n				cfdump_toggleTarget( target, switchToState ) ;\r\n			}\r\n		}\r\n		else {\r\n			var table = source.parentNode.parentNode ;\r\n			for ( var i = 1; i < table.childNodes.length; i++ ) {\r\n				target = table.childNodes[i] ;\r\n				if(target.style) {\r\n					cfdump_toggleTarget( target, switchToState ) ;\r\n				}\r\n			}\r\n		}\r\n	}\r\n\r\n	cfdump_toggleSource = function( source ) {\r\n		if ( source.style.fontStyle == \'italic\' || source.style.fontStyle == null) {\r\n			source.style.fontStyle = \'normal\' ;\r\n			source.title = \'click to collapse\' ;\r\n			return \'open\' ;\r\n		} else {\r\n			source.style.fontStyle = \'italic\' ;\r\n			source.title = \'click to expand\' ;\r\n			return \'closed\' ;\r\n		}\r\n	}\r\n\r\n	cfdump_toggleTarget = function( target, switchToState ) {\r\n		if ( switchToState == \'open\' )	target.style.display = \'\' ;\r\n		else target.style.display = \'none\' ;\r\n	}\r\n\r\n	// collapse all td elements for queries\r\n	cfdump_toggleRow_qry = function(source) {\r\n		expand = (source.title == \"click to collapse\") ? \"closed\" : \"open\";\r\n		if(document.all) {\r\n			var nbrChildren = source.parentElement.cells.length;\r\n			if(nbrChildren > 1){\r\n				for(i=nbrChildren-1;i>0;i--){\r\n					target = source.parentElement.cells[i];\r\n					cfdump_toggleTarget( target,expand ) ;\r\n					cfdump_toggleSource_qry(source);\r\n				}\r\n			}\r\n			else {\r\n				//target is the right cell\r\n				target = source.parentElement.cells[1];\r\n				cfdump_toggleTarget( target, cfdump_toggleSource( source ) ) ;\r\n			}\r\n		}\r\n		else{\r\n			var target = null;\r\n			var vLen = source.parentNode.childNodes.length;\r\n			for(var i=vLen-1;i>1;i--){\r\n				if(source.parentNode.childNodes[i].nodeType == 1){\r\n					target = source.parentNode.childNodes[i];\r\n					cfdump_toggleTarget( target,expand );\r\n					cfdump_toggleSource_qry(source);\r\n				}\r\n			}\r\n			if(target == null){\r\n				//target is the last cell\r\n				target = source.parentNode.lastChild;\r\n				cfdump_toggleTarget( target, cfdump_toggleSource( source ) ) ;\r\n			}\r\n		}\r\n	}\r\n\r\n	cfdump_toggleSource_qry = function(source) {\r\n		if(expand == \"closed\"){\r\n			source.title = \"click to expand\";\r\n			source.style.fontStyle = \"italic\";\r\n		}\r\n		else{\r\n			source.title = \"click to collapse\";\r\n			source.style.fontStyle = \"normal\";\r\n		}\r\n	}\r\n\r\n</script> \r\n				<table class=\"cfdump_array\">\r\n				<tr><th class=\"array\" colspan=\"2\" onClick=\"cfdump_toggleTable(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">array\r\n				</th></tr>\r\n				\r\n					<tr><td class=\"array\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">1</td>\r\n					<td> \r\n			<table class=\"cfdump_struct\">\r\n			<tr><th class=\"struct\" colspan=\"2\" onClick=\"cfdump_toggleTable(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">struct</th></tr> \r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">COLUMN</td>\r\n					<td>\r\n					0 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">ID</td>\r\n					<td>\r\n					?? \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">LINE</td>\r\n					<td>\r\n					100 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">RAW_TRACE</td>\r\n					<td>\r\n					at cfdetails_options2ecfm143220639.runPage(D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\catalog\\\\details_options.cfm:100) \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TEMPLATE</td>\r\n					<td>\r\n					D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\catalog\\\\details_options.cfm \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TYPE</td>\r\n					<td>\r\n					CFML \r\n					</td>\r\n					</tr>\r\n					\r\n			</table>\r\n		</td></tr> \r\n					<tr><td class=\"array\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">2</td>\r\n					<td> \r\n			<table class=\"cfdump_struct\">\r\n			<tr><th class=\"struct\" colspan=\"2\" onClick=\"cfdump_toggleTable(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">struct</th></tr> \r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">COLUMN</td>\r\n					<td>\r\n					0 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">ID</td>\r\n					<td>\r\n					CFINCLUDE \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">LINE</td>\r\n					<td>\r\n					26 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">RAW_TRACE</td>\r\n					<td>\r\n					at cfdetails_layout2ecfm1316579713.runPage(D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\catalog\\\\details_layout.cfm:26) \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TEMPLATE</td>\r\n					<td>\r\n					D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\catalog\\\\details_layout.cfm \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TYPE</td>\r\n					<td>\r\n					CFML \r\n					</td>\r\n					</tr>\r\n					\r\n			</table>\r\n		</td></tr> \r\n					<tr><td class=\"array\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">3</td>\r\n					<td> \r\n			<table class=\"cfdump_struct\">\r\n			<tr><th class=\"struct\" colspan=\"2\" onClick=\"cfdump_toggleTable(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">struct</th></tr> \r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">COLUMN</td>\r\n					<td>\r\n					0 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">ID</td>\r\n					<td>\r\n					CFINCLUDE \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">LINE</td>\r\n					<td>\r\n					32 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">RAW_TRACE</td>\r\n					<td>\r\n					at cfdetails2ecfm1691888764.runPage(D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\catalog\\\\details.cfm:32) \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TEMPLATE</td>\r\n					<td>\r\n					D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\catalog\\\\details.cfm \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TYPE</td>\r\n					<td>\r\n					CFML \r\n					</td>\r\n					</tr>\r\n					\r\n			</table>\r\n		</td></tr> \r\n					<tr><td class=\"array\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">4</td>\r\n					<td> \r\n			<table class=\"cfdump_struct\">\r\n			<tr><th class=\"struct\" colspan=\"2\" onClick=\"cfdump_toggleTable(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">struct</th></tr> \r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">COLUMN</td>\r\n					<td>\r\n					0 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">ID</td>\r\n					<td>\r\n					CFINCLUDE \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">LINE</td>\r\n					<td>\r\n					66 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">RAW_TRACE</td>\r\n					<td>\r\n					at cfswitches2ecfm609901257._factor6(D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\switches.cfm:66) \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TEMPLATE</td>\r\n					<td>\r\n					D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\switches.cfm \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TYPE</td>\r\n					<td>\r\n					CFML \r\n					</td>\r\n					</tr>\r\n					\r\n			</table>\r\n		</td></tr> \r\n					<tr><td class=\"array\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">5</td>\r\n					<td> \r\n			<table class=\"cfdump_struct\">\r\n			<tr><th class=\"struct\" colspan=\"2\" onClick=\"cfdump_toggleTable(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">struct</th></tr> \r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">COLUMN</td>\r\n					<td>\r\n					0 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">ID</td>\r\n					<td>\r\n					CF_SWITCHES \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">LINE</td>\r\n					<td>\r\n					65 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">RAW_TRACE</td>\r\n					<td>\r\n					at cfswitches2ecfm609901257._factor8(D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\switches.cfm:65) \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TEMPLATE</td>\r\n					<td>\r\n					D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\switches.cfm \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TYPE</td>\r\n					<td>\r\n					CFML \r\n					</td>\r\n					</tr>\r\n					\r\n			</table>\r\n		</td></tr> \r\n					<tr><td class=\"array\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">6</td>\r\n					<td> \r\n			<table class=\"cfdump_struct\">\r\n			<tr><th class=\"struct\" colspan=\"2\" onClick=\"cfdump_toggleTable(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">struct</th></tr> \r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">COLUMN</td>\r\n					<td>\r\n					0 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">ID</td>\r\n					<td>\r\n					CF_SWITCHES \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">LINE</td>\r\n					<td>\r\n					64 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">RAW_TRACE</td>\r\n					<td>\r\n					at cfswitches2ecfm609901257._factor29(D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\switches.cfm:64) \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TEMPLATE</td>\r\n					<td>\r\n					D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\switches.cfm \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TYPE</td>\r\n					<td>\r\n					CFML \r\n					</td>\r\n					</tr>\r\n					\r\n			</table>\r\n		</td></tr> \r\n					<tr><td class=\"array\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">7</td>\r\n					<td> \r\n			<table class=\"cfdump_struct\">\r\n			<tr><th class=\"struct\" colspan=\"2\" onClick=\"cfdump_toggleTable(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">struct</th></tr> \r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">COLUMN</td>\r\n					<td>\r\n					0 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">ID</td>\r\n					<td>\r\n					CF_SWITCHES \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">LINE</td>\r\n					<td>\r\n					8 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">RAW_TRACE</td>\r\n					<td>\r\n					at cfswitches2ecfm609901257._factor30(D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\switches.cfm:8) \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TEMPLATE</td>\r\n					<td>\r\n					D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\switches.cfm \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TYPE</td>\r\n					<td>\r\n					CFML \r\n					</td>\r\n					</tr>\r\n					\r\n			</table>\r\n		</td></tr> \r\n					<tr><td class=\"array\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">8</td>\r\n					<td> \r\n			<table class=\"cfdump_struct\">\r\n			<tr><th class=\"struct\" colspan=\"2\" onClick=\"cfdump_toggleTable(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">struct</th></tr> \r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">COLUMN</td>\r\n					<td>\r\n					0 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">ID</td>\r\n					<td>\r\n					CF_SWITCHES \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">LINE</td>\r\n					<td>\r\n					1 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">RAW_TRACE</td>\r\n					<td>\r\n					at cfswitches2ecfm609901257.runPage(D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\switches.cfm:1) \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TEMPLATE</td>\r\n					<td>\r\n					D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\switches.cfm \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TYPE</td>\r\n					<td>\r\n					CFML \r\n					</td>\r\n					</tr>\r\n					\r\n			</table>\r\n		</td></tr> \r\n					<tr><td class=\"array\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">9</td>\r\n					<td> \r\n			<table class=\"cfdump_struct\">\r\n			<tr><th class=\"struct\" colspan=\"2\" onClick=\"cfdump_toggleTable(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">struct</th></tr> \r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">COLUMN</td>\r\n					<td>\r\n					0 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">ID</td>\r\n					<td>\r\n					CFINCLUDE \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">LINE</td>\r\n					<td>\r\n					50 \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">RAW_TRACE</td>\r\n					<td>\r\n					at cfindex2ecfm849006900.runPage(D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\index.cfm:50) \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TEMPLATE</td>\r\n					<td>\r\n					D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\index.cfm \r\n					</td>\r\n					</tr>\r\n					\r\n					<tr>\r\n					<td class=\"struct\" onClick=\"cfdump_toggleRow(this);\" style=\"cursor:pointer;\" title=\"click to collapse\">TYPE</td>\r\n					<td>\r\n					CFML \r\n					</td>\r\n					</tr>\r\n					\r\n			</table>\r\n		</td></tr> \r\n			</table>\r\n		</td>\r\n		</tr>\r\n\r\n        \r\n    \r\n    <tr>\r\n    	<th>Token:</th>\r\n        <td>XPQ23SW050212070532</td>    \r\n</table>\r\n','2012-05-02 19:50:33','Element ITEMID is undefined in QRYOPTION.  Error Occurred on line 100 in D:\\\\home\\\\cfhowto.com\\\\subdomains\\\\cfskdemo\\\\catalog\\\\details_options.cfm',NULL,NULL,'No',NULL,'0');

/*Table structure for table `errorlog_fixes` */

CREATE TABLE `errorlog_fixes` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `errorid` varchar(255) DEFAULT NULL,
  `suggestion` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `errorlog_fixes` */

/*Table structure for table `fedexconfig` */

CREATE TABLE `fedexconfig` (
  `SettingID` int(10) NOT NULL AUTO_INCREMENT,
  `ServiceCodes` longtext,
  `ServiceNames` longtext,
  `AccountNumber` varchar(255) DEFAULT NULL,
  `metercode` varchar(255) DEFAULT NULL,
  `DropOffType` varchar(50) DEFAULT NULL,
  `CurrencyCode` varchar(50) DEFAULT NULL,
  `MultipleShippingPoints` varchar(50) DEFAULT NULL,
  `ShipFromStates` longtext,
  `ShipFromCities` longtext,
  `ShipFromCountries` longtext,
  `ShipFromZips` longtext,
  `ShipFromOtherLocation` varchar(50) DEFAULT NULL,
  `user` varchar(50) DEFAULT NULL,
  `fallbackmethod` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`SettingID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `fedexconfig` */

insert  into `fedexconfig`(`SettingID`,`ServiceCodes`,`ServiceNames`,`AccountNumber`,`metercode`,`DropOffType`,`CurrencyCode`,`MultipleShippingPoints`,`ShipFromStates`,`ShipFromCities`,`ShipFromCountries`,`ShipFromZips`,`ShipFromOtherLocation`,`user`,`fallbackmethod`) values (1,'FEDEXGROUND','FEDEXGROUND','000000000','0000000','REGULARPICKUP','USD','No','FL','Miami','US','33187','No',NULL,'5');

/*Table structure for table `giftcards` */

CREATE TABLE `giftcards` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `gNumber` varchar(50) DEFAULT NULL,
  `gAmount` float(10,2) DEFAULT NULL,
  `gAmountLeft` float(10,2) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `OrderID` varchar(50) DEFAULT NULL,
  `CustomerID` varchar(50) DEFAULT NULL,
  `Active` varchar(50) DEFAULT NULL,
  `LastModified` datetime DEFAULT NULL,
  `activated` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`OrderID`,`CustomerID`,`Active`,`activated`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `giftcards` */

/*Table structure for table `links` */

CREATE TABLE `links` (
  `LinkID` int(10) NOT NULL AUTO_INCREMENT,
  `LinkOrder` varchar(50) DEFAULT NULL,
  `LinkTitle` varchar(50) DEFAULT NULL,
  `LinkRef` longtext,
  `LinkTarget` varchar(50) DEFAULT NULL,
  `LinkDescription` longtext,
  `LinkImage` varchar(100) DEFAULT 'None',
  `LinkRImage` varchar(100) DEFAULT 'None',
  `urlrw` longtext,
  PRIMARY KEY (`LinkID`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

/*Data for the table `links` */

insert  into `links`(`LinkID`,`LinkOrder`,`LinkTitle`,`LinkRef`,`LinkTarget`,`LinkDescription`,`LinkImage`,`LinkRImage`,`urlrw`) values (45,'1','Shipping Info','index.cfm?Page=docs/Shipping_Info.cfm','','','None','None','Shipping-Info'),(46,'2','About Us','index.cfm?Page=docs/About_Us.cfm','','','None','None','About-Us'),(47,'3','Contact Us','index.cfm?action=contactform_show','','','None','None','Contact-Us');

/*Table structure for table `logins` */

CREATE TABLE `logins` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `CompanyName` varchar(50) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `PostalCode` varchar(50) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `PhoneNumber` varchar(50) DEFAULT NULL,
  `PhoneNumber2` varchar(50) DEFAULT NULL,
  `SSN` varchar(50) DEFAULT NULL,
  `TaxID` varchar(50) DEFAULT NULL,
  `LastLogin` varchar(50) DEFAULT NULL,
  `EmailAddress` varchar(50) DEFAULT NULL,
  `Notes` longtext,
  `NeverExpires` varchar(50) DEFAULT NULL,
  `ExpiresOn` varchar(50) DEFAULT NULL,
  `Permissions` longtext,
  `Enabled` varchar(50) DEFAULT NULL,
  `ExpireSelect` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `NewIndex1` (`Username`,`Password`,`Enabled`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `logins` */

/*Table structure for table `nav_links` */

CREATE TABLE `nav_links` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LinkTitle` varchar(50) DEFAULT NULL,
  `SubLinkOf` varchar(50) DEFAULT NULL,
  `LinkPath` longtext,
  `OrderValue` int(11) DEFAULT '0',
  `filename` varchar(50) DEFAULT NULL,
  `filelocation` longtext,
  `pagetemplate` varchar(50) DEFAULT NULL,
  `linkurl` longtext,
  `linktarget` varchar(50) DEFAULT NULL,
  `linktype` varchar(50) DEFAULT NULL,
  `pluginname` varchar(50) DEFAULT NULL,
  `LinkImage` longtext,
  `LinkRolloverImage` longtext,
  `LinkTitleType` varchar(50) DEFAULT NULL,
  `UseSSL` varchar(50) DEFAULT NULL,
  `MenuID` varchar(50) DEFAULT NULL,
  `PageTitle` varchar(50) DEFAULT NULL,
  `MetaDescription` varchar(255) DEFAULT NULL,
  `MetaKeywords` varchar(255) DEFAULT NULL,
  `UserLevel` varchar(50) DEFAULT '3',
  `bgColor` varchar(50) DEFAULT NULL,
  `fontColor` varchar(50) DEFAULT NULL,
  `fontColor_hover` varchar(50) DEFAULT NULL,
  `bgColor_hover` varchar(50) DEFAULT NULL,
  `fontStyle` varchar(50) DEFAULT NULL,
  `fontWeight` varchar(50) DEFAULT NULL,
  `CustomStyles` longtext,
  `filetype` varchar(50) DEFAULT NULL,
  `pluginid` varchar(50) DEFAULT NULL,
  `widgetsleft` varchar(50) DEFAULT NULL,
  `widgetsright` varchar(50) DEFAULT NULL,
  `loadinframe` varchar(50) DEFAULT NULL,
  `categoryid` varchar(50) DEFAULT '0',
  `urlrw` longtext,
  PRIMARY KEY (`ID`),
  KEY `NewIndex1` (`SubLinkOf`,`categoryid`,`MenuID`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Data for the table `nav_links` */

insert  into `nav_links`(`ID`,`LinkTitle`,`SubLinkOf`,`LinkPath`,`OrderValue`,`filename`,`filelocation`,`pagetemplate`,`linkurl`,`linktarget`,`linktype`,`pluginname`,`LinkImage`,`LinkRolloverImage`,`LinkTitleType`,`UseSSL`,`MenuID`,`PageTitle`,`MetaDescription`,`MetaKeywords`,`UserLevel`,`bgColor`,`fontColor`,`fontColor_hover`,`bgColor_hover`,`fontStyle`,`fontWeight`,`CustomStyles`,`filetype`,`pluginid`,`widgetsleft`,`widgetsright`,`loadinframe`,`categoryid`,`urlrw`) values (13,'Home','0','/',0,'homepage.cfm','/docs/','index.cfm','index.cfm?page=homepage.cfm','_self','PageLink',NULL,'none','none',NULL,'No','1','','','','3','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'show','show','no','0','Home');

/*Table structure for table `nav_styles` */

CREATE TABLE `nav_styles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menuid` varchar(50) DEFAULT NULL,
  `orientation` varchar(50) DEFAULT NULL,
  `mbordersize` varchar(50) DEFAULT NULL,
  `mborderstyle` varchar(50) DEFAULT NULL,
  `mbordercolor` varchar(50) DEFAULT NULL,
  `mbackgroundcolor` varchar(50) DEFAULT NULL,
  `mhoverbackgroundcolor` varchar(50) DEFAULT NULL,
  `mfontsize` varchar(50) DEFAULT NULL,
  `mfonthoversize` varchar(50) DEFAULT NULL,
  `mfontfamily` varchar(50) DEFAULT NULL,
  `mfontweight` varchar(50) DEFAULT NULL,
  `mfontcolor` varchar(50) DEFAULT NULL,
  `mfonthovercolor` varchar(50) DEFAULT NULL,
  `mHeight` varchar(50) DEFAULT NULL,
  `MenuType` varchar(50) DEFAULT NULL,
  `ItemBorderSize` varchar(50) DEFAULT NULL,
  `ItemBorderStyle` varchar(50) DEFAULT NULL,
  `ItemBorderColor` varchar(50) DEFAULT NULL,
  `TextAlignment` varchar(50) DEFAULT NULL,
  `cellpadding` varchar(50) DEFAULT NULL,
  `cellspacing` varchar(50) DEFAULT NULL,
  `menuwidth` varchar(50) DEFAULT NULL,
  `CellWidth` varchar(50) DEFAULT NULL,
  `CellHeight` varchar(50) DEFAULT NULL,
  `TileImage` varchar(255) DEFAULT NULL,
  `TileImageHover` varchar(255) DEFAULT NULL,
  `mnuBGImage` varchar(255) DEFAULT NULL,
  `FillerImage` varchar(255) DEFAULT NULL,
  `mnuTransparency` varchar(255) DEFAULT NULL,
  `submnuTransparency` varchar(255) DEFAULT NULL,
  `mnuHoverSound` longtext,
  `submnuHoverSound` longtext,
  `mnuClickSound` longtext,
  `minSubWidth` varchar(50) DEFAULT NULL,
  `removeSubDelay` varchar(50) DEFAULT NULL,
  `subMnuItemHeight` varchar(50) DEFAULT NULL,
  `customcss` longtext,
  `FlashMenuStyle` varchar(255) DEFAULT NULL,
  `sbackgroundcolor` varchar(50) DEFAULT NULL,
  `shoverbackgroundcolor` varchar(50) DEFAULT NULL,
  `sfontcolor` varchar(50) DEFAULT NULL,
  `sfonthovercolor` varchar(50) DEFAULT NULL,
  `sfontsize` varchar(50) DEFAULT NULL,
  `mTextDecor` varchar(50) DEFAULT NULL,
  `mTextHoverDecor` varchar(50) DEFAULT NULL,
  `sTextDecor` varchar(50) DEFAULT NULL,
  `sTextHoverDecor` varchar(50) DEFAULT NULL,
  `sFontHoverSize` varchar(50) DEFAULT NULL,
  `colors_toplist` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `nav_styles` */

insert  into `nav_styles`(`id`,`menuid`,`orientation`,`mbordersize`,`mborderstyle`,`mbordercolor`,`mbackgroundcolor`,`mhoverbackgroundcolor`,`mfontsize`,`mfonthoversize`,`mfontfamily`,`mfontweight`,`mfontcolor`,`mfonthovercolor`,`mHeight`,`MenuType`,`ItemBorderSize`,`ItemBorderStyle`,`ItemBorderColor`,`TextAlignment`,`cellpadding`,`cellspacing`,`menuwidth`,`CellWidth`,`CellHeight`,`TileImage`,`TileImageHover`,`mnuBGImage`,`FillerImage`,`mnuTransparency`,`submnuTransparency`,`mnuHoverSound`,`submnuHoverSound`,`mnuClickSound`,`minSubWidth`,`removeSubDelay`,`subMnuItemHeight`,`customcss`,`FlashMenuStyle`,`sbackgroundcolor`,`shoverbackgroundcolor`,`sfontcolor`,`sfonthovercolor`,`sfontsize`,`mTextDecor`,`mTextHoverDecor`,`sTextDecor`,`sTextHoverDecor`,`sFontHoverSize`,`colors_toplist`) values (1,'1','Horizontal','0','solid','#000000','#0066FF','#0099FF','11','11','Arial, Helvetica, sans-serif','Bold','#FFFFFF','#FFFFFF','48','flash','2','solid','#FFFFFF','center','0','0','952','25','30','images/menu_nohover.png','images/menu_hover.png','','https://www.limitlessoneaccess.com/sitebuilder/globals/templates/limitlessone/images/menubackgroundBlue.jpg','100','100',NULL,NULL,NULL,'100','5','25',NULL,'livemenu.swf','#0066FF','#0099FF','#000000','#FFFFFF','11',NULL,NULL,NULL,NULL,'11','#666666');

/*Table structure for table `news` */

CREATE TABLE `news` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pubdate` datetime DEFAULT NULL,
  `headline` varchar(255) DEFAULT NULL,
  `article` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `news` */

/*Table structure for table `news_settings` */

CREATE TABLE `news_settings` (
  `id` int(10) NOT NULL DEFAULT '0',
  `NumberToDisplay` varchar(50) DEFAULT NULL,
  `widget_dateformat` varchar(255) DEFAULT NULL,
  `view_dateformat` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `news_settings` */

insert  into `news_settings`(`id`,`NumberToDisplay`,`widget_dateformat`,`view_dateformat`) values (1,'2','mm.dd.yyyy','mmmm dd, yyyy');

/*Table structure for table `nl_groups` */

CREATE TABLE `nl_groups` (
  `groupid` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`groupid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `nl_groups` */

/*Table structure for table `nl_members` */

CREATE TABLE `nl_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `emailaddress` varchar(50) DEFAULT NULL,
  `EmailPref` varchar(50) DEFAULT NULL,
  `RegCode` varchar(50) DEFAULT NULL,
  `active` varchar(50) DEFAULT NULL,
  `subscribedon` datetime DEFAULT NULL,
  `groups` longtext,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ConfirmationCode` (`RegCode`,`emailaddress`)
) ENGINE=MyISAM AUTO_INCREMENT=72 DEFAULT CHARSET=latin1;

/*Data for the table `nl_members` */

/*Table structure for table `nl_membersingroup` */

CREATE TABLE `nl_membersingroup` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `groupid` int(10) DEFAULT NULL,
  `memberid` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`groupid`,`memberid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `nl_membersingroup` */

/*Table structure for table `nl_published` */

CREATE TABLE `nl_published` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Subject` varchar(50) DEFAULT NULL,
  `Body` longtext,
  `Recipients` varchar(50) DEFAULT NULL,
  `sent` varchar(50) DEFAULT NULL,
  `senton` datetime DEFAULT NULL,
  `createdon` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `nl_published` */

/*Table structure for table `nl_settings` */

CREATE TABLE `nl_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nl_email` varchar(255) DEFAULT NULL,
  `nl_home` varchar(255) DEFAULT NULL,
  `nl_mailserver` varchar(255) DEFAULT NULL,
  `nl_UsePassword` varchar(255) DEFAULT NULL,
  `nl_mailusername` varchar(255) DEFAULT NULL,
  `nl_mailpassword` varchar(255) DEFAULT NULL,
  `nl_useserver` varchar(50) DEFAULT NULL,
  `nl_blockeddomains` longtext,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `nl_settings` */

insert  into `nl_settings`(`id`,`nl_email`,`nl_home`,`nl_mailserver`,`nl_UsePassword`,`nl_mailusername`,`nl_mailpassword`,`nl_useserver`,`nl_blockeddomains`) values (1,'email@yourdomain.com','http://','','No','','','No','');

/*Table structure for table `options` */

CREATE TABLE `options` (
  `OptionID` int(10) NOT NULL AUTO_INCREMENT,
  `OrderID` int(10) DEFAULT NULL,
  `Caption` varchar(50) DEFAULT NULL,
  `FieldName` varchar(50) DEFAULT NULL,
  `OptionCode` longtext,
  `FieldType` varchar(50) DEFAULT NULL,
  `FieldValue` varchar(255) DEFAULT NULL,
  `ItemsList` longtext,
  `PriceList` longtext,
  `WeightsList` longtext,
  `itemidslist` longtext,
  `OptionPrice` varchar(50) DEFAULT NULL,
  `OptionWeight` varchar(50) DEFAULT NULL,
  `OptionGroup` varchar(50) DEFAULT NULL,
  `Width` varchar(50) DEFAULT NULL,
  `Height` varchar(50) DEFAULT NULL,
  `isrequired` varchar(50) DEFAULT NULL,
  `HTMLCode` longtext,
  `CartCaption` varchar(255) DEFAULT NULL,
  `itemid` varchar(50) DEFAULT '0',
  `OptionForItem` varchar(255) DEFAULT NULL,
  `skulist` longtext,
  `sku` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`OptionID`),
  KEY `NewIndex1` (`OrderID`,`itemid`)
) ENGINE=MyISAM AUTO_INCREMENT=85 DEFAULT CHARSET=latin1;

/*Data for the table `options` */

insert  into `options`(`OptionID`,`OrderID`,`Caption`,`FieldName`,`OptionCode`,`FieldType`,`FieldValue`,`ItemsList`,`PriceList`,`WeightsList`,`itemidslist`,`OptionPrice`,`OptionWeight`,`OptionGroup`,`Width`,`Height`,`isrequired`,`HTMLCode`,`CartCaption`,`itemid`,`OptionForItem`,`skulist`,`sku`) values (84,2,'Add CPU for $1',NULL,NULL,'CheckBox','Unchecked',NULL,NULL,NULL,NULL,'0.00','0.00',NULL,'25','5','No','<input name=\"ffield84\" type=\"CheckBox\" value=\"Yes\"> Add CPU for $1<input name=\"ffield84\" type=\"Hidden\" value=\"0.00\"><input name=\"ffield84\" type=\"Hidden\" value=\"No\"><input name=\"ffield84\" type=\"Hidden\" value=\"0.00\">','Add CPU','13706',NULL,NULL,NULL);

/*Table structure for table `options_stocklevels` */

CREATE TABLE `options_stocklevels` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `optionid` int(10) DEFAULT NULL,
  `itemid` int(10) DEFAULT NULL,
  `option_combo` varchar(255) DEFAULT NULL,
  `unitsinstock` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `options_stocklevels` */

/*Table structure for table `orders` */

CREATE TABLE `orders` (
  `OrderID` int(10) NOT NULL AUTO_INCREMENT,
  `OrderNumber` varchar(50) DEFAULT NULL,
  `CustomerID` int(10) DEFAULT NULL,
  `CrtItemID` longtext,
  `CrtProductID` longtext,
  `CrtProductName` longtext,
  `CrtPrice` longtext,
  `CrtQuantity` longtext,
  `Notes` longtext,
  `QuotedShipping` varchar(50) DEFAULT NULL,
  `FiguredTax` varchar(50) DEFAULT NULL,
  `OrderStatus` varchar(50) DEFAULT NULL,
  `DateOfOrder` datetime NOT NULL,
  `TrackingNumber` longtext,
  `PaymentMethod` varchar(50) DEFAULT NULL,
  `OrderCompleted` varchar(50) DEFAULT NULL,
  `ShippingMethod` varchar(50) DEFAULT NULL,
  `PromoCode` varchar(50) DEFAULT NULL,
  `DiscountAmount` varchar(50) DEFAULT NULL,
  `OrderTotal` float(10,2) DEFAULT NULL,
  `ShippedTo` longtext,
  `ShipDate` varchar(50) DEFAULT NULL,
  `Memo` longtext,
  `CreditCardType` varchar(50) DEFAULT NULL,
  `CreditCardNumber` varchar(50) DEFAULT NULL,
  `CreditCardExpire` varchar(50) DEFAULT NULL,
  `CCConfirmationNumber` varchar(50) DEFAULT NULL,
  `FraudFlag` varchar(50) DEFAULT NULL,
  `FraudReason` longtext,
  `VisitorIP` varchar(50) DEFAULT NULL,
  `CrtType` longtext,
  `CrtApproved` longtext,
  `CrtCoupons` longtext,
  `downloads` varchar(50) DEFAULT NULL,
  `paid` varchar(50) DEFAULT NULL,
  `TransID` varchar(255) DEFAULT NULL,
  `TransactionType` varchar(50) DEFAULT NULL,
  `pnref` varchar(50) DEFAULT NULL,
  `CrtShipped` longtext,
  `CrtTrackingNumbers` longtext,
  `CrtPackageNumber` longtext,
  `ShipName` varchar(255) DEFAULT NULL,
  `ShipFirstName` varchar(255) DEFAULT NULL,
  `ShipLastName` varchar(255) DEFAULT NULL,
  `ShipBusinessname` varchar(255) DEFAULT NULL,
  `ShipAddress` varchar(255) DEFAULT NULL,
  `ShipAddress2` varchar(255) DEFAULT NULL,
  `ShipCity` varchar(255) DEFAULT NULL,
  `ShipState` varchar(255) DEFAULT NULL,
  `ShipZip` varchar(255) DEFAULT NULL,
  `ShipCountry` varchar(255) DEFAULT NULL,
  `giftcode` varchar(255) DEFAULT NULL,
  `giftamountused` varchar(50) DEFAULT NULL,
  `GiftCardUpdated` varchar(50) DEFAULT NULL,
  `affiliateid` varchar(50) DEFAULT NULL,
  `paymentstatus` varchar(255) DEFAULT NULL,
  `payment_pending_reason` varchar(255) DEFAULT NULL,
  `po_number` varchar(255) DEFAULT NULL,
  `accesscode` varchar(255) DEFAULT NULL,
  `processed` varchar(255) DEFAULT NULL,
  `repstore` varchar(255) DEFAULT NULL,
  `referredbyemail` varchar(255) DEFAULT 'None',
  `referral_counted` varchar(50) DEFAULT 'No',
  `phone_order` varchar(50) DEFAULT 'No',
  `sent_emails` int(5) DEFAULT '0',
  PRIMARY KEY (`OrderID`),
  KEY `NewIndex1` (`OrderNumber`,`CustomerID`,`OrderStatus`,`PaymentMethod`,`paid`,`affiliateid`,`OrderCompleted`)
) ENGINE=MyISAM AUTO_INCREMENT=784 DEFAULT CHARSET=latin1;

/*Data for the table `orders` */

/*Table structure for table `orders_items` */

CREATE TABLE `orders_items` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ordernumber` varchar(255) DEFAULT NULL,
  `itemname` varchar(255) DEFAULT NULL,
  `itemid` varchar(255) DEFAULT NULL,
  `itemsku` varchar(255) DEFAULT NULL,
  `quantity` varchar(50) DEFAULT NULL,
  `item_price` varchar(50) DEFAULT NULL,
  `item_type` varchar(255) DEFAULT NULL,
  `item_status` varchar(255) DEFAULT NULL,
  `item_package` varchar(255) DEFAULT NULL,
  `item_tracking` varchar(255) DEFAULT NULL,
  `item_notes` longtext,
  UNIQUE KEY `id` (`id`),
  KEY `NewIndex1` (`ordernumber`,`itemid`,`itemsku`)
) ENGINE=MyISAM AUTO_INCREMENT=271 DEFAULT CHARSET=latin1;

/*Data for the table `orders_items` */

/*Table structure for table `orders_options` */

CREATE TABLE `orders_options` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `OrderNumber` varchar(255) DEFAULT NULL,
  `OptionID` varchar(255) DEFAULT NULL,
  `OptionValue` longtext,
  `ItemID` varchar(255) DEFAULT NULL COMMENT 'ItemID this options goes with in the cart',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`OrderNumber`,`ItemID`(50),`OptionID`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

/*Data for the table `orders_options` */

/*Table structure for table `ponumbers` */

CREATE TABLE `ponumbers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_number` varchar(255) DEFAULT NULL,
  `CompanyName` varchar(255) DEFAULT NULL,
  `ContactName` varchar(255) DEFAULT NULL,
  `Phone` varchar(255) DEFAULT NULL,
  `dateissued` date DEFAULT NULL,
  `filenumber` varchar(255) DEFAULT NULL,
  `notes` longtext,
  `ordernumber` varchar(255) DEFAULT NULL,
  `dateused` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`po_number`,`ordernumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ponumbers` */

/*Table structure for table `private_pages` */

CREATE TABLE `private_pages` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `page_filename` varchar(255) DEFAULT NULL,
  `subscription_id` varchar(50) DEFAULT NULL,
  `pword` varchar(255) DEFAULT NULL,
  `groupid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`page_filename`,`subscription_id`,`pword`,`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `private_pages` */

/*Table structure for table `product_categories` */

CREATE TABLE `product_categories` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `itemid` int(20) DEFAULT NULL,
  `categoryid` int(20) DEFAULT NULL,
  `ordervalue` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`itemid`,`categoryid`)
) ENGINE=MyISAM AUTO_INCREMENT=30751 DEFAULT CHARSET=latin1;

/*Data for the table `product_categories` */

insert  into `product_categories`(`id`,`itemid`,`categoryid`,`ordervalue`) values (30735,13702,100394,13),(30736,13702,100397,13),(30741,13703,100394,NULL),(30742,13703,100397,NULL),(30743,13704,100394,14),(30744,13704,100395,14),(30745,13704,100396,14),(30746,13705,100395,15),(30747,13705,100396,15),(30750,13706,0,NULL);

/*Table structure for table `product_categories_templates` */

CREATE TABLE `product_categories_templates` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `itemid` int(20) DEFAULT NULL,
  `categoryid` int(20) DEFAULT NULL,
  `ordervalue` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`itemid`,`categoryid`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `product_categories_templates` */

/*Table structure for table `product_files` */

CREATE TABLE `product_files` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) DEFAULT NULL,
  `itemid` varchar(50) DEFAULT NULL,
  `AllowedDls` int(10) DEFAULT NULL,
  `filesize` varchar(50) DEFAULT NULL,
  `timesdownloaded` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`itemid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `product_files` */

/*Table structure for table `product_reviews` */

CREATE TABLE `product_reviews` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `itemid` int(10) DEFAULT NULL,
  `reviewer` varchar(255) DEFAULT NULL,
  `value` int(5) DEFAULT NULL,
  `features` int(5) DEFAULT NULL,
  `quality` int(5) DEFAULT NULL,
  `performance` int(5) DEFAULT NULL,
  `details` longtext,
  `rating` int(5) DEFAULT NULL,
  `approved` varchar(50) DEFAULT NULL,
  `review_date` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `NewIndex1` (`itemid`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `product_reviews` */

/*Table structure for table `products` */

CREATE TABLE `products` (
  `ItemID` int(10) NOT NULL AUTO_INCREMENT,
  `ProductID` varchar(50) DEFAULT NULL,
  `ProductName` varchar(255) DEFAULT 'None',
  `BriefDescription` longtext,
  `Price` float(10,2) DEFAULT '0.00',
  `WholesalePrice` varchar(100) DEFAULT '0.00',
  `ListPrice` varchar(100) DEFAULT '0.00',
  `UnitsInStock` int(10) DEFAULT '999',
  `UnitsSold` int(10) DEFAULT '0',
  `ImageURL` varchar(255) DEFAULT 'nopic.jpg',
  `Category` longtext,
  `Details` longtext,
  `Thumbnail` varchar(255) DEFAULT 'nopic.jpg',
  `FormFields` varchar(255) DEFAULT NULL,
  `IsFeatured` varchar(50) DEFAULT 'No',
  `ShippingCosts` varchar(50) DEFAULT '0.00',
  `Weight` varchar(50) DEFAULT '1.00',
  `TimesViewed` int(10) DEFAULT '0',
  `SupplierID` varchar(50) DEFAULT '0',
  `ChargeTaxes` varchar(50) DEFAULT 'Yes',
  `ChargeShipping` varchar(50) DEFAULT 'Yes',
  `ShowQuantity` varchar(50) DEFAULT 'Yes',
  `CanBackOrder` varchar(50) DEFAULT 'No',
  `egoodfilename` longtext,
  `FOrderValue` int(10) DEFAULT '1',
  `listoptions` varchar(50) DEFAULT 'Yes',
  `showprice` varchar(50) DEFAULT 'Yes',
  `showwsprice` varchar(100) DEFAULT 'No',
  `showlistprice` varchar(100) DEFAULT 'No',
  `showvoldiscounts` varchar(50) DEFAULT 'Yes',
  `showimage` varchar(50) DEFAULT 'Yes',
  `showaddtocartbutton` varchar(50) DEFAULT 'Yes',
  `showtitle` varchar(50) DEFAULT 'Yes',
  `issubscription` varchar(50) DEFAULT 'No',
  `Permissions` longtext,
  `NeverExpires` varchar(50) DEFAULT NULL,
  `ExpireSelect` varchar(50) DEFAULT NULL,
  `SimilarItems` longtext,
  `DateAdded` date DEFAULT NULL,
  `ShipsAlone` varchar(50) DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `subof` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'active',
  `isgift` varchar(50) DEFAULT 'No',
  `Expireson` datetime DEFAULT NULL,
  `rating` float(10,2) DEFAULT '0.00',
  `availability` varchar(255) DEFAULT NULL,
  `reviews` int(10) DEFAULT '0',
  `mfg` varchar(255) DEFAULT NULL,
  `upc` varchar(255) DEFAULT NULL,
  `ImportKey` varchar(255) DEFAULT NULL,
  `OneClickOrdering` varchar(50) DEFAULT NULL,
  `AskForShipping` varchar(50) DEFAULT 'Yes',
  `c_override_on` varchar(50) DEFAULT 'No',
  `c_override_type` varchar(50) DEFAULT 'AmountOff',
  `c_override` float(10,2) DEFAULT '0.00',
  `c_override_2` float(10,2) DEFAULT '0.00',
  `urlrw` longtext,
  `isoption` int(10) DEFAULT '0',
  PRIMARY KEY (`ItemID`),
  KEY `NewIndex1` (`ProductID`,`sku`,`subof`,`ImportKey`)
) ENGINE=MyISAM AUTO_INCREMENT=13707 DEFAULT CHARSET=latin1;

/*Data for the table `products` */

insert  into `products`(`ItemID`,`ProductID`,`ProductName`,`BriefDescription`,`Price`,`WholesalePrice`,`ListPrice`,`UnitsInStock`,`UnitsSold`,`ImageURL`,`Category`,`Details`,`Thumbnail`,`FormFields`,`IsFeatured`,`ShippingCosts`,`Weight`,`TimesViewed`,`SupplierID`,`ChargeTaxes`,`ChargeShipping`,`ShowQuantity`,`CanBackOrder`,`egoodfilename`,`FOrderValue`,`listoptions`,`showprice`,`showwsprice`,`showlistprice`,`showvoldiscounts`,`showimage`,`showaddtocartbutton`,`showtitle`,`issubscription`,`Permissions`,`NeverExpires`,`ExpireSelect`,`SimilarItems`,`DateAdded`,`ShipsAlone`,`sku`,`brand`,`subof`,`status`,`isgift`,`Expireson`,`rating`,`availability`,`reviews`,`mfg`,`upc`,`ImportKey`,`OneClickOrdering`,`AskForShipping`,`c_override_on`,`c_override_type`,`c_override`,`c_override_2`,`urlrw`,`isoption`) values (13686,'101','Tshirt','Nothing Fancy, just a basic T-Shirt sample product',30.00,'0.00','0.00',996,3,'tshirt1.jpg','|100388|','<h2>\r\n	Basic Product Sample 1</h2>\r\n<p>\r\n	This example demonstrates how a product looks and works without any options or anything.&nbsp; Click the Add to Cart Button to put this item into your shopping cart.</p>\r\n','tshirt1.jpg',NULL,'Yes','0.00','1.00',127,'0','Yes','Yes','Yes','No',NULL,1,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','no',NULL,NULL,NULL,NULL,'2010-08-10',NULL,'101','','','active','No',NULL,0.00,'',0,'','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Tshirt',0),(13687,'102','Demo GPS Unit','Demonstrates Multiple Images',200.00,'0.00','0.00',999,0,'gps-main.jpg','|100388|','<div>\r\n	<em><strong>This product demonstrates how you can add multiple images to a product as well as video.&nbsp; You can also include additional images in your description.</strong></em></div>\r\n<div>\r\n	<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0\"><param name=\"quality\" value=\"high\" /><param 640=\"\" height=\"385\" name=\"movie\" value=\"&lt;object width=\" /><param name=\"movie\" value=\"http://www.youtube.com/v/4jxXixRHj90&amp;color1=0xb1b1b1&amp;color2=0xd0d0d0&amp;hl=en_US&amp;feature=player_embedded&amp;fs=1\" /><param name=\"allowFullScreen\" value=\"true\" /><param name=\"allowScriptAccess\" value=\"always\" /><embed allowfullscreen=\"true\" allowscriptaccess=\"always\" height=\"385\" src=\"http://www.youtube.com/v/4jxXixRHj90&amp;color1=0xb1b1b1&amp;color2=0xd0d0d0&amp;hl=en_US&amp;feature=player_embedded&amp;fs=1\" type=\"application/x-shockwave-flash\" width=\"640\"></embed></object></div>\r\n<div>\r\n	<img alt=\"\" src=\"/images/gps-body2.jpg\" style=\"width: 500px; height: 424px;\" /></div>\r\n<div>\r\n	<img alt=\"\" src=\"/images/gps-body1.jpg\" style=\"width: 630px; height: 480px;\" /></div>\r\n','gps-main.jpg',NULL,'Yes','0.00','1.00',139,'0','Yes','Yes','Yes','No',NULL,2,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','no',NULL,NULL,NULL,NULL,'2010-08-10',NULL,'102','','','active','No',NULL,0.00,'',0,'','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Demo-GPS-Unit',0),(13688,'103','Tshirt with Drop Down Size Selection','Demo product to show off basic options drop downs',20.00,'0.00','0.00',997,2,'tshirt_green.jpg',NULL,'<h2>\r\n	Tshirt with option drop down.</h2>\r\n<p>\r\n	This demonstration shows off the ability to add drop down boxes to your products so that you can have a customer choose a size (or any other options).</p>\r\n','tshirt_green.jpg',NULL,'Yes','0.00','1.00',123,'0','Yes','Yes','Yes','No',NULL,3,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','No',NULL,NULL,NULL,NULL,'2010-08-10',NULL,'103','','','active','No',NULL,0.00,'',0,'','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Tshirt-with-Drop-Down-Size-Selection',0),(13689,'105','Example Tshirt with subitems','This example shows you the use of subitems',5.00,'0.00','0.00',999,0,'tshirt_black.jpg','|100389|','<p>\r\n	Besides using options you can use sub items instead.&nbsp; To create subitems you simply duplicate a product ID.&nbsp; All items added after the first tiem become a subitem of the first.</p>\r\n<p>\r\n	Choose a Color</p>\r\n','tshirt_black.jpg',NULL,'No','0.00','1.00',180,'0','Yes','Yes','Yes','No',NULL,4,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','no',NULL,NULL,NULL,'13687^13686','2010-08-11',NULL,'105','','','active','No',NULL,0.00,'Ships in 1 Business Day',0,'','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Example-Tshirt-with-subitems',0),(13690,'105','Green','Green',10.00,'0.00','0.00',996,3,'tshirt_green.jpg',NULL,'<p>\r\n	Green</p>\r\n','nopic.jpg',NULL,'No','0.00','1.00',0,'0','Yes','Yes','Yes','No',NULL,5,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','No',NULL,NULL,NULL,NULL,'2010-08-11',NULL,'105-1','','13689','active','No',NULL,0.00,'',0,'','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Green',0),(13691,'105','Red','Red',10.00,'0.00','0.00',995,4,'tshirt_red.jpg','||','<p>\r\n	Red</p>\r\n','nopic.jpg','','No','0.00','1.00',0,'0','Yes','Yes','Yes','No','',5,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','no','','','','','2010-08-11','','105-2','','13689','active','No',NULL,0.00,'',0,'','','','No','Yes','No','AmountOff',0.00,0.00,'Red',0),(13692,'105','Blue','Blue',10.00,'0.00','0.00',998,1,'tshirt_blue.jpg','||||','<p>\r\n	Blue</p>\r\n','nopic.jpg','','No','0.00','1.00',0,'0','Yes','Yes','Yes','No','',5,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','no','','','','','2010-08-11','','105-3','','13689','active','No',NULL,0.00,'',0,'','','','No','Yes','No','AmountOff',0.00,0.00,'Blue',0),(13693,'555-Small','Green Small (555-Small)','Item is an option for 555',0.00,'0.00','0.00',5,0,'nopic.jpg','|100389|','<p>\r\n	Item is just an option and nothing will be shown</p>\r\n','nopic.jpg',NULL,'No','0.00','1.00',4,'0','Yes','Yes','Yes','No',NULL,6,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','no',NULL,NULL,NULL,NULL,'2010-08-11',NULL,'555-Small','','','active','No',NULL,0.00,'',0,'','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Green-Small-555-Small',1),(13694,'555-Medium','Medium Shirt for 555','Option for 555',0.00,'0.00','0.00',-1,0,'nopic.jpg','|100389|','<p>\r\n	Item is just an option and nothing will be shown</p>\r\n','nopic.jpg','','No','0.00','1.00',0,'0','Yes','Yes','Yes','No','',6,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','no','','','','','2010-08-11','','555-Medium','','','active','No',NULL,0.00,'',0,'','','','No','Yes','No','AmountOff',0.00,0.00,'Medium-Shirt-for-555',1),(13695,'555-Large','Large Shirt for 555','Option for 555',0.00,'0.00','0.00',1,0,'nopic.jpg','|100389|','<p>\r\n	Item is just an option and nothing will be shown</p>\r\n','nopic.jpg','','No','0.00','1.00',0,'0','Yes','Yes','Yes','No','',6,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','no','','','','','2010-08-11','','555-Large','','','active','No',NULL,0.00,'',0,'','','','No','Yes','No','AmountOff',0.00,0.00,'Large-Shirt-for-555',1),(13696,'555','Green Tshirt Example with Options Having Inventory Tracked','This option demos the ability to track inventory through options.',15.00,'0.00','0.00',12,4,'tshirt_green.jpg','|100389|','<p>\r\n	This product shows how you an track inventory of options.&nbsp; To track inventory, you create products for each option.&nbsp; Lets say you have a green shirt that comes in Green and you have Small, Medium, and Large but you have limited stock on each size.&nbsp; You prefer to offer a drop down box to select the size they want.&nbsp; You create one main product and then 3 addiitonal products.&nbsp; The 3 additional products you mark as options so they don&#39;t show up in the catalog.&nbsp; Their settings pretty much all get ignored, because they are only in the catalog for the purposes of tracking inventory.</p>\r\n<p>\r\n	You then create your option drop down box and you assign the product&#39;s ItemID to the option so that it can be tracked.</p>\r\n','tshirt_green.jpg',NULL,'No','0.00','1.00',89,'0','Yes','Yes','Yes','No',NULL,7,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','no',NULL,NULL,NULL,NULL,'2010-08-11',NULL,'555','','','active','No',NULL,0.00,'Ships in 1 Business Day',0,'','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Green-Tshirt-Example-with-Options-Having-Inventory-Tracked',0),(13697,'108','Item with various Option Form Fields','Demo of option form fields',5.00,'0.00','0.00',999,0,'linux.gif',NULL,'<p>\r\n	This demonstrates how you can collect information using option form fields.</p>\r\n','linux.gif',NULL,'No','0.00','1.00',29,'0','Yes','Yes','Yes','No',NULL,8,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','No',NULL,NULL,NULL,NULL,'2010-08-11',NULL,'108','','','active','No',NULL,0.00,'',0,'','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Item-with-various-Option-Form-Fields',0),(13698,'201','Custom Product Page Example','Custom Product Page Example',5.00,'0.00','0.00',997,2,'windows.jpg','|100390|','<h2>\r\n	Get a Copy of Windoze 2020 fpr $5.00</h2>\r\n<p>\r\n	<img alt=\"\" src=\"/images/windows.jpg\" style=\"width: 100px; height: 89px;\" /><br />\r\n	&nbsp;</p>\r\n<p>\r\n	It is possible to make custom product pages.&nbsp; You can copy and paste the add to cart button HTML anywhere you want!&nbsp; You could create a page, customize your details page more, or add an add to cart button to a category.</p>\r\n<form action=\"http://www.jwcables.com/?action=addtocart\" method=\"POST\" name=\"AddToCartForm\">\r\n	Qty: <input name=\"Quantity\" size=\"4\" type=\"text\" value=\"1\" /><input name=\"ItemID\" type=\"Hidden\" value=\"13698\" /> <input name=\"AddToCart\" src=\"http://www.jwcables.com/images/buttons/add_to_cart.gif\" type=\"image\" />&nbsp;</form>\r\n','windows.jpg',NULL,'No','0.00','1.00',71,'0','Yes','Yes','Yes','No',NULL,9,'Yes','No','No','No','No','No','No','No','no',NULL,NULL,NULL,NULL,'2010-08-11',NULL,'201','','','active','No',NULL,0.00,'',0,'','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Custom-Product-Page-Example',0),(13699,'301','Item 1','This is part of the custom order page demo',1.00,'0.00','0.00',999,0,'logo.png',NULL,'<p>\r\n	This item is part of a custom order page.</p>\r\n','logo.png',NULL,'No','0.00','1.00',0,'0','Yes','Yes','Yes','No',NULL,10,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','No',NULL,NULL,NULL,NULL,'2010-08-11',NULL,'301','','','active','No',NULL,0.00,'',0,'','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Item-1',0),(13700,'302','Item 2','Custom order form page item 2',1.00,'0.00','0.00',999,0,'logo.png',NULL,'<p>\r\n	Sample 2</p>\r\n','logo.png',NULL,'No','0.00','1.00',0,'0','Yes','Yes','Yes','No',NULL,11,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','No',NULL,NULL,NULL,NULL,'2010-08-11',NULL,'302','','','active','No',NULL,0.00,'',0,'','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Item-2',0),(13701,'303','Item 3','Custom order page sample item 3',1.00,'0.00','0.00',999,0,'logo.png',NULL,'<p>\r\n	Part of the custom order page demo.</p>\r\n','logo.png',NULL,'No','0.00','1.00',2,'0','Yes','Yes','Yes','No',NULL,12,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','No',NULL,NULL,NULL,NULL,'2010-08-11',NULL,'303`','','','active','No',NULL,0.00,'',0,'','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Item-3',0),(13702,'demo1','Memory Demo 1','',1.00,'0.00','0.00',999,0,'computer-memory-ch.jpg',NULL,'','computer-memory-ch.jpg',NULL,'No','0.00','1.00',4,'0','Yes','Yes','Yes','No',NULL,13,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','No',NULL,NULL,NULL,NULL,'2012-05-02',NULL,'demo1','Acme','','active','No',NULL,0.00,'Ships in 1 Business Day',0,'Acme','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Memory-Demo-1',0),(13703,'demo1-13703','Memory Demo 2','',1.00,'0.00','0.00',999,0,'computer-memory-ch.jpg','|100394|100397|','<p>\r\n	These are product details.&nbsp; You can use HTML</p>\r\n<p>\r\n	<img alt=\"\" src=\"/images/loremipsum.jpg\" style=\"width: 400px; height: 400px;\" /></p>\r\n<p>\r\n	You can add images and videos if you want to.</p>','computer-memory-ch.jpg','','No','0.00','1.00',4,'0','Yes','Yes','Yes','No','',13,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','no','','','','','2012-05-02','','demo1-13703','Acme','','active','No',NULL,0.00,'Ships in 1 Business Day',0,'Acme','','','No','Yes','No','AmountOff',0.00,0.00,'Memory-Demo-1',0),(13704,'demo3','Motherboard demo item','Another demo item',1.00,'0.00','0.00',999,0,'Motherboard.jpg',NULL,'<p>\r\n	Another demo item</p>\r\n','Motherboard.jpg',NULL,'No','0.00','1.00',14,'0','Yes','Yes','Yes','No',NULL,14,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','No',NULL,NULL,NULL,NULL,'2012-05-02',NULL,'demo3','Acme','','active','No',NULL,0.00,'',0,'','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Motherboard-demo-item',0),(13705,'demo4','Demo CPU Item','demo item 4',1.00,'0.00','0.00',999,0,'p4pers320.jpg',NULL,'<p>\r\n	Another demo item</p>\r\n','p4pers320.jpg',NULL,'No','0.00','1.00',0,'0','Yes','Yes','Yes','No',NULL,15,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','No',NULL,NULL,NULL,NULL,'2012-05-02',NULL,'demo4','Acme','','active','No',NULL,0.00,'',0,'','',NULL,'No','Yes','No','AmountOff',0.00,0.00,'Demo-CPU-Item',0),(13706,'demo4-13706','Demo CPU Upgrade','demo item 4',1.00,'0.00','0.00',999,0,'p4pers320.jpg','|0|','<p>\r\n	Another demo item</p>\r\n','p4pers320.jpg','','No','0.00','1.00',0,'0','Yes','Yes','Yes','No','',15,'Yes','Yes','No','No','Yes','Yes','Yes','Yes','no','','','','','2012-05-02','','demo4-13706','Acme','','active','No',NULL,0.00,'',0,'','','','No','Yes','No','AmountOff',0.00,0.00,'Demo-CPU-Item',1);

/*Table structure for table `products_images` */

CREATE TABLE `products_images` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `iFileName` varchar(150) DEFAULT NULL,
  `ItemID` varchar(50) DEFAULT NULL,
  `iHeight` int(10) DEFAULT NULL,
  `iWidth` int(10) DEFAULT NULL,
  `thumbHeight` int(10) DEFAULT NULL,
  `thumbWidth` int(10) DEFAULT NULL,
  `tinyHeight` int(10) DEFAULT NULL,
  `tinyWidth` int(10) DEFAULT NULL,
  `OrderValue` int(10) DEFAULT NULL,
  `mediumheight` int(10) DEFAULT NULL,
  `mediumwidth` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`ItemID`,`iFileName`)
) ENGINE=MyISAM AUTO_INCREMENT=15455 DEFAULT CHARSET=latin1;

/*Data for the table `products_images` */

insert  into `products_images`(`id`,`iFileName`,`ItemID`,`iHeight`,`iWidth`,`thumbHeight`,`thumbWidth`,`tinyHeight`,`tinyWidth`,`OrderValue`,`mediumheight`,`mediumwidth`) values (15426,'gps-main.jpg','13687',300,300,100,100,75,75,3,249,249),(15425,'tshirt1.jpg','13686',500,500,100,100,75,75,2,250,250),(15427,'gps-01.jpg','13687',500,500,100,100,75,75,4,250,250),(15428,'gps-02.jpg','13687',500,500,100,100,75,75,5,250,250),(15429,'gps-03.jpg','13687',500,500,100,100,75,75,6,250,250),(15430,'gps-04.jpg','13687',500,500,100,100,75,75,7,250,250),(15431,'gps-05.jpg','13687',500,500,100,100,75,75,8,250,250),(15432,'gps-06.jpg','13687',500,500,100,100,75,75,9,250,250),(15433,'gps-07.jpg','13687',500,500,100,100,75,75,10,250,250),(15434,'gps-08.jpg','13687',500,500,100,100,75,75,11,250,250),(15435,'gps-09.jpg','13687',500,500,100,100,75,75,12,250,250),(15436,'tshirt_green.jpg','13688',250,250,100,100,75,75,13,250,250),(15437,'tshirt_black.jpg','13689',250,250,100,100,75,75,14,250,250),(15438,'tshirt_green.jpg','13696',250,250,100,100,75,75,15,250,250),(15439,'linux.gif','13697',275,250,110,100,82,75,16,275,250),(15443,'tshirt_green.jpg','13690',250,250,100,100,75,75,1,250,250),(15444,'tshirt_red.jpg','13691',250,250,100,100,75,75,1,250,250),(15445,'tshirt_blue.jpg','13692',250,250,100,100,75,75,1,250,250),(15446,'windows.jpg','13698',89,100,89,100,66,75,17,89,100),(15447,'logo.png','13699',102,256,39,100,29,75,18,99,250),(15448,'logo.png','13700',102,256,39,100,29,75,19,99,250),(15449,'logo.png','13701',102,256,39,100,29,75,20,99,250),(15451,'computer-memory-ch.jpg','13702',200,200,100,100,75,75,1,200,200),(15452,'computer-memory-ch.jpg','13703',200,200,100,100,75,75,1,200,200),(15453,'Motherboard.jpg','13704',377,500,75,100,57,75,21,189,250),(15454,'p4pers320.jpg','13705',268,320,84,100,63,75,22,209,250);

/*Table structure for table `products_options` */

CREATE TABLE `products_options` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `optionid` int(50) DEFAULT NULL,
  `itemid` int(50) DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `NewIndex1` (`optionid`,`itemid`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

/*Data for the table `products_options` */

insert  into `products_options`(`id`,`optionid`,`itemid`) values (33,76,13697),(32,74,13697),(31,73,13697),(17,65,13696),(36,81,13692),(35,80,13691),(34,79,13690),(23,70,13689),(37,82,13688),(39,84,13704);

/*Table structure for table `products_pricing` */

CREATE TABLE `products_pricing` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `level` int(10) DEFAULT '1',
  `price` float(10,2) DEFAULT '0.00',
  `itemid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`level`,`itemid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `products_pricing` */

/*Table structure for table `products_subscriptions` */

CREATE TABLE `products_subscriptions` (
  `r_id` int(10) NOT NULL AUTO_INCREMENT,
  `itemid` varchar(50) DEFAULT NULL,
  `r_name` varchar(255) DEFAULT NULL,
  `r_startupfee` varchar(50) DEFAULT NULL,
  `r_fee` varchar(50) DEFAULT NULL,
  `r_frequency` varchar(50) DEFAULT NULL COMMENT 'M, W, or Y',
  `r_expiresin` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`r_id`),
  KEY `NewIndex1` (`itemid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `products_subscriptions` */

/*Table structure for table `products_templates` */

CREATE TABLE `products_templates` (
  `ItemID` int(10) NOT NULL,
  `ProductID` varchar(50) DEFAULT NULL,
  `ProductName` varchar(255) DEFAULT 'None',
  `BriefDescription` longtext,
  `Price` float(10,2) DEFAULT '0.00',
  `WholesalePrice` varchar(100) DEFAULT '0.00',
  `ListPrice` varchar(100) DEFAULT '0.00',
  `UnitsInStock` int(10) DEFAULT '999',
  `UnitsSold` int(10) DEFAULT '0',
  `ImageURL` varchar(255) DEFAULT 'nopic.jpg',
  `Category` longtext,
  `Details` longtext,
  `Thumbnail` varchar(255) DEFAULT 'nopic.jpg',
  `FormFields` varchar(255) DEFAULT NULL,
  `IsFeatured` varchar(50) DEFAULT 'No',
  `ShippingCosts` varchar(50) DEFAULT '0.00',
  `Weight` varchar(50) DEFAULT '1.00',
  `TimesViewed` int(10) DEFAULT '0',
  `SupplierID` varchar(50) DEFAULT '0',
  `ChargeTaxes` varchar(50) DEFAULT 'Yes',
  `ChargeShipping` varchar(50) DEFAULT 'Yes',
  `ShowQuantity` varchar(50) DEFAULT 'Yes',
  `CanBackOrder` varchar(50) DEFAULT 'No',
  `egoodfilename` longtext,
  `FOrderValue` int(10) DEFAULT '1',
  `listoptions` varchar(50) DEFAULT 'Yes',
  `showprice` varchar(50) DEFAULT 'Yes',
  `showwsprice` varchar(100) DEFAULT 'No',
  `showlistprice` varchar(100) DEFAULT 'No',
  `showvoldiscounts` varchar(50) DEFAULT 'Yes',
  `showimage` varchar(50) DEFAULT 'Yes',
  `showaddtocartbutton` varchar(50) DEFAULT 'Yes',
  `showtitle` varchar(50) DEFAULT 'Yes',
  `issubscription` varchar(50) DEFAULT 'No',
  `Permissions` longtext,
  `NeverExpires` varchar(50) DEFAULT NULL,
  `ExpireSelect` varchar(50) DEFAULT NULL,
  `SimilarItems` longtext,
  `DateAdded` date DEFAULT NULL,
  `ShipsAlone` varchar(50) DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `subof` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'active',
  `isgift` varchar(50) DEFAULT 'No',
  `Expireson` datetime DEFAULT NULL,
  `rating` float(10,2) DEFAULT '0.00',
  `availability` varchar(255) DEFAULT NULL,
  `reviews` int(10) DEFAULT '0',
  `mfg` varchar(255) DEFAULT NULL,
  `upc` varchar(255) DEFAULT NULL,
  `ImportKey` varchar(255) DEFAULT NULL,
  `OneClickOrdering` varchar(50) DEFAULT NULL,
  `AskForShipping` varchar(50) DEFAULT 'Yes',
  `c_override_on` varchar(50) DEFAULT 'No',
  `c_override_type` varchar(50) DEFAULT 'AmountOff',
  `c_override` float(10,2) DEFAULT '0.00',
  `c_override_2` float(10,2) DEFAULT '0.00',
  `urlrw` longtext,
  PRIMARY KEY (`ItemID`),
  KEY `NewIndex1` (`ProductID`,`sku`,`ImportKey`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `products_templates` */

/*Table structure for table `promos` */

CREATE TABLE `promos` (
  `PromoID` int(10) NOT NULL AUTO_INCREMENT,
  `PromoCode` varchar(50) DEFAULT NULL,
  `AmountOff` varchar(50) DEFAULT NULL,
  `PromoType` varchar(50) DEFAULT NULL,
  `TimesAllowed` int(10) DEFAULT NULL,
  `ExpiresOn` date DEFAULT NULL,
  `ProductID` varchar(50) DEFAULT NULL,
  `CategoryID` varchar(50) DEFAULT NULL,
  `CanBeCombined` varchar(50) DEFAULT NULL,
  `cLimit` int(10) DEFAULT NULL,
  PRIMARY KEY (`PromoID`),
  KEY `NewIndex1` (`PromoCode`,`ProductID`,`CategoryID`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `promos` */

/*Table structure for table `sales` */

CREATE TABLE `sales` (
  `saleid` int(10) NOT NULL AUTO_INCREMENT,
  `IndefSale` varchar(50) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `SaleType` varchar(50) DEFAULT NULL,
  `AmountOff` int(10) DEFAULT NULL,
  `CategoryID` varchar(50) DEFAULT NULL,
  `ProductID` varchar(50) DEFAULT NULL,
  `level` int(10) DEFAULT '0',
  PRIMARY KEY (`saleid`),
  KEY `NewIndex1` (`CategoryID`,`ProductID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `sales` */

/*Table structure for table `search_terms` */

CREATE TABLE `search_terms` (
  `term` varchar(255) DEFAULT NULL,
  `count` int(10) unsigned DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `search_terms` */

/*Table structure for table `sellingareas` */

CREATE TABLE `sellingareas` (
  `RegionID` int(10) NOT NULL AUTO_INCREMENT,
  `Countries` longtext,
  `CountryCodes` longtext,
  `States` longtext,
  `StateCodes` longtext,
  `SelectedCountries` longtext,
  `SelectedCCodes` longtext,
  `SelectedStates` longtext,
  `SelectedSCodes` longtext,
  PRIMARY KEY (`RegionID`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `sellingareas` */

insert  into `sellingareas`(`RegionID`,`Countries`,`CountryCodes`,`States`,`StateCodes`,`SelectedCountries`,`SelectedCCodes`,`SelectedStates`,`SelectedSCodes`) values (2,'Albania,American Samoa,Andorra,Angola,Anguilla,Antigua/Barbuda,Argentina,Armenia,Aruba,Australia,Austria,Azerbaijan,Bahamas,Bahrain,Bangladesh,Barbados,Belarus,Belgium,Belize,Benin,Bermuda,Bhutan,Bolivia,Bosnia-Herzegovina,Botswana,Brazil,British Virgin Islands,Brunei,Bulgaria,Burkina Faso,Burundi,Cambodia,Cameroon,Canada,Cape Verde,Cayman Islands,Chad,Chile,China,Colombia,Congo Brazzaville,Congo Democratic Rep of,Cook Islands,Costa Rica,Croatia,Cyprus,Czech Republic,Denmark,Djibouti,Dominica,Dominican Republic,Ecuador,Egypt,El Salvador,Equatorial Guinea,Eritrea,Estonia,Ethiopia,Faeroe Islands,Fiji,Finland,France,French Guiana,French Polynesia,Gabon,Gambia,Georgia,Germany,Ghana,Gibraltar,Greece,Greenland,Grenada,Guadeloupe,Guam,Guatemala,Guinea,Guyana,Haiti,Honduras,Hong Kong,Hungary,Iceland,India,Indonesia,Ireland,Israel,Italy/Vatican City,Ivory Coast,Jamaica,Japan,Jordan,Kazakhstan,Kenya,Kuwait,Kyrgyzstan,Laos,Latvia,Lebanon,Lesotho,Liberia,Liechtenstein,Lithuania,Luxembourg,Macau,Macedonia,Malawi,Malaysia,Maldives,Mali,Malta,Marshall Islands,Martinique,Mauritania,Mauritius,Mexico,Micronesia,Moldova,Monaco,Mongolia,Montserrat,Morocco,Mozambique,Namibia,Nepal,Netherlands,Netherlands Antilles,New Caledonia,New Zealand,Nicaragua,Niger,Nigeria,Norway,Oman,Pakistan,Palau,Palestine Autonomous,Panama,Papua New Guinea,Paraguay,Peru,Philippines,Poland,Portugal,Puerto Rico,Qatar,Reunion,Romania,Russian Federation,Rwanda,Saipan,Saudi Arabia,Senegal,Seychelles,Singapore,Slovak Republic,Slovenia,South Africa,South Korea,Spain,Sri Lanka,St. Kitts/Nevis,St. Lucia,St. Vincent,Suriname,Swaziland,Sweden,Switzerland,Syria,Taiwan,Tanzania,Thailand,Togo,Trinidad/Tobago,Tunisia,Turkey,Turkmenistan,Turks & Caicos Islands,U.S. Virgin Islands, United States,Uganda,Ukraine,United Arab Emirates,United Kingdom,Uruguay,Uzbekistan,Vanuatu,Venezuela,Vietnam,Wallis &amp; Futuna,Yemen,Yugoslavia,Zambia','AL,AS,AD,AO,AI,AG,AR,AM,AW,AU,AT,AZ,BS,BH,BD,BB,BY,BE,BZ,BJ,BM,BT,BO,BA,BW,BR,VG,BN,BG,BF,BI,KH,CM,CA,CV,KY,TD,CL,CN,CO,CG,CD,CK,CR,HR,CY,CZ,DK,DJ,DM,DO,EC,EG,SV,GQ,ER,EE,ET,FO,FJ,FI,FR,GF,PF,GA,GM,GE,DE,GH,GI,GR,GL,GD,GP,GU,GT,GN,GY,HT,HN,HK,HU,IS,IN,ID,IE,IL,IT,CI,JM,JP,JO,KZ,KE,KW,KG,LA,LV,LB,LS,LR,LI,LT,LU,MO,MK,MW,MY,MV,ML,MT,MH,MQ,MR,MU,MX,FM,MD,MC,MN,MS,MA,MZ,NA,NP,NL,AN,NC,NZ,NI,NE,NG,NO,OM,PK,PW,PS,PA,PG,PY,PE,PH,PL,PT,PR,QA,RE,RO,RU,RW,MP,SA,SN,SC,SG,SK,SI,ZA,KR,ES,LK,KN,LC,VC,SR,SZ,SE,CH,SY,TW,TZ,TH,TG,TT,TN,TR,TM,TC,VI,US,UG,UA,AE,GB,UY,UZ,VU,VE,VN,WF,YE,YU,ZM','Alabama,Alaska,Arizona,Arkansas,California,Colorado,Connecticut,Delaware,District of Columbia,Florida,Georgia,Hawaii,Idaho,Illinois,Indiana,Iowa,Kansas,Kentucky,Louisiana,Maine,Maryland,Massachusetts,Michigan,Minnesota,Mississippi,Missouri,Montana,Nebraska,Nevada,New Hampshire,New Jersey,New Mexico,New York,North Carolina,North Dakota,Ohio,Oklahoma,Oregon,Pennsylvania,Rhode Island,South Carolina,South Dakota,Tennessee,Texas,Utah,Vermont,Virginia,Washington,West Virginia,Wisconsin,Wyoming,Guam,Puerto Rico,Armed Forces Americas (AA),Armed Forces Outside Americas (AE),Armed Forces Pacific (AP),Alberta, British Columbia, Manitoba,New Brunswick,Newfoundland and Labrador,Nova Scotia,Northwest Territories,Nunavut,Ontario,Prince Edward Island,Quebec,Saskatchewan,Yukon','AL,AK,AZ,AR,CA,CO,CT,DE,DC,FL,GA,HI,ID,IL,IN,IA,KS,KY,LA,ME,MD,MA,MI,MN,MS,MO,MT,NE,NV,NH,NJ,NM,NY,NC,ND,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VT,VA,WA,WV,WI,WY,GU,PR,AA,AE,AP,AB,BC,MB,NB,NL,NS,NT,NU,ON,PE,QC,SK,YT',',Albania,American Samoa,Andorra,Angola,Anguilla,Antigua/Barbuda,Argentina,Armenia,Aruba,Australia,Austria,Azerbaijan,Bahamas,Bahrain,Bangladesh,Barbados,Belarus,Belgium,Belize,Benin,Bermuda,Bhutan,Bolivia,Bosnia-Herzegovina,Botswana,Brazil,British Virgin Islands,Brunei,Bulgaria,Burkina Faso,Burundi,Cambodia,Cameroon,Canada,Cape Verde,Cayman Islands,Chad,Chile,China,Colombia,Congo Brazzaville,Congo Democratic Rep of,Cook Islands,Costa Rica,Croatia,Cyprus,Czech Republic,Denmark,Djibouti,Dominica,Dominican Republic,Ecuador,Egypt,El Salvador,Equatorial Guinea,Eritrea,Estonia,Ethiopia,Faeroe Islands,Fiji,Finland,France,French Guiana,French Polynesia,Gabon,Gambia,Georgia,Germany,Ghana,Gibraltar,Greece,Greenland,Grenada,Guadeloupe,Guam,Guatemala,Guinea,Guyana,Haiti,Honduras,Hong Kong,Hungary,Iceland,India,Indonesia,Ireland,Israel,Italy/Vatican City,Ivory Coast,Jamaica,Japan,Jordan,Kazakhstan,Kenya,Kuwait,Kyrgyzstan,Laos,Latvia,Lebanon,Lesotho,Liberia,Liechtenstein,Lithuania,Luxembourg,Macau,Macedonia,Malawi,Malaysia,Maldives,Mali,Malta,Marshall Islands,Martinique,Mauritania,Mauritius,Mexico,Micronesia,Moldova,Monaco,Mongolia,Montserrat,Morocco,Mozambique,Namibia,Nepal,Netherlands,Netherlands Antilles,New Caledonia,New Zealand,Nicaragua,Niger,Nigeria,Norway,Oman,Pakistan,Palau,Palestine Autonomous,Panama,Papua New Guinea,Paraguay,Peru,Philippines,Poland,Portugal,Puerto Rico,Qatar,Reunion,Romania,Russian Federation,Rwanda,Saipan,Saudi Arabia,Senegal,Seychelles,Singapore,Slovak Republic,Slovenia,South Africa,South Korea,Spain,Sri Lanka,St. Kitts/Nevis,St. Lucia,St. Vincent,Suriname,Swaziland,Sweden,Switzerland,Syria,Taiwan,Tanzania,Thailand,Togo,Trinidad/Tobago,Tunisia,Turkey,Turkmenistan,Turks & Caicos Islands,U.S. Virgin Islands, United States,Uganda,Ukraine,United Arab Emirates,United Kingdom,Uruguay,Uzbekistan,Vanuatu,Venezuela,Vietnam,Wallis &amp; Futuna,Yemen,Yugoslavia,Zambia','AL,AS,AD,AO,AI,AG,AR,AM,AW,AU,AT,AZ,BS,BH,BD,BB,BY,BE,BZ,BJ,BM,BT,BO,BA,BW,BR,VG,BN,BG,BF,BI,KH,CM,CA,CV,KY,TD,CL,CN,CO,CG,CD,CK,CR,HR,CY,CZ,DK,DJ,DM,DO,EC,EG,SV,GQ,ER,EE,ET,FO,FJ,FI,FR,GF,PF,GA,GM,GE,DE,GH,GI,GR,GL,GD,GP,GU,GT,GN,GY,HT,HN,HK,HU,IS,IN,ID,IE,IL,IT,CI,JM,JP,JO,KZ,KE,KW,KG,LA,LV,LB,LS,LR,LI,LT,LU,MO,MK,MW,MY,MV,ML,MT,MH,MQ,MR,MU,MX,FM,MD,MC,MN,MS,MA,MZ,NA,NP,NL,AN,NC,NZ,NI,NE,NG,NO,OM,PK,PW,PS,PA,PG,PY,PE,PH,PL,PT,PR,QA,RE,RO,RU,RW,MP,SA,SN,SC,SG,SK,SI,ZA,KR,ES,LK,KN,LC,VC,SR,SZ,SE,CH,SY,TW,TZ,TH,TG,TT,TN,TR,TM,TC,VI,US,UG,UA,AE,GB,UY,UZ,VU,VE,VN,WF,YE,YU,ZM',',Alabama,Alaska,Arizona,Arkansas,California,Colorado,Connecticut,Delaware,District of Columbia,Florida,Georgia,Hawaii,Idaho,Illinois,Indiana,Iowa,Kansas,Kentucky,Louisiana,Maine,Maryland,Massachusetts,Michigan,Minnesota,Mississippi,Missouri,Montana,Nebraska,Nevada,New Hampshire,New Jersey,New Mexico,New York,North Carolina,North Dakota,Ohio,Oklahoma,Oregon,Pennsylvania,Rhode Island,South Carolina,South Dakota,Tennessee,Texas,Utah,Vermont,Virginia,Washington,West Virginia,Wisconsin,Wyoming,Alberta, British Columbia, Manitoba,New Brunswick,Newfoundland and Labrador,Nova Scotia,Northwest Territories,Nunavut,Ontario,Prince Edward Island,Quebec,Saskatchewan,Yukon','AL,AK,AZ,AR,CA,CO,CT,DE,DC,FL,GA,HI,ID,IL,IN,IA,KS,KY,LA,ME,MD,MA,MI,MN,MS,MO,MT,NE,NV,NH,NJ,NM,NY,NC,ND,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VT,VA,WA,WV,WI,WY,AB,BC,MB,NB,NL,NS,NT,NU,ON,PE,QC,SK,YT');

/*Table structure for table `sentmessages` */

CREATE TABLE `sentmessages` (
  `Messageid` int(10) NOT NULL AUTO_INCREMENT,
  `Subject` varchar(255) DEFAULT NULL,
  `EmailBody` longtext,
  `DateSent` date NOT NULL,
  `SentTo` longtext,
  PRIMARY KEY (`Messageid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `sentmessages` */

/*Table structure for table `settings_mail` */

CREATE TABLE `settings_mail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `EmailText` longtext,
  `EndOrderMessage` longtext,
  `MailServer` longtext,
  `PassRetrvlSubj` longtext,
  `EndOrderSubj` varchar(150) DEFAULT NULL,
  `UseMailLogin` varchar(255) DEFAULT NULL,
  `MailUser` varchar(255) DEFAULT NULL,
  `MailPassword` varchar(255) DEFAULT NULL,
  `usemailserver` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `settings_mail` */

insert  into `settings_mail`(`id`,`EmailText`,`EndOrderMessage`,`MailServer`,`PassRetrvlSubj`,`EndOrderSubj`,`UseMailLogin`,`MailUser`,`MailPassword`,`usemailserver`) values (1,'<p>\r\n	Thank you for your order. We hope you enjoy our product.</p>\r\n','<p>\r\n	Thank you for your order. We hope you enjoy our product.</p>\r\n','','Your Password','Thank you for your order!','No','','','No');

/*Table structure for table `settings_main` */

CREATE TABLE `settings_main` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ShippingType` varchar(150) DEFAULT '0',
  `InStateShipRate` varchar(150) DEFAULT NULL,
  `OutStateShipRate` varchar(150) DEFAULT NULL,
  `Location` varchar(150) DEFAULT NULL,
  `WebSiteTitle` longtext,
  `MetaKeywords` longtext,
  `MetaDescription` longtext,
  `MaxRecords` varchar(150) DEFAULT '24',
  `ThumbSize` varchar(150) DEFAULT '120',
  `ImageSize` varchar(150) DEFAULT '400',
  `CatImageSize` varchar(150) DEFAULT '75',
  `TinySize` varchar(150) DEFAULT '75',
  `DefaultStockValue` varchar(150) DEFAULT '999',
  `ShowPoweredBy` varchar(150) DEFAULT 'Yes',
  `EnableEuro` varchar(150) DEFAULT 'No',
  `ProductLayout` varchar(150) DEFAULT '1',
  `FeaturedLayout` varchar(150) DEFAULT '1',
  `SupportEmail` varchar(150) DEFAULT NULL,
  `OrderTracking` varchar(150) DEFAULT 'Yes',
  `EnableAutoThumb` varchar(150) DEFAULT 'Yes',
  `CartThumbNails` varchar(150) DEFAULT 'Yes',
  `EnablePromoCodes` varchar(150) DEFAULT 'Yes',
  `UnitOfMeasure` varchar(150) DEFAULT 'LBS',
  `ShowProductID` varchar(150) DEFAULT 'Yes',
  `ShowItemAvailability` varchar(150) DEFAULT 'Yes',
  `EnableInventory` varchar(150) DEFAULT 'Yes',
  `defaultcountry` varchar(150) DEFAULT 'US',
  `ShowOutOfStockItems` varchar(150) DEFAULT 'Yes',
  `useaffiliatesys` varchar(30) DEFAULT 'Yes',
  `UseMyAccount` varchar(150) DEFAULT 'Yes',
  `ShowTaxes` varchar(30) DEFAULT 'Yes',
  `ImageProcessor` varchar(255) DEFAULT 'cfimage8',
  `CategoryDisplay` varchar(150) DEFAULT 'HTML',
  `LinksDisplay` varchar(150) DEFAULT 'HTML',
  `sidebysidecols` varchar(150) DEFAULT '4',
  `showproductreviews` varchar(50) DEFAULT 'Yes',
  `enablecreateaccount` varchar(50) DEFAULT 'No',
  `enablecoupons` varchar(50) DEFAULT 'Yes',
  `ShowSearchOnNavBar` varchar(50) DEFAULT 'Yes',
  `customaffiliatecodestartup` longtext,
  `customaffiliatecodecheckout` longtext,
  `defaultaction` varchar(255) DEFAULT NULL,
  `DisableShoppingCart` varchar(50) DEFAULT 'No',
  `ShowGiftCardAtCheckout` varchar(50) DEFAULT 'Yes',
  `CheckForUpdates` varchar(50) DEFAULT 'Yes',
  `PasswordSite` varchar(50) DEFAULT 'No',
  `SitePassword` varchar(50) DEFAULT 'No',
  `errorhandleon` varchar(50) DEFAULT 'Yes',
  `navmenutype` varchar(255) DEFAULT 'Default',
  `enablewishlists` varchar(50) DEFAULT 'Yes',
  `ShowLeftWidgetsOnLoad` varchar(50) DEFAULT 'Yes',
  `ShowRightWidgetsOnLoad` varchar(50) DEFAULT 'Yes',
  `commrate` float DEFAULT NULL,
  `commrate_2` float DEFAULT NULL,
  `commrate_3` float DEFAULT NULL,
  `commtype` varchar(255) DEFAULT NULL,
  `ordernumber_prefix` varchar(50) DEFAULT NULL,
  `ckeditor_mode` varchar(50) DEFAULT 'basic',
  `checkout_terms` varchar(50) DEFAULT 'No',
  `use_urlrewrite` varchar(50) DEFAULT 'No',
  `checkoutstyle` varchar(50) DEFAULT '1',
  `stats_enabled` int(5) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `settings_main` */

insert  into `settings_main`(`id`,`ShippingType`,`InStateShipRate`,`OutStateShipRate`,`Location`,`WebSiteTitle`,`MetaKeywords`,`MetaDescription`,`MaxRecords`,`ThumbSize`,`ImageSize`,`CatImageSize`,`TinySize`,`DefaultStockValue`,`ShowPoweredBy`,`EnableEuro`,`ProductLayout`,`FeaturedLayout`,`SupportEmail`,`OrderTracking`,`EnableAutoThumb`,`CartThumbNails`,`EnablePromoCodes`,`UnitOfMeasure`,`ShowProductID`,`ShowItemAvailability`,`EnableInventory`,`defaultcountry`,`ShowOutOfStockItems`,`useaffiliatesys`,`UseMyAccount`,`ShowTaxes`,`ImageProcessor`,`CategoryDisplay`,`LinksDisplay`,`sidebysidecols`,`showproductreviews`,`enablecreateaccount`,`enablecoupons`,`ShowSearchOnNavBar`,`customaffiliatecodestartup`,`customaffiliatecodecheckout`,`defaultaction`,`DisableShoppingCart`,`ShowGiftCardAtCheckout`,`CheckForUpdates`,`PasswordSite`,`SitePassword`,`errorhandleon`,`navmenutype`,`enablewishlists`,`ShowLeftWidgetsOnLoad`,`ShowRightWidgetsOnLoad`,`commrate`,`commrate_2`,`commrate_3`,`commtype`,`ordernumber_prefix`,`ckeditor_mode`,`checkout_terms`,`use_urlrewrite`,`checkoutstyle`,`stats_enabled`) values (1,'5','1.90','2.30','English (US)','CF Shopkart Demo Store','free, coldfusion, adobe, shopping cart, open source','Coldfusion shopping cart solution free and open source.','25','100','250','75','75','999','yes','No','2','1','support@cfshopkart.com','Yes','Yes','Yes','Yes','LBS','Yes','Yes','Yes','US','Yes','Yes','Yes','Yes','cf8image','HTML','HTML','4','Yes','Yes','Yes','Yes','','','loadhomepage','No','Yes','No','No','','Yes','Default','No','Yes','Yes',17.5,5,2.5,'percent','','basic','Yes','No','1',1);

/*Table structure for table `settings_processor` */

CREATE TABLE `settings_processor` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `MASTERCARD` varchar(150) DEFAULT NULL,
  `VISA` varchar(150) DEFAULT NULL,
  `AMEX` varchar(150) DEFAULT NULL,
  `DISCOVER` varchar(150) DEFAULT NULL,
  `JCB` varchar(150) DEFAULT NULL,
  `ACH` varchar(150) DEFAULT NULL,
  `AcceptPayPal` varchar(150) DEFAULT NULL,
  `AcceptChecks` varchar(150) DEFAULT NULL,
  `AcceptCredit` varchar(150) DEFAULT NULL,
  `PayPalEmail` varchar(150) DEFAULT NULL,
  `EnablePayPalCheckout` varchar(150) DEFAULT NULL,
  `ANLogin` varchar(150) DEFAULT NULL,
  `TestAN` varchar(150) DEFAULT NULL,
  `HaltOnTest` varchar(150) DEFAULT NULL,
  `ANPass` varchar(150) DEFAULT NULL,
  `ANHash` varchar(150) DEFAULT NULL,
  `ANTrans` varchar(150) DEFAULT NULL,
  `EnablePayPalIPN` varchar(150) DEFAULT NULL,
  `PaymentGateway` varchar(150) DEFAULT NULL,
  `StoreCreditCardInfo` varchar(150) DEFAULT NULL,
  `AcceptEChecks` varchar(150) DEFAULT NULL,
  `antranstype` varchar(150) DEFAULT NULL,
  `accept_po` varchar(50) DEFAULT 'No',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `settings_processor` */

insert  into `settings_processor`(`id`,`MASTERCARD`,`VISA`,`AMEX`,`DISCOVER`,`JCB`,`ACH`,`AcceptPayPal`,`AcceptChecks`,`AcceptCredit`,`PayPalEmail`,`EnablePayPalCheckout`,`ANLogin`,`TestAN`,`HaltOnTest`,`ANPass`,`ANHash`,`ANTrans`,`EnablePayPalIPN`,`PaymentGateway`,`StoreCreditCardInfo`,`AcceptEChecks`,`antranstype`,`accept_po`) values (1,'Yes','Yes','Yes','Yes','No','No','No','No','Yes','bob@megalinx.com','No',NULL,'False','No',NULL,NULL,NULL,'No','None','No','False','sales','No');

/*Table structure for table `shippingfreezones` */

CREATE TABLE `shippingfreezones` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `zipcode` varchar(50) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`zipcode`,`region`,`Country`,`city`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `shippingfreezones` */

/*Table structure for table `shippingsurcharges` */

CREATE TABLE `shippingsurcharges` (
  `ChargeID` int(10) NOT NULL AUTO_INCREMENT,
  `Region` varchar(50) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `SurCharge` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ChargeID`),
  KEY `NewIndex1` (`Region`,`Country`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `shippingsurcharges` */

insert  into `shippingsurcharges`(`ChargeID`,`Region`,`Country`,`SurCharge`) values (1,'None','CA','2.95');

/*Table structure for table `shippingtable1` */

CREATE TABLE `shippingtable1` (
  `ShippingID` int(10) NOT NULL AUTO_INCREMENT,
  `MinPrice` double(53,0) DEFAULT NULL,
  `MaxPrice` double(53,0) DEFAULT NULL,
  `Amount` varchar(50) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `ShippingType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ShippingID`),
  KEY `NewIndex1` (`MinPrice`,`MaxPrice`,`Country`,`State`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `shippingtable1` */

/*Table structure for table `shippingtable2` */

CREATE TABLE `shippingtable2` (
  `ShippingID` int(10) NOT NULL AUTO_INCREMENT,
  `MinPrice` double(53,0) DEFAULT NULL,
  `MaxPrice` double(53,0) DEFAULT NULL,
  `Amount` varchar(50) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `Shippingtype` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ShippingID`),
  KEY `NewIndex1` (`MinPrice`,`MaxPrice`,`Country`,`State`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `shippingtable2` */

/*Table structure for table `shippingtable3` */

CREATE TABLE `shippingtable3` (
  `ShippingID` int(10) NOT NULL AUTO_INCREMENT,
  `ShippingType` varchar(50) DEFAULT NULL,
  `MinWeight` double(53,0) DEFAULT NULL,
  `MaxWeight` double(53,0) DEFAULT NULL,
  `Amount` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ShippingID`),
  KEY `NewIndex1` (`MinWeight`,`MaxWeight`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `shippingtable3` */

insert  into `shippingtable3`(`ShippingID`,`ShippingType`,`MinWeight`,`MaxWeight`,`Amount`) values (1,'Ground',15,50,'4.95');

/*Table structure for table `shippingtable4` */

CREATE TABLE `shippingtable4` (
  `ShippingID` int(10) NOT NULL AUTO_INCREMENT,
  `MinQty` double(53,0) DEFAULT NULL,
  `MaxQty` double(53,0) DEFAULT NULL,
  `Amount` varchar(50) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `ShippingType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ShippingID`),
  KEY `NewIndex1` (`MinQty`,`MaxQty`,`Country`,`State`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `shippingtable4` */

insert  into `shippingtable4`(`ShippingID`,`MinQty`,`MaxQty`,`Amount`,`Country`,`State`,`ShippingType`) values (1,1,1,'1.10',NULL,NULL,'Ground'),(2,2,3,'1.75',NULL,NULL,'Ground'),(3,4,6,'2.50',NULL,NULL,'Ground'),(4,7,50,'3.50',NULL,NULL,'Ground');

/*Table structure for table `shippingtable5` */

CREATE TABLE `shippingtable5` (
  `ShippingID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MinPrice` double(53,0) DEFAULT NULL,
  `MaxPrice` double(53,0) DEFAULT NULL,
  `Amount` varchar(50) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `ShippingType` varchar(50) DEFAULT NULL,
  `AmountType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ShippingID`),
  KEY `NewIndex1` (`MinPrice`,`MaxPrice`,`Country`,`State`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `shippingtable5` */

/*Table structure for table `shippingtypes` */

CREATE TABLE `shippingtypes` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `ShippingType` varchar(50) DEFAULT NULL,
  `AvailableTo` longtext,
  `SplitParcelsAt` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `shippingtypes` */

insert  into `shippingtypes`(`ID`,`ShippingType`,`AvailableTo`,`SplitParcelsAt`) values (3,'Ground','All',NULL);

/*Table structure for table `shoppingcarts` */

CREATE TABLE `shoppingcarts` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `CrtProductID` longtext,
  `CrtQuantity` longtext,
  `CrtProductName` longtext,
  `CrtPrice` longtext,
  `CrtWeight` longtext,
  `CrtThumbnails` longtext,
  `CrtOptions` longtext,
  `CrtType` longtext,
  `CrtApproved` longtext,
  `CrtCoupons` longtext,
  `CartToken` varchar(255) DEFAULT NULL,
  `CrtItemID` longtext,
  `CrtOptionFields` longtext,
  `DateEntered` varchar(50) DEFAULT NULL,
  `CheckedOut` varchar(50) DEFAULT NULL,
  `affilID` varchar(255) DEFAULT NULL,
  `MemberID` varchar(255) DEFAULT NULL,
  `firsttime` varchar(50) DEFAULT NULL,
  `memid` varchar(50) DEFAULT NULL,
  `OrderNumber` varchar(255) DEFAULT NULL,
  `wishlist` longtext,
  PRIMARY KEY (`ID`),
  KEY `NewIndex1` (`CartToken`,`CheckedOut`,`OrderNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `shoppingcarts` */

insert  into `shoppingcarts`(`ID`,`CrtProductID`,`CrtQuantity`,`CrtProductName`,`CrtPrice`,`CrtWeight`,`CrtThumbnails`,`CrtOptions`,`CrtType`,`CrtApproved`,`CrtCoupons`,`CartToken`,`CrtItemID`,`CrtOptionFields`,`DateEntered`,`CheckedOut`,`affilID`,`MemberID`,`firsttime`,`memid`,`OrderNumber`,`wishlist`) values (1,'demo3','1','Motherboard demo item (demo3-demo4-13706) <br><br>Add CPU</b>: Unchecked (demo4-13706)','1','1','Motherboard.jpg','0','normal','No','','XPQ23SW050212070532','13704','13704|84-Unchecked','2012-05-02','No','0',NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `states` */

CREATE TABLE `states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `statecode` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `showthis` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`statecode`,`showthis`,`country`)
) ENGINE=MyISAM AUTO_INCREMENT=78 DEFAULT CHARSET=latin1;

/*Data for the table `states` */

insert  into `states`(`id`,`statecode`,`state`,`showthis`,`country`) values (1,'AL','Alabama','Yes','181'),(2,'AK','Alaska','Yes','181'),(3,'AZ','Arizona','Yes','181'),(4,'AR','Arkansas','Yes','181'),(5,'CA','California','Yes','181'),(6,'CO','Colorado','Yes','181'),(7,'CT','Connecticut','Yes','181'),(8,'DE','Delaware','Yes','181'),(9,'DC','District of Columbia','Yes','181'),(10,'FL','Florida','Yes','181'),(11,'GA','Georgia','Yes','181'),(12,'HI','Hawaii','Yes','181'),(13,'ID','Idaho','Yes','181'),(14,'IL','Illinois','Yes','181'),(15,'IN','Indiana','Yes','181'),(16,'IA','Iowa','Yes','181'),(17,'KS','Kansas','Yes','181'),(18,'KY','Kentucky','Yes','181'),(19,'LA','Louisiana','Yes','181'),(20,'ME','Maine','Yes','181'),(21,'MD','Maryland','Yes','181'),(22,'MA','Massachusetts','Yes','181'),(23,'MI','Michigan','Yes','181'),(24,'MN','Minnesota','Yes','181'),(25,'MS','Mississippi','Yes','181'),(26,'MO','Missouri','Yes','181'),(27,'MT','Montana','Yes','181'),(28,'NE','Nebraska','Yes','181'),(29,'NV','Nevada','Yes','181'),(30,'NH','New Hampshire','Yes','181'),(31,'NJ','New Jersey','Yes','181'),(32,'NM','New Mexico','Yes','181'),(33,'NY','New York','Yes','181'),(34,'NC','North Carolina','Yes','181'),(35,'ND','North Dakota','Yes','181'),(36,'OH','Ohio','Yes','181'),(37,'OK','Oklahoma','Yes','181'),(38,'OR','Oregon','Yes','181'),(39,'PA','Pennsylvania','Yes','181'),(40,'RI','Rhode Island','Yes','181'),(41,'SC','South Carolina','Yes','181'),(42,'SD','South Dakota','Yes','181'),(43,'TN','Tennessee','Yes','181'),(44,'TX','Texas','Yes','181'),(45,'UT','Utah','Yes','181'),(46,'VT','Vermont','Yes','181'),(47,'VA','Virginia','Yes','181'),(48,'WA','Washington','Yes','181'),(49,'WV','West Virginia','Yes','181'),(50,'WI','Wisconsin','Yes','181'),(51,'WY','Wyoming','Yes','181'),(52,'GU','Guam','Yes','181'),(53,'PR','Puerto Rico','Yes','181'),(54,'AA','Armed Forces Americas (AA)','Yes','181'),(55,'AE','Armed Forces Outside Americas (AE)','Yes','181'),(56,'AP','Armed Forces Pacific (AP)','Yes','181'),(57,'AB','Alberta','Yes','35'),(58,'BC',' British Columbia','Yes','35'),(59,'MB',' Manitoba','Yes','35'),(60,'NB','New Brunswick','Yes','35'),(61,'NL','Newfoundland and Labrador','Yes','35'),(62,'NS','Nova Scotia','Yes','35'),(63,'NT','Northwest Territories','Yes','35'),(64,'NU','Nunavut','Yes','35'),(65,'ON','Ontario','Yes','35'),(66,'PE','Prince Edward Island','Yes','35'),(67,'QC','Quebec','Yes','35'),(68,'SK','Saskatchewan','Yes','35'),(69,'YT','Yukon','Yes','35'),(71,'NT','Northern Territory','Yes','11'),(72,'WA','Western Australia','Yes','11'),(73,'SA','South Australia','Yes','11'),(74,'QLD','Queensland','Yes','11'),(75,'NSW','New South Whales','Yes','11'),(76,'VIC','Victoria','Yes','11'),(77,'TAS','Tasmania','Yes','11');

/*Table structure for table `stats_clicks` */

CREATE TABLE `stats_clicks` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `carts` int(10) DEFAULT NULL,
  `stats_date` date DEFAULT NULL,
  `stats_month` int(5) DEFAULT NULL,
  `stats_year` int(5) DEFAULT NULL,
  `stats_day` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `stats_clicks` */

insert  into `stats_clicks`(`id`,`carts`,`stats_date`,`stats_month`,`stats_year`,`stats_day`) values (1,1,'2012-05-02',5,2012,2);

/*Table structure for table `stats_hits` */

CREATE TABLE `stats_hits` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `unique_hits` int(10) DEFAULT NULL,
  `page_views` int(10) DEFAULT NULL,
  `stats_date` date DEFAULT NULL,
  `stats_month` int(5) DEFAULT NULL,
  `stats_year` int(5) DEFAULT NULL,
  `stats_day` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

/*Data for the table `stats_hits` */

insert  into `stats_hits`(`id`,`unique_hits`,`page_views`,`stats_date`,`stats_month`,`stats_year`,`stats_day`) values (19,1,21,'2010-08-14',8,2010,14),(20,1,200,'2012-05-02',5,2012,2);

/*Table structure for table `stats_log` */

CREATE TABLE `stats_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `vis_ip` varchar(255) DEFAULT NULL,
  `vis_referrer` varchar(255) DEFAULT NULL,
  `vis_startpage` varchar(255) DEFAULT NULL,
  `vis_date` datetime DEFAULT NULL,
  `vis_querystring` varchar(255) DEFAULT NULL,
  `vis_month` int(5) DEFAULT NULL,
  `vis_year` int(5) DEFAULT NULL,
  `vis_clicked` int(5) DEFAULT '0',
  `vis_day` int(5) DEFAULT NULL,
  `carttoken` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`vis_ip`,`vis_date`,`vis_month`,`vis_year`,`vis_clicked`,`vis_day`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;

/*Data for the table `stats_log` */

insert  into `stats_log`(`id`,`vis_ip`,`vis_referrer`,`vis_startpage`,`vis_date`,`vis_querystring`,`vis_month`,`vis_year`,`vis_clicked`,`vis_day`,`carttoken`) values (92,'0:0:0:0:0:0:0:1','http://localhost:8500/','','2010-08-14 16:28:34','action=site_login',8,2010,0,14,NULL),(93,'98.28.95.219','Direct','/index.cfm','2012-05-02 18:18:02','page=.cfm',5,2012,1,2,'XPQ23SW050212070532');

/*Table structure for table `stats_referrers` */

CREATE TABLE `stats_referrers` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `referrer` varchar(255) DEFAULT NULL,
  `hit_count` int(10) DEFAULT NULL,
  `stats_date` date DEFAULT NULL,
  `stats_month` int(5) DEFAULT NULL,
  `stats_year` int(5) DEFAULT NULL,
  `stats_day` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

/*Data for the table `stats_referrers` */

insert  into `stats_referrers`(`id`,`referrer`,`hit_count`,`stats_date`,`stats_month`,`stats_year`,`stats_day`) values (36,'http://localhost:8500/',1,'2010-08-14',8,2010,14),(37,'Direct',1,'2012-05-02',5,2012,2);

/*Table structure for table `stats_useragents` */

CREATE TABLE `stats_useragents` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_agent` varchar(255) DEFAULT NULL,
  `hit_count` int(10) DEFAULT NULL,
  `stats_date` date DEFAULT NULL,
  `stats_month` int(5) DEFAULT NULL,
  `stats_year` int(5) DEFAULT NULL,
  `stats_day` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=latin1;

/*Data for the table `stats_useragents` */

insert  into `stats_useragents`(`id`,`user_agent`,`hit_count`,`stats_date`,`stats_month`,`stats_year`,`stats_day`) values (78,'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.126 Safari/533.4',1,'2010-08-14',8,2010,14),(79,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0',1,'2012-05-02',5,2012,2);

/*Table structure for table `support_replies` */

CREATE TABLE `support_replies` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ticketid` varchar(255) DEFAULT NULL,
  `reply` longtext,
  `replyby` varchar(255) DEFAULT NULL,
  `replyto` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`ticketid`,`replyby`,`replyto`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `support_replies` */

/*Table structure for table `support_tickets` */

CREATE TABLE `support_tickets` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ticketid` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `message` longtext,
  `status` varchar(50) DEFAULT NULL,
  `datesubmitted` datetime DEFAULT NULL,
  `customerid` varchar(50) DEFAULT NULL,
  `resolution` longtext,
  `supportrep` varchar(50) DEFAULT NULL,
  `notes` longtext,
  `nextaction` varchar(255) DEFAULT NULL,
  `emailaddress` varchar(255) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Website` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`ticketid`,`status`,`customerid`,`supportrep`,`emailaddress`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `support_tickets` */

/*Table structure for table `support_types` */

CREATE TABLE `support_types` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `support_types` */

insert  into `support_types`(`id`,`TypeName`) values (1,'Question About Order'),(2,'Missing An Item'),(3,'Problem With Item'),(4,'Website Question'),(5,'Other');

/*Table structure for table `taxes` */

CREATE TABLE `taxes` (
  `TaxID` int(10) NOT NULL AUTO_INCREMENT,
  `Region` varchar(50) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `ZipCode` varchar(50) DEFAULT NULL,
  `TaxRate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`TaxID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `taxes` */

/*Table structure for table `temp_import` */

CREATE TABLE `temp_import` (
  `CAT_IMPRT_ID` int(11) DEFAULT NULL,
  `v_products_model` longtext,
  `v_products_image` longtext,
  `v_products_name_1` longtext,
  `v_products_description_1` longtext,
  `v_products_url_1` longtext,
  `v_specials_price` longtext,
  `v_specials_last_modified` longtext,
  `v_specials_expires_date` longtext,
  `v_products_price` longtext,
  `v_products_weight` longtext,
  `v_last_modified` longtext,
  `v_date_added` longtext,
  `v_products_quantity` longtext,
  `v_manufacturers_name` longtext,
  `v_categories_name_1` longtext,
  `v_categories_name_2` longtext,
  `v_categories_name_3` longtext,
  `v_categories_name_4` longtext,
  `v_categories_name_5` longtext,
  `v_categories_name_6` longtext,
  `v_categories_name_7` longtext,
  `v_tax_class_title` longtext,
  `v_status` longtext,
  `v_metatags_products_name_status` longtext,
  `v_metatags_title_status` longtext,
  `v_metatags_model_status` longtext,
  `v_metatags_price_status` longtext,
  `v_metatags_title_tagline_status` longtext,
  `v_metatags_title_1` longtext,
  `v_metatags_keywords_1` longtext,
  `v_metatags_description_1` longtext
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `temp_import` */

/*Table structure for table `termspage` */

CREATE TABLE `termspage` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TermsPage` longtext NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `termspage` */

insert  into `termspage`(`ID`,`TermsPage`) values (1,'<h2>Affiliate Terms</h2>');

/*Table structure for table `testimonials` */

CREATE TABLE `testimonials` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `quote` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `testimonials` */

/*Table structure for table `tips` */

CREATE TABLE `tips` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `tipcontent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `tips` */

insert  into `tips`(`id`,`tipcontent`) values (3,'Click on the Help Icons to get assistance with features');

/*Table structure for table `upsconfig` */

CREATE TABLE `upsconfig` (
  `SettingID` int(10) NOT NULL AUTO_INCREMENT,
  `ServiceCodes` longtext,
  `ServiceNames` longtext,
  `AccountNumber` varchar(50) DEFAULT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `Accesskey` varchar(50) DEFAULT NULL,
  `MultipleShippingPoints` varchar(50) DEFAULT NULL,
  `ShipFromStates` longtext,
  `ShipFromCities` longtext,
  `ShipFromCountries` longtext,
  `ShipFromZips` longtext,
  `ShipFromOtherLocation` varchar(50) DEFAULT NULL,
  `user` varchar(50) DEFAULT NULL,
  `fallbackmethod` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`SettingID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `upsconfig` */

insert  into `upsconfig`(`SettingID`,`ServiceCodes`,`ServiceNames`,`AccountNumber`,`Username`,`Password`,`Accesskey`,`MultipleShippingPoints`,`ShipFromStates`,`ShipFromCities`,`ShipFromCountries`,`ShipFromZips`,`ShipFromOtherLocation`,`user`,`fallbackmethod`) values (1,'03,11','03,11',NULL,'','','','No','OH','Toledo','US','43512','No',NULL,'1');

/*Table structure for table `user_sessions` */

CREATE TABLE `user_sessions` (
  `sessionnumber` int(11) NOT NULL AUTO_INCREMENT,
  `sessionid` varchar(50) DEFAULT NULL,
  `UserName` varchar(50) DEFAULT NULL,
  `LastRequest` longtext,
  `DateTimeOfLogin` datetime DEFAULT NULL,
  `SessionTime` datetime DEFAULT NULL,
  `ipaddress` varchar(50) DEFAULT NULL,
  `sortoption` varchar(50) DEFAULT NULL,
  `categoryview` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`sessionnumber`),
  UNIQUE KEY `UserID` (`sessionid`),
  KEY `sessionnumber` (`sessionnumber`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `user_sessions` */

/*Table structure for table `users` */

CREATE TABLE `users` (
  `UserID` int(10) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(50) DEFAULT NULL,
  `pword` varchar(50) DEFAULT NULL,
  `UserLevel` varchar(50) DEFAULT NULL,
  `IsLoggedIn` varchar(50) DEFAULT NULL,
  `lastsessionid` varchar(255) DEFAULT NULL,
  `actions_whitelist` longtext,
  `actions_blacklist` longtext,
  `failedlogins` int(10) DEFAULT '0',
  `lockoutdatetime` datetime DEFAULT NULL,
  `lockoutmins` int(10) DEFAULT '15',
  PRIMARY KEY (`UserID`),
  KEY `NewIndex1` (`UserName`,`pword`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

/*Table structure for table `versioninfo` */

CREATE TABLE `versioninfo` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `version` varchar(10) DEFAULT '5.5',
  `LastUpdate` varchar(150) DEFAULT NULL,
  `build` varchar(10) DEFAULT '001',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`version`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `versioninfo` */

insert  into `versioninfo`(`id`,`version`,`LastUpdate`,`build`) values (1,'5.5','7/10/2010','006');

/*Table structure for table `widgets` */

CREATE TABLE `widgets` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `widgetname` varchar(255) DEFAULT NULL,
  `widgettitle` varchar(255) DEFAULT NULL,
  `widgetdesc` longtext,
  `widgetfile` varchar(255) DEFAULT NULL,
  `ordervalue` int(10) DEFAULT NULL,
  `isvisible` varchar(50) DEFAULT NULL,
  `widgetposition` varchar(50) DEFAULT NULL,
  `widgetcode` longtext,
  `showtitle` varchar(50) DEFAULT NULL,
  `candelete` varchar(50) DEFAULT NULL,
  `enabled` varchar(50) DEFAULT NULL,
  `custom_styles` longtext,
  `title_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`ordervalue`,`widgetposition`,`candelete`,`enabled`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

/*Data for the table `widgets` */

insert  into `widgets`(`id`,`widgetname`,`widgettitle`,`widgetdesc`,`widgetfile`,`ordervalue`,`isvisible`,`widgetposition`,`widgetcode`,`showtitle`,`candelete`,`enabled`,`custom_styles`,`title_image`) values (1,'Catalog Categories','Catalog','Displays the categories available in your catalog','categories.cfm',2,'Yes','Left','','Yes','No','Yes','',NULL),(2,'Links Section','More Info','Internal and external links that you want to display in your catalog','links.cfm',3,'Yes','Left','','Yes','No','Yes','',''),(3,'Best Seller','Best Sellers','Shows a random best selling product.  If you have not made a sale yet, you might want to hide this.','bestsellers.cfm',1,'No','Left','','Yes','No','Yes',NULL,NULL),(4,'Featured Item','Featured','Shows a random featured item.  You can set featured items in the catalog section of the control panel.  If you do not have any set, it would be a good idea to hide this.','featured.cfm',4,'Yes','Left',NULL,'Yes','No','Yes',NULL,NULL),(5,'Wish List','Wish List','Shows a summary of what is on their wishlist','WishListContents.cfm',5,'Yes','Right',NULL,'Yes','No','No',NULL,NULL),(6,'Cart Contents','Cart Contents','Shows a summary of what is in their cart','cartcontents.cfm',1,'Yes','Left',NULL,'Yes','No','Yes',NULL,NULL),(7,'GiftCards','Gift Certificate Balance','Gives the ability to your customers to check gift card balances.  Turn this off if you do not sell gift cards/certificates','giftcard.cfm',4,'No','Right','','Yes','No','Yes',NULL,NULL),(8,'OrderCheck','Check Your Order Status','Gives the ability to your customers to quickly check the status of an order if they have the order number','orderstatus.cfm',5,'No','Right',NULL,'Yes','No','Yes',NULL,NULL),(9,'Affiliates','Affiliate Login','Gives the ability to affiliates to loging and new ones to signup.','affiliates.cfm',3,'No','Right','','Yes','No','Yes','',''),(10,'Email List','News letter Signup','Gives the ability to your visitors to signup to your newsletter','NewsLetterSignup.cfm',2,'No','Left','','Yes','No','Yes','',''),(11,'Quick Jump','Quick Jump','Shows a drop down box of categories','FormCategories.cfm',1,'No','Left',NULL,'Yes','No','Yes',NULL,NULL),(12,'Coupon Code','Add Coupon Codes','Customer can enter a coupon code in this box and add it to their cart.  \r\nIf it\'s for a specific item it will auto add the item to the cart.		','couponcode.cfm',7,'No','Right',NULL,'Yes','No','Yes',NULL,NULL),(15,'Brand Browser','Browse By Brand','Shows the Browse By Brand Box	','brandbrowser.cfm',8,'No','Right','','Yes','No','Yes','','');

/*Table structure for table `wishlistitems` */

CREATE TABLE `wishlistitems` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `WishlistID` varchar(50) DEFAULT NULL,
  `wItemID` varchar(50) DEFAULT NULL,
  `Comments` longtext,
  PRIMARY KEY (`ID`),
  KEY `NewIndex1` (`WishlistID`,`wItemID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `wishlistitems` */

/*Table structure for table `wishlists` */

CREATE TABLE `wishlists` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `WishListID` varchar(50) DEFAULT NULL,
  `WishListName` varchar(50) DEFAULT NULL,
  `CreatedOn` date NOT NULL,
  `wUsername` varchar(50) DEFAULT NULL,
  `wPassword` varchar(50) DEFAULT NULL,
  `Comments` longtext,
  `WishlistOwner` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `NewIndex1` (`WishListID`,`wUsername`,`wPassword`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `wishlists` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
