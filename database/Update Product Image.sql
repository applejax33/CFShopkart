/*
Update Product images to allow for longer file names
	Add the ability to store image alt information
*********************************************************************
*/

ALTER TABLE `cfshopkart`.`products_images` 
MODIFY COLUMN `iFileName` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL AFTER `id`,
ADD COLUMN `alttext` varchar(200) NULL AFTER `mediumwidth`;