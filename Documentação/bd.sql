/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 4.1.22-community-nt : Database - futsystem
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`futsystem` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `futsystem`;

/*Table structure for table `atletas` */

DROP TABLE IF EXISTS `atletas`;

CREATE TABLE `atletas` (
  `Atl_Codigo` int(11) NOT NULL default '0',
  `Atl_NomeCompleto` varchar(60) NOT NULL default '',
  `Atl_DataNasc` date default NULL,
  `Atl_Sexo` char(1) default NULL,
  `Atl_Telefone` varchar(15) default NULL,
  `Atl_Celular` varchar(15) default NULL,
  `Atl_Endereco` varchar(60) default NULL,
  `Atl_Bairro` varchar(40) default NULL,
  `Atl_NumEndereco` int(11) default NULL,
  `Atl_CEP` varchar(8) default NULL,
  `Atl_Email` varchar(60) default NULL,
  `Atl_Senha` varchar(20) default NULL,
  `Atl_Posicao` varchar(20) default NULL,
  `Atl_Status` char(1) default NULL,
  `Atl_Caracteristica` char(2) default NULL,
  `Atl_Obs` text,
  PRIMARY KEY  (`Atl_Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `atletas` */

/*Table structure for table `campos` */

DROP TABLE IF EXISTS `campos`;

CREATE TABLE `campos` (
  `Cam_Codigo` int(11) NOT NULL default '0',
  `Cam_Nome` varchar(60) NOT NULL default '',
  `Cam_Endereco` varchar(60) default NULL,
  `Cam_NumEndereco` int(11) default NULL,
  `Cam_Bairro` varchar(60) default NULL,
  `Cam_CEP` varchar(8) default NULL,
  `Cam_Email` varchar(60) default NULL,
  `Cam_Senha` varchar(20) default NULL,
  `Cam_TipoCampo` char(1) default NULL,
  `Cam_Telefone` varchar(15) default NULL,
  `Cam_Celular` varchar(15) default NULL,
  `Cam_Obs` text,
  `Cam_Responsavel` varchar(30) default NULL,
  `Cam_Status` char(1) default NULL,
  PRIMARY KEY  (`Cam_Codigo`,`Cam_Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `campos` */

/*Table structure for table `partidas` */

DROP TABLE IF EXISTS `partidas`;

CREATE TABLE `partidas` (
  `Par_Codigo` int(11) NOT NULL default '0',
  `Par_Data` date NOT NULL default '0000-00-00',
  `Par_Horario` time NOT NULL default '00:00:00',
  `Cam_Codigo` int(11) NOT NULL default '0',
  `Par_Status` char(1) default NULL,
  PRIMARY KEY  (`Par_Codigo`),
  KEY `FK_Partidas_Campo` (`Cam_Codigo`),
  CONSTRAINT `FK_Partidas_Campo` FOREIGN KEY (`Cam_Codigo`) REFERENCES `campos` (`Cam_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `partidas` */

/*Table structure for table `partidas_times` */

DROP TABLE IF EXISTS `partidas_times`;

CREATE TABLE `partidas_times` (
  `Par_Codigo` int(11) NOT NULL default '0',
  `Tim_Codigo` int(11) NOT NULL default '0',
  PRIMARY KEY  (`Par_Codigo`,`Tim_Codigo`),
  KEY `FK_partidas_times` (`Tim_Codigo`),
  CONSTRAINT `FK_partidas_partidas` FOREIGN KEY (`Par_Codigo`) REFERENCES `partidas` (`Par_Codigo`),
  CONSTRAINT `FK_partidas_times` FOREIGN KEY (`Tim_Codigo`) REFERENCES `times` (`Tim_Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `partidas_times` */

/*Table structure for table `times` */

DROP TABLE IF EXISTS `times`;

CREATE TABLE `times` (
  `Tim_Codigo` int(11) NOT NULL default '0',
  `Tim_Nome` varchar(30) default NULL,
  `Atl_Codigo` int(11) NOT NULL default '0',
  `Tim_DataFundacao` date default NULL,
  PRIMARY KEY  (`Tim_Codigo`,`Atl_Codigo`),
  KEY `FK_Times_Resp` (`Atl_Codigo`),
  CONSTRAINT `FK_Times_Resp` FOREIGN KEY (`Atl_Codigo`) REFERENCES `atletas` (`Atl_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `times` */

/*Table structure for table `times_atletas` */

DROP TABLE IF EXISTS `times_atletas`;

CREATE TABLE `times_atletas` (
  `Tim_Codigo` int(11) NOT NULL default '0',
  `Atl_Codigo` int(11) NOT NULL default '0',
  PRIMARY KEY  (`Tim_Codigo`,`Atl_Codigo`),
  KEY `FK_Times_Atletas` (`Atl_Codigo`),
  CONSTRAINT `FK_Times_Times` FOREIGN KEY (`Tim_Codigo`) REFERENCES `times` (`Tim_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Times_Atletas` FOREIGN KEY (`Atl_Codigo`) REFERENCES `atletas` (`Atl_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `times_atletas` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
