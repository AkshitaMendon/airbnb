-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema airbnb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema airbnb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `airbnb` DEFAULT CHARACTER SET utf8 ;
USE `airbnb` ;

-- -----------------------------------------------------
-- Table `airbnb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`User` (
  `UserId` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `PhoneNo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`UserId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`Host`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`Host` (
  `HostId` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Location` VARCHAR(45) NOT NULL,
  `LanguagesSpoken` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`HostId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`Property_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`Property_Type` (
  `PropertyTypeId` INT NOT NULL,
  `TypeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PropertyTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`Property_Listing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`Property_Listing` (
  `ListingId` INT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(100) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  `HostId` INT NULL,
  `PropertyTypeId` INT NULL,
  `PricePerNight` DECIMAL(10,2) NOT NULL,
  `AvailabilityStatus` TINYINT NOT NULL,
  PRIMARY KEY (`ListingId`),
  INDEX `HostId_idx` (`HostId` ASC) VISIBLE,
  INDEX `PropertyTypeId_idx` (`PropertyTypeId` ASC) VISIBLE,
  CONSTRAINT `HostId`
    FOREIGN KEY (`HostId`)
    REFERENCES `airbnb`.`Host` (`HostId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PropertyTypeId`
    FOREIGN KEY (`PropertyTypeId`)
    REFERENCES `airbnb`.`Property_Type` (`PropertyTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`Booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`Booking` (
  `BookingId` INT NOT NULL,
  `UserId` INT NOT NULL,
  `ListingId` INT NULL,
  `CheckIn` DATETIME NOT NULL,
  `CheckOut` DATETIME NOT NULL,
  `TotalCost` DECIMAL(10,2) NOT NULL,
  `BookingStatus` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`BookingId`),
  INDEX `UserId_idx` (`UserId` ASC) VISIBLE,
  INDEX `ListingId_idx` (`ListingId` ASC) VISIBLE,
  CONSTRAINT `UserId`
    FOREIGN KEY (`UserId`)
    REFERENCES `airbnb`.`User` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ListingId`
    FOREIGN KEY (`ListingId`)
    REFERENCES `airbnb`.`Property_Listing` (`ListingId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`Payment` (
  `PaymentId` INT NOT NULL,
  `BookingId` INT NULL,
  `Amount` DECIMAL(10,2) NOT NULL,
  `PaymentDate` DATE NOT NULL,
  `PaymentStatus` VARCHAR(45) NOT NULL,
  `PaymentMethod` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PaymentId`),
  INDEX `BookingId_idx` (`BookingId` ASC) VISIBLE,
  CONSTRAINT `BookingId`
    FOREIGN KEY (`BookingId`)
    REFERENCES `airbnb`.`Booking` (`BookingId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`Review` (
  `ReviewId` INT NOT NULL,
  `UserId` INT NULL,
  `ListingId` INT NULL,
  `Rating` INT NOT NULL,
  `Comment` VARCHAR(45) NOT NULL,
  `ReviewDate` DATE NOT NULL,
  PRIMARY KEY (`ReviewId`),
  INDEX `UserId_idx` (`UserId` ASC) VISIBLE,
  INDEX `ListingId_idx` (`ListingId` ASC) VISIBLE,
  CONSTRAINT `UserId`
    FOREIGN KEY (`UserId`)
    REFERENCES `airbnb`.`User` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ListingId`
    FOREIGN KEY (`ListingId`)
    REFERENCES `airbnb`.`Property_Listing` (`ListingId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`Cancellation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`Cancellation` (
  `CancellationId` INT NOT NULL,
  `RefundAmount` DECIMAL(10,2) NOT NULL,
  `CancellationDate` DATE NOT NULL,
  `BookingId` INT NULL,
  PRIMARY KEY (`CancellationId`),
  INDEX `BookingId_idx` (`BookingId` ASC) VISIBLE,
  CONSTRAINT `BookingId`
    FOREIGN KEY (`BookingId`)
    REFERENCES `airbnb`.`Booking` (`BookingId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
