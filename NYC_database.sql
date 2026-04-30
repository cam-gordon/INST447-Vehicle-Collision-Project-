-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema NYC_collisions
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema NYC_collisions
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `NYC_collisions` DEFAULT CHARACTER SET utf8 ;
USE `NYC_collisions` ;

-- -----------------------------------------------------
-- Table `NYC_collisions`.`locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NYC_collisions`.`locations` (
  `location_id` INT NOT NULL,
  `zipcode` VARCHAR(5) NULL,
  `latitude` DECIMAL(3) NULL,
  `longitude` DECIMAL(3) NULL,
  `street_name` VARCHAR(45) NOT NULL,
  `cross_street_name` VARCHAR(45) NULL,
  `borough` VARCHAR(45) NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NYC_collisions`.`Collisions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NYC_collisions`.`Collisions` (
  `collision_id` INT NOT NULL,
  `datetime` DATETIME NULL,
  `year` INT NULL,
  `month` INT NULL,
  `day_of_week` VARCHAR(45) NULL,
  `hour` INT NULL,
  `location_id` INT NOT NULL,
  PRIMARY KEY (`collision_id`),
  INDEX `fk_Collisions_locations1_idx` (`location_id` ASC) VISIBLE,
  CONSTRAINT `fk_Collisions_locations1`
    FOREIGN KEY (`location_id`)
    REFERENCES `NYC_collisions`.`locations` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NYC_collisions`.`contribute_factors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NYC_collisions`.`contribute_factors` (
  `contribute_factor_id` INT NOT NULL,
  `contribute_factor_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`contribute_factor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NYC_collisions`.`vehicle_involved`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NYC_collisions`.`vehicle_involved` (
  `vehicle_type_id` INT NOT NULL,
  `vehicle_type` VARCHAR(45) NOT NULL,
  `collision_id` INT NOT NULL,
  PRIMARY KEY (`vehicle_type_id`),
  INDEX `fk_vehicle_involved_Collisions1_idx` (`collision_id` ASC) VISIBLE,
  CONSTRAINT `fk_vehicle_involved_Collisions1`
    FOREIGN KEY (`collision_id`)
    REFERENCES `NYC_collisions`.`Collisions` (`collision_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NYC_collisions`.`collision_factors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NYC_collisions`.`collision_factors` (
  `collision_id` INT NOT NULL,
  `factor_id` INT NOT NULL,
  PRIMARY KEY (`collision_id`, `factor_id`),
  INDEX `fk_collision_factors_contribute_factors1_idx` (`factor_id` ASC) VISIBLE,
  CONSTRAINT `fk_collision_factors_Collisions1`
    FOREIGN KEY (`collision_id`)
    REFERENCES `NYC_collisions`.`Collisions` (`collision_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_collision_factors_contribute_factors1`
    FOREIGN KEY (`factor_id`)
    REFERENCES `NYC_collisions`.`contribute_factors` (`contribute_factor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NYC_collisions`.`casualties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NYC_collisions`.`casualties` (
  `casualty_id` INT NOT NULL,
  `type` INT NOT NULL,
  `injured_count` INT NULL,
  `killed_count` INT NULL,
  `collision_id` INT NOT NULL,
  PRIMARY KEY (`casualty_id`),
  INDEX `fk_casualties_Collisions1_idx` (`collision_id` ASC) VISIBLE,
  CONSTRAINT `fk_casualties_Collisions1`
    FOREIGN KEY (`collision_id`)
    REFERENCES `NYC_collisions`.`Collisions` (`collision_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
