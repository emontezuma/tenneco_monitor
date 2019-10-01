-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 05-09-2019 a las 12:41:47
-- Versión del servidor: 5.6.13
-- Versión de PHP: 5.4.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `sigma`
--
CREATE DATABASE IF NOT EXISTS `sigma` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `sigma`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actualizaciones`
--

CREATE TABLE IF NOT EXISTS `actualizaciones` (
  `plantas` datetime DEFAULT NULL COMMENT 'Se actualizaron las plantas?',
  `lineas` datetime DEFAULT NULL COMMENT 'Se actualizaron las líneas?',
  `maquinas` datetime DEFAULT NULL COMMENT 'Se actualizaron las máquinas?',
  `procesos` datetime DEFAULT NULL COMMENT 'Se actualizaron las procesos?',
  `rutas` datetime DEFAULT NULL COMMENT 'Se actualizaron las rutas?',
  `det_rutas` datetime DEFAULT NULL COMMENT 'Se actualizaron las rutas detalle?',
  `det_procesos` datetime DEFAULT NULL COMMENT 'Se actualizaron los procesos detalle?',
  `partes` datetime DEFAULT NULL COMMENT 'Se actualizaron las partes?',
  `recipientes` datetime DEFAULT NULL COMMENT 'Se actualizaron las recipientes?',
  `alertas` datetime DEFAULT NULL COMMENT 'Se actualizaron las alertas?',
  `situaciones` datetime DEFAULT NULL COMMENT 'Se actualizaron las situaciones?',
  `horario` datetime DEFAULT NULL COMMENT 'Se actualizaron las horarios?',
  `planes` datetime DEFAULT NULL COMMENT 'Se actualizaron las planes?',
  `prioridades` datetime DEFAULT NULL COMMENT 'Se actualizaron las prioridades?'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Control de actualización';

--
-- Volcado de datos para la tabla `actualizaciones`
--

INSERT INTO `actualizaciones` (`plantas`, `lineas`, `maquinas`, `procesos`, `rutas`, `det_rutas`, `det_procesos`, `partes`, `recipientes`, `alertas`, `situaciones`, `horario`, `planes`, `prioridades`) VALUES
('0000-00-00 00:00:00', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alarmas`
--

CREATE TABLE IF NOT EXISTS `alarmas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `tipo` int(11) DEFAULT '0' COMMENT 'Tipo de alarma',
  `proceso` bigint(20) DEFAULT '0' COMMENT 'Proceso',
  `lote` bigint(20) DEFAULT '0' COMMENT 'ID del lote',
  `lote_historico` bigint(20) DEFAULT '0' COMMENT 'ID del lote histórico',
  `prioridad` varchar(1) DEFAULT NULL COMMENT 'Texto a enviar por MMCall',
  `inicio` datetime DEFAULT NULL COMMENT 'Acumular número de fallas',
  `fin` datetime DEFAULT NULL COMMENT 'Segundos a contar para acumular',
  `tiempo` bigint(8) DEFAULT '0' COMMENT 'Tiempo en segundos',
  `alerta` bigint(11) DEFAULT '0' COMMENT 'Alerta asociada',
  `reporte` bigint(20) DEFAULT '0' COMMENT 'Reporte',
  `accion` int(2) DEFAULT '0' COMMENT 'Acción efectuada: 0=Acumuló, 1=Notificó luego de acumular, 2=Notificó sin acumulación, 3=Ya estaba activa la alerta ',
  `fecha_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha directa de MySQL',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`tipo`,`inicio`),
  KEY `NewIndex2` (`inicio`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Detalle de alarmas' AUTO_INCREMENT=34442 ;

--
-- Volcado de datos para la tabla `alarmas`
--

INSERT INTO `alarmas` (`id`, `tipo`, `proceso`, `lote`, `lote_historico`, `prioridad`, `inicio`, `fin`, `tiempo`, `alerta`, `reporte`, `accion`, `fecha_ts`) VALUES
(34433, 1, 17, 141, 0, NULL, '2019-08-31 17:46:08', NULL, 0, 56, 6142, 1, '2019-08-31 22:46:08'),
(34434, 4, 20, 144, 0, NULL, '2019-09-02 12:20:14', NULL, 0, 59, 6143, 1, '2019-09-02 17:20:14'),
(34435, 4, 20, 145, 0, NULL, '2019-09-02 12:27:20', NULL, 0, 59, 6144, 1, '2019-09-02 17:27:20'),
(34436, 3, 20, 22, 0, NULL, '2019-09-02 14:59:45', NULL, 0, 57, 6145, 1, '2019-09-02 19:59:45'),
(34437, 2, 17, 147, 0, NULL, '2019-09-02 18:18:52', NULL, 0, 58, 6146, 1, '2019-09-02 23:18:52'),
(34438, 4, 13, 148, 0, NULL, '2019-09-03 09:54:30', NULL, 0, 59, 6147, 1, '2019-09-03 14:54:30'),
(34439, 4, 4, 148, 0, NULL, '2019-09-03 09:57:32', NULL, 0, 59, 6148, 1, '2019-09-03 14:57:32'),
(34440, 1, 17, 142, 0, NULL, '2019-09-03 10:04:54', NULL, 0, 56, 6149, 1, '2019-09-03 15:04:54'),
(34441, 1, 17, 143, 0, NULL, '2019-09-03 10:05:01', NULL, 0, 56, 6150, 1, '2019-09-03 15:05:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargas`
--

CREATE TABLE IF NOT EXISTS `cargas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `fecha` datetime DEFAULT NULL COMMENT 'Fecha y hora de programación',
  `fecha_original` datetime DEFAULT NULL COMMENT 'Fecha original',
  `equipo` bigint(20) DEFAULT '0' COMMENT 'ID del equipo',
  `notas` varchar(300) DEFAULT NULL COMMENT 'Notas varias',
  `alarma` char(1) DEFAULT 'S' COMMENT 'Generar alarma',
  `alarma_rep` char(1) DEFAULT 'N' COMMENT 'Alarma reportada?',
  `permitir_reprogramacion` char(1) DEFAULT 'S' COMMENT 'Permitir reprogramación?',
  `completada` char(1) DEFAULT 'N' COMMENT 'Carga completa',
  `carga` varchar(20) DEFAULT NULL COMMENT 'Número de carga',
  `reprogramaciones` int(4) DEFAULT '0' COMMENT 'Veces que se ha reprogramado',
  `estatus` char(1) DEFAULT 'A' COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Tabla de cargas' AUTO_INCREMENT=25 ;

--
-- Volcado de datos para la tabla `cargas`
--

INSERT INTO `cargas` (`id`, `fecha`, `fecha_original`, `equipo`, `notas`, `alarma`, `alarma_rep`, `permitir_reprogramacion`, `completada`, `carga`, `reprogramaciones`, `estatus`, `creacion`, `modificacion`, `creado`, `modificado`) VALUES
(23, '2019-09-05 15:00:00', '2019-09-05 15:00:00', 18, '', 'S', 'N', 'S', 'N', '003', 0, 'A', '2019-09-05 08:49:46', '2019-09-05 10:33:47', 1, 1),
(22, '2019-09-05 15:00:00', '2019-09-05 15:00:00', 19, '', 'S', 'S', 'S', 'N', '002', 0, 'A', '2019-09-02 12:25:43', '2019-09-05 08:50:08', 1, 1),
(24, '2019-09-05 16:00:00', '2019-09-05 16:00:00', 19, '', 'S', 'N', 'S', 'N', '004', 0, 'A', '2019-09-05 08:51:03', '2019-09-05 08:51:03', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_alertas`
--

CREATE TABLE IF NOT EXISTS `cat_alertas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `referencia` varchar(50) DEFAULT NULL COMMENT 'Referencia',
  `nombre` varchar(60) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `solapar` char(1) DEFAULT NULL COMMENT 'Solapar alertas',
  `tipo` int(1) DEFAULT '1' COMMENT 'Tipo: 0=Normal, 9=Escape',
  `notas` varchar(100) DEFAULT NULL COMMENT 'Notas varias',
  `proceso` bigint(20) DEFAULT NULL COMMENT 'Proceso asociado a la alerta',
  `acumular` char(1) DEFAULT NULL COMMENT 'Acumular fallas antes de enviar',
  `acumular_veces` bigint(6) DEFAULT '0' COMMENT 'Número de veces a acumular',
  `acumular_tiempo` bigint(8) DEFAULT '0' COMMENT 'Tiempo de acumulación',
  `acumular_inicializar` char(1) DEFAULT NULL COMMENT 'Inicializa el contador una vez alcanzada la frecuencia',
  `acumular_tipo_mensaje` char(1) DEFAULT NULL COMMENT 'Tipo de mensaje para repeticiones',
  `acumular_mensaje` varchar(200) DEFAULT NULL COMMENT 'Mensaje de acumulación',
  `log` char(1) DEFAULT NULL COMMENT 'Se generará LOG',
  `sms` char(1) DEFAULT NULL COMMENT 'Se enviará SMS',
  `correo` char(1) DEFAULT NULL COMMENT 'Se enviará correo',
  `llamada` char(1) DEFAULT NULL COMMENT 'Se hará llamada',
  `mmcall` char(1) DEFAULT NULL COMMENT 'Se enviará llamada a MMCall',
  `lista` bigint(11) DEFAULT NULL COMMENT 'Lista de  distribución',
  `escalar1` char(1) DEFAULT NULL COMMENT 'Escalar 1ro',
  `tiempo1` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (1)',
  `lista1` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (1)',
  `log1` char(1) DEFAULT NULL COMMENT 'Generar LOG (1)',
  `sms1` char(1) DEFAULT NULL COMMENT 'Enviar SMS (1)',
  `correo1` char(1) DEFAULT NULL COMMENT 'Enviar correo (1)',
  `llamada1` char(1) DEFAULT NULL COMMENT 'Generar Llamada (1)',
  `mmcall1` char(1) DEFAULT NULL COMMENT 'Área de MMCall (1)',
  `repetir1` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (1)',
  `escalar2` char(1) DEFAULT NULL COMMENT 'Escalar 2do',
  `tiempo2` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (2)',
  `lista2` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (2)',
  `log2` char(1) DEFAULT NULL COMMENT 'Generar LOG (2)',
  `sms2` char(1) DEFAULT NULL COMMENT 'Enviar SMS (2)',
  `correo2` char(1) DEFAULT NULL COMMENT 'Enviar correo (2)',
  `llamada2` char(1) DEFAULT NULL COMMENT 'Generar Llamada (2)',
  `mmcall2` char(1) DEFAULT NULL COMMENT 'Área de MMCall (2)',
  `repetir2` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (2)',
  `escalar3` char(1) DEFAULT NULL COMMENT 'Escalar 3ro',
  `tiempo3` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (3)',
  `lista3` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (3)',
  `log3` char(1) DEFAULT NULL COMMENT 'Generar LOG (3)',
  `sms3` char(1) DEFAULT NULL COMMENT 'Enviar SMS (3)',
  `correo3` char(1) DEFAULT NULL COMMENT 'Enviar correo (3)',
  `llamada3` char(1) DEFAULT NULL COMMENT 'Generar Llamada (3)',
  `mmcall3` char(1) DEFAULT NULL COMMENT 'Área de MMCall (3)',
  `repetir3` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (3)',
  `escalar4` char(1) DEFAULT NULL COMMENT 'Escalar 4to',
  `tiempo4` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (4)',
  `lista4` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (4)',
  `log4` char(1) DEFAULT NULL COMMENT 'Generar LOG (4)',
  `sms4` char(1) DEFAULT NULL COMMENT 'Enviar SMS (4)',
  `correo4` char(1) DEFAULT NULL COMMENT 'Enviar correo (4)',
  `llamada4` char(1) DEFAULT NULL COMMENT 'Generar Llamada (4)',
  `mmcall4` char(1) DEFAULT NULL COMMENT 'Área de MMCall (4)',
  `repetir4` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (4)',
  `escalar5` char(1) DEFAULT NULL COMMENT 'Escalar 5to',
  `tiempo5` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (5)',
  `lista5` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (5)',
  `log5` char(1) DEFAULT NULL COMMENT 'Generar LOG (5)',
  `sms5` char(1) DEFAULT NULL COMMENT 'Enviar SMS (5)',
  `correo5` char(1) DEFAULT NULL COMMENT 'Enviar correo (5)',
  `llamada5` char(1) DEFAULT NULL COMMENT 'Generar Llamada (5)',
  `mmcall5` char(1) DEFAULT NULL COMMENT 'Área de MMCall (5)',
  `repetir5` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (5)',
  `repetir` char(1) DEFAULT NULL COMMENT 'Repetir llamada',
  `repetir_tiempo` bigint(8) DEFAULT '0' COMMENT 'Repetir llamada (segundos)',
  `repetir_log` char(1) DEFAULT NULL COMMENT 'Generar log en la repetición',
  `repetir_sms` char(1) DEFAULT NULL COMMENT 'Enviar SMS en la repetición',
  `repetir_correo` char(1) DEFAULT NULL COMMENT 'Enviar correo en la repetición',
  `repetir_llamada` char(1) DEFAULT NULL COMMENT 'Generar llamada en la repetición',
  `repetir_mmcall` char(1) DEFAULT NULL COMMENT 'Área de MMCall en la repetición',
  `estadistica` char(1) DEFAULT NULL COMMENT 'Generar estadística',
  `escape_veces` int(2) DEFAULT '3' COMMENT 'Número de veces que se repetirá una llamada',
  `escape_accion` char(1) DEFAULT NULL COMMENT 'Acción de Escape',
  `escape_mensaje` varchar(200) DEFAULT NULL COMMENT 'Mensaje a enviar si se agotan las llamadas',
  `escape_lista` bigint(11) DEFAULT NULL COMMENT 'Lista de distribución',
  `informar_resolucion` char(1) DEFAULT NULL COMMENT 'Infoermar resolución',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=60 ;

--
-- Volcado de datos para la tabla `cat_alertas`
--

INSERT INTO `cat_alertas` (`id`, `referencia`, `nombre`, `solapar`, `tipo`, `notas`, `proceso`, `acumular`, `acumular_veces`, `acumular_tiempo`, `acumular_inicializar`, `acumular_tipo_mensaje`, `acumular_mensaje`, `log`, `sms`, `correo`, `llamada`, `mmcall`, `lista`, `escalar1`, `tiempo1`, `lista1`, `log1`, `sms1`, `correo1`, `llamada1`, `mmcall1`, `repetir1`, `escalar2`, `tiempo2`, `lista2`, `log2`, `sms2`, `correo2`, `llamada2`, `mmcall2`, `repetir2`, `escalar3`, `tiempo3`, `lista3`, `log3`, `sms3`, `correo3`, `llamada3`, `mmcall3`, `repetir3`, `escalar4`, `tiempo4`, `lista4`, `log4`, `sms4`, `correo4`, `llamada4`, `mmcall4`, `repetir4`, `escalar5`, `tiempo5`, `lista5`, `log5`, `sms5`, `correo5`, `llamada5`, `mmcall5`, `repetir5`, `repetir`, `repetir_tiempo`, `repetir_log`, `repetir_sms`, `repetir_correo`, `repetir_llamada`, `repetir_mmcall`, `estadistica`, `escape_veces`, `escape_accion`, `escape_mensaje`, `escape_lista`, `informar_resolucion`, `estatus`, `creacion`, `modificacion`, `creado`, `modificado`) VALUES
(56, 'Alerta', 'Tiempo de stock excedido', NULL, 1, 'Ejemplo TENNECO', 0, 'N', 0, 0, 'S', 'T', '', NULL, 'N', 'S', 'N', 'S', 1, 'T', 1800, 12, NULL, 'N', 'S', 'N', 'N', 'S', 'S', 1800, 15, NULL, 'N', 'S', 'N', 'N', 'S', 'T', 1800, 15, NULL, 'N', 'S', 'N', 'N', 'S', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 'S', 3600, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, 'S', 'A', '2019-08-10 22:03:25', '2019-09-04 15:29:34', 1, 1),
(57, 'Alerta', 'Tiempo de programación excedido', NULL, 3, 'Ejemplo TENNECO', 20, 'N', 0, 0, 'S', 'T', '', NULL, 'N', 'S', 'N', 'S', 1, 'T', 5400, 12, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 'S', 1800, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, 'S', 'A', '2019-08-12 10:48:32', '2019-09-04 15:29:10', 1, 1),
(58, 'Alerta', 'Tiempo de proceso excedido', NULL, 2, 'Ejemplo TENNECO', 0, 'N', 0, 0, 'S', 'T', '', NULL, 'N', 'S', 'N', 'S', 1, 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 'S', 3600, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, 'S', 'A', '2019-08-14 12:44:54', '2019-09-04 15:26:37', 1, 1),
(59, 'Alerta', 'Salto de operación', NULL, 4, 'Ejemplo TENNECO', 0, 'N', 0, 0, 'S', 'T', '', NULL, 'N', 'S', 'N', 'S', 1, 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 'N', 0, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, 'S', 'A', '2019-08-21 13:20:33', '2019-09-04 15:25:37', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_correos`
--

CREATE TABLE IF NOT EXISTS `cat_correos` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `nombre` varchar(60) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `para` varchar(2000) DEFAULT NULL COMMENT 'Lista de distribución',
  `copia` varchar(2000) DEFAULT NULL COMMENT 'Lista de distribución (con copia)',
  `oculta` varchar(2000) DEFAULT NULL COMMENT 'Lista de distribución (con copia oculta)',
  `titulo` varchar(200) DEFAULT NULL COMMENT 'Título del correo',
  `cuerpo` varchar(1000) DEFAULT NULL COMMENT 'Cuerpo del correo',
  `reportes` varchar(100) DEFAULT NULL COMMENT 'Lista de reportes',
  `periodos` varchar(100) DEFAULT NULL COMMENT 'Períodos para generarlo',
  `nperiodos` varchar(100) DEFAULT NULL COMMENT 'Número de períodos',
  `frecuencia` varchar(20) DEFAULT NULL COMMENT 'Frecuencia de envío',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Catálogo de correos' AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_defectos`
--

CREATE TABLE IF NOT EXISTS `cat_defectos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `referencia` varchar(20) DEFAULT NULL COMMENT 'Referencia',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del defecto',
  `prefijo` varchar(30) DEFAULT NULL COMMENT 'Prefijo de la descripción',
  `agrupador1` bigint(20) DEFAULT NULL COMMENT 'ID del agrupador (1)',
  `agrupador2` bigint(20) DEFAULT NULL COMMENT 'ID del agrupador (2)',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `minimo` decimal(17,7) DEFAULT NULL COMMENT 'Minima cantidad a reportar',
  `maximo` decimal(17,7) DEFAULT NULL COMMENT 'Maxima cantidad a reportar',
  `defecto` char(1) DEFAULT NULL COMMENT 'Registro por defecto',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Catálogo de defectos' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_distribucion`
--

CREATE TABLE IF NOT EXISTS `cat_distribucion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `referencia` varchar(30) DEFAULT NULL COMMENT 'Referencia',
  `nombre` varchar(60) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `prefijo` varchar(30) DEFAULT NULL COMMENT 'Prefijo del registro',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `telefonos` varchar(2000) DEFAULT NULL COMMENT 'Número de teléfono',
  `correos` varchar(2000) DEFAULT NULL COMMENT 'Correo electrónico',
  `mmcall` varchar(2000) DEFAULT NULL COMMENT 'Requesters de MMCall',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Catálogo de listas de distribución' AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `cat_distribucion`
--

INSERT INTO `cat_distribucion` (`id`, `secuencia`, `referencia`, `nombre`, `prefijo`, `imagen`, `telefonos`, `correos`, `mmcall`, `estatus`, `creacion`, `modificacion`, `creado`, `modificado`) VALUES
(1, NULL, '', 'SUPERVISORES', NULL, NULL, '', 'elvismontezuma@hotmail.com;luisenrique.escuderosilva@tenneco.com;saul.arellano@tenneco.com', 'D1', 'A', '2019-06-16 14:19:11', '2019-09-04 15:30:21', 1, 1),
(12, NULL, '', 'LOGISTICA', NULL, NULL, '', 'eder.marquez@tenneco.com', '', 'A', '2019-06-18 08:43:25', '2019-09-04 15:31:07', 1, 1),
(15, NULL, '', 'GERENCIA', NULL, NULL, '4423518811', 'enrique.castillo@tenneco.com', '', 'I', '2019-06-28 10:54:00', '2019-09-04 15:31:36', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_equipos`
--

CREATE TABLE IF NOT EXISTS `cat_equipos` (
  `id` bigint(20) NOT NULL COMMENT 'ID del registro',
  `planta` bigint(20) DEFAULT NULL COMMENT 'ID de la planta',
  `linea` bigint(20) DEFAULT NULL COMMENT 'ID de la linea',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `referencia` varchar(30) DEFAULT NULL COMMENT 'Referencia con el sistema',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `prefijo` varchar(30) DEFAULT NULL COMMENT 'Prefijo del registro',
  `notas` varchar(300) DEFAULT NULL COMMENT 'Notas varias',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `agrupador1` bigint(11) DEFAULT NULL COMMENT 'ID del agrupador (1)',
  `agrupador2` bigint(11) DEFAULT NULL COMMENT 'ID del agrupador (2)',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Catálogo de equipos';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_generales`
--

CREATE TABLE IF NOT EXISTS `cat_generales` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `tabla` int(6) DEFAULT NULL COMMENT 'ID de la tabla',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `prefijo` varchar(30) DEFAULT NULL COMMENT 'Prefijo del registro',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Tablas generales' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_grupos`
--

CREATE TABLE IF NOT EXISTS `cat_grupos` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `referencia` varchar(20) DEFAULT NULL COMMENT 'Referencia',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `prefijo` varchar(30) DEFAULT NULL COMMENT 'Prefijo del registro',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `agrupador1` bigint(11) DEFAULT NULL COMMENT 'ID del agrupador (1)',
  `agrupador2` bigint(11) DEFAULT NULL COMMENT 'ID del agrupador (2)',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Catálogo de grupos' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_lineas`
--

CREATE TABLE IF NOT EXISTS `cat_lineas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `planta` bigint(20) DEFAULT NULL COMMENT 'ID de la planta',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `referencia` varchar(30) DEFAULT NULL COMMENT 'Referencia con el sistema',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `notas` varchar(300) DEFAULT NULL COMMENT 'Notas varias',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Catálogo de líneas' AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_listas`
--

CREATE TABLE IF NOT EXISTS `cat_listas` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `referencia` varchar(20) DEFAULT NULL COMMENT 'Referencia',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `prefijo` varchar(30) DEFAULT NULL COMMENT 'Prefijo del registro',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `clase` bigint(11) DEFAULT NULL COMMENT 'ID de la clase',
  `area` bigint(11) DEFAULT NULL COMMENT 'ID del área',
  `equipo` bigint(11) DEFAULT NULL COMMENT 'ID del equipo',
  `tiempo_llenado` bigint(6) DEFAULT NULL COMMENT 'Tiempo límite para el llenado (segundos)',
  `tiempo_alarma` char(1) DEFAULT NULL COMMENT 'Generar alarma al sobrepasar el límite por',
  `prioridad` int(2) DEFAULT NULL COMMENT 'Prioridad del registro',
  `horario` bigint(11) DEFAULT NULL COMMENT 'Calendario',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` timestamp NULL DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Catálogo de listas de verificación' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_medios`
--

CREATE TABLE IF NOT EXISTS `cat_medios` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `tipo` int(4) DEFAULT NULL COMMENT 'Tipo de comunicaión',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` timestamp NULL DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Catálogo de medios de envío' AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_paros`
--

CREATE TABLE IF NOT EXISTS `cat_paros` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `referencia` varchar(20) DEFAULT NULL COMMENT 'Referencia',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `tipo` bigint(11) DEFAULT NULL COMMENT 'Tipo de paro',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `agrupador1` bigint(11) DEFAULT NULL COMMENT 'ID del agrupador (1)',
  `agrupador2` bigint(11) DEFAULT NULL COMMENT 'ID del agrupador (2)',
  `adelantar` char(1) DEFAULT NULL COMMENT 'Se puede adelantar?',
  `cancelar` char(1) DEFAULT NULL COMMENT 'Se puede cancelar?',
  `con_clave` char(1) DEFAULT NULL COMMENT 'Se puede cabiar con clave',
  `una_vez` char(1) DEFAULT NULL COMMENT 'Paro de una vez',
  `periodico` char(1) DEFAULT NULL COMMENT 'Es un paro periódico',
  `semana` char(7) DEFAULT NULL COMMENT 'Día de semana',
  `habiles` char(1) DEFAULT NULL COMMENT 'Se aplica en día no hábiles',
  `desde` time DEFAULT NULL COMMENT 'Hora de inicio',
  `hasta` time DEFAULT NULL COMMENT 'Hora de fin',
  `inicia` date DEFAULT NULL COMMENT 'Fecha de inicio',
  `finaliza` date DEFAULT NULL COMMENT 'Fecha de finalización',
  `tiempo_seg` bigint(11) DEFAULT NULL COMMENT 'Tiempo del pago en segundos',
  `clendario` bigint(11) DEFAULT NULL COMMENT 'ID del calenadario',
  `carpeta` varchar(255) DEFAULT NULL COMMENT 'Carpeta de imagenes y videos',
  `defecto` char(1) DEFAULT NULL COMMENT 'Registro por defecto',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Catálogo de paros' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_partes`
--

CREATE TABLE IF NOT EXISTS `cat_partes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `referencia` varchar(30) DEFAULT NULL COMMENT 'Referencia con el sistema',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `prefijo` varchar(30) DEFAULT NULL COMMENT 'Prefijo del registro',
  `notas` varchar(300) DEFAULT NULL COMMENT 'Notas varias',
  `ruta` bigint(20) DEFAULT NULL COMMENT 'Ruta de fabricación asociada',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Catálogo de numeros de parte' AUTO_INCREMENT=22 ;

--
-- Volcado de datos para la tabla `cat_partes`
--

INSERT INTO `cat_partes` (`id`, `secuencia`, `referencia`, `nombre`, `prefijo`, `notas`, `ruta`, `imagen`, `estatus`, `creacion`, `modificacion`, `creado`, `modificado`) VALUES
(1, NULL, '56577820', '85.4x0.40 3ra Ranura ', NULL, NULL, 1, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(2, NULL, '56649110', '77.0x1.20 1ra Ranura ', NULL, NULL, 2, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(3, NULL, '56693200', '77.0x1.20 2da Ranura ', NULL, NULL, 3, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(4, NULL, '56694200', '80.5x1.20 2da Ranura ', NULL, NULL, 4, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(5, NULL, '56730600', '80.5x1.20 1ra Ranura', NULL, NULL, 5, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(6, NULL, '56935720', '85.4x1.20 1ra Ranura', NULL, NULL, 6, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(7, NULL, '70037120', '74.0x1.20 1era Ranura', NULL, NULL, 7, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(8, NULL, '70037860', '99.6x1.20 1ra Ranura', NULL, NULL, 8, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(9, NULL, '70039540', '96.009x1.20 1ra Ranura', NULL, NULL, 9, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(10, NULL, '70049830', '84.0x0.46 3ra Ranura ', NULL, NULL, 10, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(11, NULL, '70050130', '84.0x1.20 2da Ranura ', NULL, NULL, 11, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(12, NULL, '70052840', '103.25x1.20 1ra Ranura', NULL, '', 12, '/sigma/assets/imagenes/CAPTURA DE REQUESICION_5strapeadoresjaladoresatomizadores.PNG', 'A', '2019-08-29 14:38:13', '2019-09-04 16:08:13', 1, 1),
(13, NULL, '70058730', '84x1.20 1ra Ranura', NULL, NULL, 13, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(14, NULL, '70059230', '96.0x1.50 1ra Ranura', NULL, NULL, 14, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(15, NULL, '70071820', '86.0x1.20 1ra Ranura', NULL, NULL, 15, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(16, NULL, '70072020', '86.0x0.40 3ra Ranura ', NULL, NULL, 16, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(17, NULL, '70074440', '88.0x0.40 3ra Ranura ', NULL, NULL, 17, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(18, NULL, '70082140', '85.4x1.20 2da Ranura', NULL, NULL, 18, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(19, NULL, '70090010', '100.1x1.20 1ra Ranura', NULL, NULL, 19, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(20, NULL, '70091310', '103.75x1.20 1ra Ranura', NULL, NULL, 20, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1),
(21, NULL, '70091710', '96.509x1.20 1ra Ranura', NULL, NULL, 21, NULL, 'A', '2019-08-29 14:38:13', '2019-08-29 14:38:13', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_plantas`
--

CREATE TABLE IF NOT EXISTS `cat_plantas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `referencia` varchar(30) DEFAULT NULL COMMENT 'Referencia con el sistema',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `notas` varchar(300) DEFAULT NULL COMMENT 'Notas varias',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Catálogo de plantas' AUTO_INCREMENT=24 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_procesos`
--

CREATE TABLE IF NOT EXISTS `cat_procesos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `referencia` varchar(30) DEFAULT NULL COMMENT 'Referencia con el sistema',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `notas` varchar(300) DEFAULT NULL COMMENT 'Notas varias',
  `tipo` char(1) DEFAULT NULL COMMENT 'Tipo de proceso: N = Normal, E = Espera',
  `capacidad_stock` bigint(6) DEFAULT '0' COMMENT 'Capacidad en Stock (lotes)',
  `capacidad_proceso` bigint(6) DEFAULT '0' COMMENT 'Capacidad en proceso (lotes)',
  `estatus` char(1) DEFAULT 'A' COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`referencia`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Catalogo de procesos' AUTO_INCREMENT=31 ;

--
-- Volcado de datos para la tabla `cat_procesos`
--

INSERT INTO `cat_procesos` (`id`, `secuencia`, `referencia`, `nombre`, `imagen`, `notas`, `tipo`, `capacidad_stock`, `capacidad_proceso`, `estatus`, `creacion`, `modificacion`, `creado`, `modificado`) VALUES
(1, NULL, 'AEE010', 'Aceitado y empaque', '', '', NULL, 8, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:39:04', 1, 1),
(2, NULL, 'ACU010', 'Acuñado', '', '', NULL, 8, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:40:05', 1, 1),
(3, NULL, 'LOS010', 'Cepillado axial', '', '', NULL, 4, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:40:23', 1, 1),
(4, NULL, 'CGG010', 'Cepillado del gap', '', '', NULL, 10, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:40:39', 1, 1),
(5, NULL, 'COL010', 'Coloring', '', '', NULL, 7, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:41:03', 1, 1),
(6, NULL, 'CTPP010', 'Corte TP', '', '', NULL, 7, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:41:13', 1, 1),
(7, NULL, 'FOSS010', 'Fosfato', '', '', NULL, 15, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:41:31', 1, 1),
(8, NULL, 'GIN010', 'Gap Inspection', '', '', NULL, 4, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:41:44', 1, 1),
(9, NULL, 'LCC010', 'Inspección 100% linea de contacto', '', '', NULL, 6, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:41:55', 1, 1),
(10, NULL, 'IFF010', 'Inspección Final', '', '', NULL, 8, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:42:07', 1, 1),
(11, NULL, 'IMM010', 'Inspección muestral', '', '', NULL, 6, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:47:57', 1, 1),
(12, NULL, 'LAP010', 'Lapeado', '', '', NULL, 6, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:48:11', 1, 1),
(13, NULL, 'DDD010', 'Lavadora Dürr 1/2', '', '', NULL, 16, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:48:49', 1, 1),
(14, NULL, 'MSAA010', 'MSA', '', '', NULL, 6, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:49:09', 1, 1),
(15, NULL, 'MSAA1010', 'MSA 1', '', '', NULL, 3, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:49:24', 1, 1),
(16, NULL, 'NIT010', 'Nitrurado', '', '', NULL, 13, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:49:44', 1, 1),
(17, NULL, 'OCC010', 'Oval Coiling', '', '', NULL, 8, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:50:08', 1, 1),
(18, NULL, 'PKK010', 'Pulido Knopp', '', '', NULL, 8, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:50:24', 1, 1),
(19, NULL, 'PTPP010', 'Pulido TP', '', '', NULL, 7, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:50:49', 1, 1),
(20, NULL, 'PVDD010', 'PVD', '', '', NULL, 16, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:55:32', 1, 1),
(21, NULL, 'RI010', 'Rail inspection', '', '', NULL, 7, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:55:53', 1, 1),
(22, NULL, 'RFOS010', 'Recibo de fosfato', '', '', NULL, 15, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 13:56:06', 1, 1),
(23, NULL, 'RE010', 'Recocido', '', '', NULL, 14, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 15:14:52', 1, 1),
(24, NULL, 'GGG010', 'Rectificado + chaflan del gap', '', '', NULL, 8, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 15:15:12', 1, 1),
(25, NULL, 'DKK010', 'Rectificado axial', '', '', NULL, 12, 0, 'A', '2019-08-29 15:51:10', '2019-09-04 16:45:39', 1, 1),
(26, NULL, 'RCC010', 'Round Coiling', '/sigma/assets/imagenes/round coiling-Imagen.PNG', '', NULL, 7, 0, 'A', '2019-08-29 15:51:10', '2019-09-04 15:39:33', 1, 1),
(27, NULL, 'SBB010', 'Sanblasting', '', '', NULL, 5, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 16:02:46', 1, 1),
(28, NULL, 'DCTT010', 'Torneado CAM+ Corte del Gap', '', '', NULL, 5, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 16:03:03', 1, 1),
(29, NULL, 'AIDAA010', 'Torneado perfil minuto', '', '', NULL, 5, 0, 'A', '2019-08-29 15:51:10', '2019-08-30 16:03:23', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_rutas`
--

CREATE TABLE IF NOT EXISTS `cat_rutas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `referencia` varchar(30) DEFAULT NULL COMMENT 'Referencia con el sistema',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `prefijo` varchar(30) DEFAULT NULL COMMENT 'Prefijo del registro',
  `notas` varchar(300) DEFAULT NULL COMMENT 'Notas varias',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `alarma` char(1) DEFAULT NULL COMMENT 'Genera alarmas?',
  `inicia` int(6) DEFAULT NULL,
  `finaliza` int(6) DEFAULT NULL,
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Catálogo de rutas de producción' AUTO_INCREMENT=22 ;

--
-- Volcado de datos para la tabla `cat_rutas`
--

INSERT INTO `cat_rutas` (`id`, `referencia`, `nombre`, `prefijo`, `notas`, `imagen`, `alarma`, `inicia`, `finaliza`, `estatus`, `creacion`, `modificacion`, `creado`, `modificado`) VALUES
(1, '56577820', '85.4x0.40 3ra Ranura ', NULL, NULL, NULL, NULL, 1, 17, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(2, '56649110', '77.0x1.20 1ra Ranura ', NULL, NULL, NULL, NULL, 1, 18, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(3, '56693200', '77.0x1.20 2da Ranura ', NULL, NULL, NULL, NULL, 1, 16, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(4, '56694200', '80.5x1.20 2da Ranura ', NULL, NULL, NULL, NULL, 1, 18, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(5, '56730600', '80.5x1.20 1ra Ranura', NULL, NULL, NULL, NULL, 1, 31, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(6, '56935720', '85.4x1.20 1ra Ranura', NULL, NULL, NULL, NULL, 1, 24, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(7, '70037120', '74.0x1.20 1era Ranura', NULL, NULL, NULL, NULL, 1, 27, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(8, '70037860', '99.6x1.20 1ra Ranura', NULL, NULL, NULL, NULL, 1, 28, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(9, '70039540', '96.009x1.20 1ra Ranura', NULL, NULL, NULL, NULL, 1, 28, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(10, '70049830', '84.0x0.46 3ra Ranura ', NULL, NULL, NULL, NULL, 1, 17, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(11, '70050130', '84.0x1.20 2da Ranura ', NULL, NULL, NULL, NULL, 1, 22, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(12, '70052840', '103.25x1.20 1ra Ranura', NULL, NULL, NULL, NULL, 1, 28, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(13, '70058730', '84x1.20 1ra Ranura', NULL, NULL, NULL, NULL, 1, 28, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(14, '70059230', '96.0x1.50 1ra Ranura', NULL, NULL, NULL, NULL, 1, 25, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(15, '70071820', '86.0x1.20 1ra Ranura', NULL, NULL, NULL, NULL, 1, 28, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(16, '70072020', '86.0x0.40 3ra Ranura ', NULL, NULL, NULL, NULL, 1, 16, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(17, '70074440', '88.0x0.40 3ra Ranura ', NULL, NULL, NULL, NULL, 1, 17, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(18, '70082140', '85.4x1.20 2da Ranura', NULL, NULL, NULL, NULL, 1, 28, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(19, '70090010', '100.1x1.20 1ra Ranura', NULL, NULL, NULL, NULL, 1, 28, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(20, '70091310', '103.75x1.20 1ra Ranura', NULL, NULL, NULL, NULL, 1, 28, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1),
(21, '70091710', '96.509x1.20 1ra Ranura', NULL, NULL, NULL, NULL, 1, 28, 'A', '2019-08-29 15:52:44', '2019-08-29 15:52:44', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_situaciones`
--

CREATE TABLE IF NOT EXISTS `cat_situaciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `referencia` varchar(30) DEFAULT NULL COMMENT 'Referencia con el sistema',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `tipo` int(2) DEFAULT NULL COMMENT 'Tipo de situación (0=Calidad, 50= Scrap)',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Catálogo de situaciones' AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `cat_situaciones`
--

INSERT INTO `cat_situaciones` (`id`, `secuencia`, `referencia`, `nombre`, `tipo`, `estatus`, `creacion`, `modificacion`, `creado`, `modificado`) VALUES
(1, NULL, 'ICC010', 'Inspección Calidad', 0, 'A', '2019-08-29 10:26:09', '2019-08-29 10:26:09', 1, 1),
(2, NULL, 'CR010', 'Cuarentena', 0, 'A', '2019-08-29 10:26:23', '2019-08-29 10:26:23', 1, 1),
(3, NULL, 'REIC010', 'Reinspección', 0, 'A', '2019-08-29 10:26:36', '2019-08-29 10:26:36', 1, 1),
(4, NULL, 'SC010', 'SCRAP', 50, 'A', '2019-08-29 10:26:48', '2019-08-29 10:26:48', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_usuarios`
--

CREATE TABLE IF NOT EXISTS `cat_usuarios` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `referencia` varchar(50) DEFAULT NULL COMMENT 'Referencia',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `clave` varchar(50) DEFAULT NULL COMMENT 'Conraseña',
  `prefijo` varchar(50) DEFAULT NULL COMMENT 'Prefijo del registro',
  `notas` varchar(100) DEFAULT NULL COMMENT 'Notas varias',
  `rol` char(1) DEFAULT NULL COMMENT 'Rol de usuario',
  `politica` int(2) DEFAULT NULL COMMENT 'Política de contraseña',
  `operacion` char(1) DEFAULT NULL COMMENT 'Ver todas las operaciones (S/N)',
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Imagen a mostrar',
  `admin` char(1) DEFAULT 'N' COMMENT 'Es administrador',
  `calidad` char(1) DEFAULT 'N' COMMENT 'Puede hacer inspecciones de calidad',
  `reversos` char(1) DEFAULT 'N' COMMENT 'Puede hacer reversos',
  `programacion` char(1) DEFAULT 'N' COMMENT 'Ver programación(lectura)',
  `cerrar_al_ejecutar` char(1) DEFAULT 'N' COMMENT 'Cerrar menú al ajecutar',
  `vista_resumida_fallas` char(1) DEFAULT NULL COMMENT 'Vista resumida de las fallas',
  `ultima_pantalla` int(2) DEFAULT '0' COMMENT 'Última pantalla usada',
  `inicializada` char(1) DEFAULT 'S' COMMENT 'Contraseña inicializada',
  `estatus` char(1) DEFAULT 'A' COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT '0' COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT '0' COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Catalogo de usuarios' AUTO_INCREMENT=40 ;

--
-- Volcado de datos para la tabla `cat_usuarios`
--

INSERT INTO `cat_usuarios` (`id`, `secuencia`, `referencia`, `nombre`, `clave`, `prefijo`, `notas`, `rol`, `politica`, `operacion`, `imagen`, `admin`, `calidad`, `reversos`, `programacion`, `cerrar_al_ejecutar`, `vista_resumida_fallas`, `ultima_pantalla`, `inicializada`, `estatus`, `creacion`, `modificacion`, `creado`, `modificado`) VALUES
(1, 1, 'ADMIN', 'ADMINISTRADOR DEL SISTEMA', '123', '', '', 'A', 0, 'S', NULL, 'S', 'S', 'S', 'N', 'N', 'S', 4, NULL, 'A', '2019-06-30 23:52:20', '2019-09-02 00:15:33', 1, 1),
(3, 3, 'OPERADOR', 'OPERADOR DE PLANTA', '123', NULL, NULL, 'O', NULL, NULL, NULL, 'N', 'N', NULL, 'N', 'S', 'N', 12, 'N', 'A', '2019-07-08 09:37:25', '2019-07-08 09:37:25', 1, 1),
(4, 4, 'GESTION', 'GESTOR DE LA APLICACION', '123', NULL, '', 'G', NULL, '', NULL, '', 'S', 'S', 'N', 'S', NULL, NULL, NULL, 'A', '2019-07-08 09:37:25', '2019-09-02 22:05:01', 1, 1),
(15, NULL, 'LESCUDERO', 'Luis Escudero', NULL, NULL, NULL, 'A', NULL, 'S', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:01:28', 1, 1),
(16, NULL, 'EMARQUEZ', 'Eder Marquez ', NULL, NULL, NULL, 'A', NULL, 'S', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:01:28', 1, 1),
(17, NULL, 'SARELLANO', 'Saul Arellano', NULL, NULL, NULL, 'A', NULL, 'S', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:01:28', 1, 1),
(18, NULL, 'JTIZAPANTZI', 'Jesus Tizapantzi', NULL, NULL, NULL, 'A', NULL, 'S', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:01:28', 1, 1),
(19, NULL, 'JMORETT', 'Jose Morett ', NULL, NULL, NULL, 'A', NULL, 'S', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:01:28', 1, 1),
(20, NULL, 'AROBLES', 'Arturo Robles', NULL, NULL, NULL, 'G', NULL, 'S', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:01:28', 1, 1),
(21, NULL, 'CALIDAD', 'Calidad', NULL, NULL, '', 'C', NULL, 'N', NULL, 'N', 'S', 'N', 'S', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-05 01:18:08', 1, 1),
(22, NULL, 'SIF', 'Supervisor IF', NULL, NULL, NULL, 'C', NULL, 'N', NULL, 'N', 'S', 'N', 'S', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:01:28', 1, 1),
(23, NULL, 'SST', 'Supervisor ST', NULL, NULL, NULL, 'C', NULL, 'N', NULL, 'N', 'S', 'N', 'S', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:01:28', 1, 1),
(24, NULL, 'ECASTILLO', 'Enrique Castillo', NULL, NULL, NULL, 'G', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:01:28', 1, 1),
(25, NULL, 'OPEREZ', 'Olimpia Perez', NULL, NULL, NULL, 'G', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:01:28', 1, 1),
(26, NULL, 'KALFONSO', 'Karla Alfonso', NULL, NULL, NULL, 'G', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:01:28', 1, 1),
(27, NULL, 'SURFACE', 'Surface', NULL, NULL, '', 'O', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:07:57', 1, 1),
(28, NULL, 'PVD', 'PVD', NULL, NULL, '', 'O', NULL, 'N', NULL, 'N', 'N', 'N', 'S', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:08:32', 1, 1),
(29, NULL, 'OVAL', 'Oval C', NULL, NULL, '', 'O', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:09:04', 1, 1),
(30, NULL, 'DISKUSS', 'Diskuss-LC', NULL, NULL, '', 'O', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:19:11', 1, 1),
(31, NULL, 'ACUÑADO', 'Acuñado-CE', NULL, NULL, '', 'O', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:11:57', 1, 1),
(32, NULL, 'GAP', 'Gap Grinding', NULL, NULL, '', 'O', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:17:45', 1, 1),
(33, NULL, 'LAPEADO', 'Lapeado', NULL, NULL, '', 'O', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:13:01', 1, 1),
(34, NULL, '3RANURA', '3ra ranura', NULL, NULL, '', 'O', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:11:38', 1, 1),
(35, NULL, '2RANURA', '2da ranura', NULL, NULL, '', 'O', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:11:11', 1, 1),
(36, NULL, 'MSA', 'MSA', NULL, NULL, '', 'O', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:10:46', 1, 1),
(37, NULL, 'AEIF', 'AE-IF', NULL, NULL, '', 'O', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:13:28', 1, 1),
(38, NULL, 'MUESTRAL', 'Muestral', NULL, NULL, '', 'O', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:19:35', 1, 1),
(39, NULL, 'ALMACEN', 'Almacen', NULL, NULL, '', 'O', NULL, 'N', NULL, 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'S', 'A', '2019-09-03 02:01:28', '2019-09-03 02:18:03', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_variables`
--

CREATE TABLE IF NOT EXISTS `cat_variables` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `referencia` varchar(20) DEFAULT NULL COMMENT 'Referencia del registro',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Descripción del registro',
  `prefijo` varchar(30) DEFAULT NULL COMMENT 'Prefijo del registro',
  `requerido` char(1) DEFAULT NULL COMMENT 'Campo requerido',
  `notas` varchar(500) DEFAULT NULL COMMENT 'Notas de la variable',
  `tipo` int(2) DEFAULT NULL COMMENT 'Tipo de valor (10=numérico, 20=Si/NO, 30=Tabla)',
  `idtabla` bigint(11) DEFAULT NULL COMMENT 'ID de la tabla',
  `unidad` bigint(11) DEFAULT NULL COMMENT 'ID de la unidad de medida',
  `permitido_min` decimal(30,10) DEFAULT NULL COMMENT 'Valor mínimo',
  `permitido_max` decimal(30,10) DEFAULT NULL COMMENT 'Valor máximo',
  `alarma_min` decimal(30,10) DEFAULT NULL COMMENT 'Valor mínimo para generar alarma',
  `alarma_max` decimal(30,10) DEFAULT NULL COMMENT 'Valor máximo para generar alarma',
  `alarma_clave` char(1) DEFAULT NULL COMMENT 'Valor fuera de rango requiere clave',
  `alarma_sino` char(1) DEFAULT NULL COMMENT 'Alarmar Si/No',
  `color` varchar(20) DEFAULT NULL COMMENT 'Color de fondo',
  `acumular` char(1) DEFAULT NULL COMMENT 'Acumular',
  `resaltada` char(1) DEFAULT NULL COMMENT 'Resaltar variable',
  `mostrar_rango` char(1) DEFAULT NULL COMMENT 'Mostrar rango en pantalla',
  `confirmar_respuesta` char(1) DEFAULT NULL COMMENT 'Confirmar la respuesta',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha en que se agregó',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha en que se modificó',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Usuario que agregó',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Usuario que modificó',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE IF NOT EXISTS `configuracion` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `tiempo` bigint(8) DEFAULT NULL COMMENT 'Tiempo de revisión',
  `correo_cuenta` varchar(100) DEFAULT NULL COMMENT 'Perfil de correo',
  `correo_puerto` varchar(100) DEFAULT NULL COMMENT 'Puerto',
  `correo_ssl` char(1) DEFAULT NULL COMMENT 'Seguridad SSL',
  `correo_clave` varchar(100) DEFAULT NULL COMMENT 'Contraseña',
  `correo_host` varchar(100) DEFAULT NULL COMMENT 'Host',
  `flag_agregar` char(1) DEFAULT NULL COMMENT 'Flag de que se agregó una falla',
  `ejecutando_desde` datetime DEFAULT NULL COMMENT 'Ejecutando desde',
  `ultima_falla` bigint(20) DEFAULT NULL COMMENT 'Último ID de falla revisado',
  `ultima_revision` datetime DEFAULT NULL COMMENT 'Fecha de la última revisión',
  `revisar_cada` bigint(8) DEFAULT '0' COMMENT 'Revisar cada n segundos',
  `utilizar_arduino` char(1) DEFAULT NULL COMMENT 'Usar arduino?',
  `puerto_comm1` varchar(10) DEFAULT NULL COMMENT 'Puerto comm (1)',
  `puerto_comm1_par` varchar(100) DEFAULT NULL COMMENT 'Parámetros Puerto comm (1)',
  `puerto_comm2` varchar(10) DEFAULT NULL COMMENT 'Puerto comm (2)',
  `puerto_comm2_par` varchar(100) DEFAULT NULL COMMENT 'Parámetros Puerto comm (2)',
  `puerto_comm3` varchar(10) DEFAULT NULL COMMENT 'Puerto comm (3)',
  `puerto_comm3_par` varchar(100) DEFAULT NULL COMMENT 'Parámetros Puerto comm (3)',
  `puerto_comm4` varchar(10) NOT NULL COMMENT 'Puerto comm (4)',
  `puerto_comm4_par` varchar(100) DEFAULT NULL COMMENT 'Parámetros Puerto comm (4)',
  `puerto_comm5` varchar(10) DEFAULT NULL COMMENT 'Puerto comm (5)',
  `puerto_comm5_par` varchar(100) DEFAULT NULL COMMENT 'Parámetros Puerto comm (5)',
  `puerto_comm6` varchar(10) DEFAULT NULL COMMENT 'Puerto comm (6)',
  `puerto_comm6_par` varchar(100) DEFAULT NULL COMMENT 'Parámetros Puerto comm (6)',
  `ruta_sms` varchar(500) DEFAULT NULL COMMENT 'Ruta para los SMS',
  `ruta_audios` varchar(500) DEFAULT NULL COMMENT 'Ruta para las llamadas',
  `optimizar_llamada` char(1) DEFAULT NULL COMMENT 'Optimiza las llamadas',
  `optimizar_sms` char(1) DEFAULT NULL COMMENT 'Optimiza los SMS',
  `optimizar_correo` char(1) DEFAULT NULL COMMENT 'Optimiza los correos',
  `optimizar_mmcall` char(1) DEFAULT NULL COMMENT 'Optimiza las llamadas a MMCall',
  `mantener_prioridad` char(1) DEFAULT NULL COMMENT 'Mantener prioridad en la optimización',
  `voz_predeterminada` varchar(255) DEFAULT NULL COMMENT 'Voz predeterminada',
  `escape_mmcall` char(1) DEFAULT NULL COMMENT 'Escape para MMCall',
  `escape_mmcall_mensaje` varchar(200) DEFAULT NULL COMMENT 'Mensaje a enviar MMCall',
  `escape_mmcall_lista` bigint(11) DEFAULT NULL COMMENT 'Lista de distribución (requesters ocupados)',
  `escape_mmcall_cancelar` char(1) DEFAULT NULL COMMENT 'Cancelar el llamado a MMCall',
  `escape_llamadas` int(1) DEFAULT NULL COMMENT 'Número de veces a llamar',
  `escape_accion` char(1) DEFAULT NULL COMMENT 'Acción a tomar',
  `escape_lista` bigint(11) DEFAULT NULL COMMENT 'Lista de distribución',
  `escape_mensaje` varchar(200) DEFAULT NULL COMMENT 'Mensaje a enviar',
  `escape_mensaje_propio` char(1) DEFAULT NULL COMMENT 'Enviar mensaje al propio móvil',
  `veces_reproducir` int(1) DEFAULT '1' COMMENT 'Número de veces que se repeduce un audio',
  `gestion_log` char(6) DEFAULT NULL COMMENT 'Año y mes de la última gestión',
  `gestion_meses` int(4) DEFAULT NULL COMMENT 'Número de meses en línea',
  `correo_titulo_falla` char(1) DEFAULT NULL COMMENT 'Mantener el título de la falla',
  `correo_titulo` varchar(100) DEFAULT NULL COMMENT 'Título opcional del correo',
  `correo_cuerpo` varchar(200) DEFAULT NULL COMMENT 'Cuerpo del correo',
  `correo_firma` varchar(100) DEFAULT NULL COMMENT 'Firma del correo',
  `timeout_llamadas` int(4) DEFAULT NULL COMMENT 'Time Out para llamadas',
  `timeout_sms` int(4) DEFAULT NULL COMMENT 'Time Out para SMS',
  `traducir` char(1) DEFAULT NULL COMMENT 'Traducir mensajes de voz',
  `tiempo_corte` bigint(8) DEFAULT '0' COMMENT 'Tiempo del corte en minutos',
  `ultimo_corte` datetime DEFAULT NULL COMMENT 'Fecha y hora del último corte',
  `bajo_hasta` int(3) DEFAULT NULL,
  `bajo_color` varchar(20) DEFAULT NULL,
  `bajo_etiqueta` varchar(30) DEFAULT NULL,
  `medio_hasta` int(3) DEFAULT NULL,
  `medio_color` varchar(20) DEFAULT NULL,
  `medio_etiqueta` varchar(30) DEFAULT NULL,
  `alto_color` varchar(20) DEFAULT NULL,
  `alto_etiqueta` varchar(30) DEFAULT NULL,
  `noatendio_color` varchar(20) DEFAULT NULL,
  `noatendio_etiqueta` varchar(30) DEFAULT NULL,
  `escaladas_color` varchar(20) DEFAULT NULL,
  `escaladas_etiqueta` varchar(30) DEFAULT NULL,
  `flag_monitor` char(1) DEFAULT 'N' COMMENT 'Flag para leer desde el monitor',
  `ruta_archivos_enviar` varchar(500) DEFAULT NULL COMMENT 'Ruta de los archivos a enviar por correo',
  `server_mmcall` varchar(100) DEFAULT NULL COMMENT 'Server para MMCall',
  `cad_consolidado` varchar(20) DEFAULT NULL COMMENT 'Cadena de la consolidado',
  `ruta_imagenes` varchar(500) DEFAULT NULL COMMENT 'Ruta de imágenes',
  `tiempo_imagen` int(4) DEFAULT NULL COMMENT 'Tiempo entre imagenes',
  `graficas_seleccion` varchar(100) DEFAULT NULL COMMENT 'Gráficas a reportar',
  `graficas_duracion` varchar(100) DEFAULT NULL,
  `timeout_fallas` int(10) DEFAULT '0' COMMENT 'Timeout para crear alerta',
  `avisar_segundos` bigint(4) DEFAULT NULL COMMENT 'Avisar con tantos segundos antes',
  `color_aviso` varchar(20) DEFAULT NULL COMMENT 'Color del aviso',
  `contar_post` char(1) DEFAULT NULL COMMENT 'Contar luego de vencer el tiempo',
  `color_post` varchar(20) DEFAULT NULL COMMENT 'Color del post',
  `escaner_prefijo` varchar(10) DEFAULT NULL COMMENT 'Prefijo del escaner',
  `escaner_sufijo` varchar(10) DEFAULT NULL COMMENT 'Sufijo del escaner',
  `tiempo_holgura` int(4) DEFAULT '0',
  `tiempo_entre_lecturas` int(4) DEFAULT NULL COMMENT 'Tiempo entre lecturas (seg)',
  `tiempo_escaner` int(4) DEFAULT '0' COMMENT 'Tiempo de espera entre milesegundos',
  `largo_escaner` int(2) DEFAULT '0' COMMENT 'Largo mínimo de la frase del escaner',
  `lote_inspeccion_clave` char(1) DEFAULT NULL COMMENT 'Requiere clave el envío de lotes a calidad',
  `reverso_permitir` char(1) DEFAULT NULL COMMENT 'Permitir reverso? (S/N/C)',
  `reverso_referencia` varchar(20) DEFAULT NULL COMMENT 'Referencia para reversar',
  `dias_programacion` int(4) DEFAULT '0' COMMENT 'Días atras para la programación',
  `holgura_reprogramar` int(6) DEFAULT '0' COMMENT 'Holgura en segundos para reprogramar',
  `tipo_flujo` char(1) DEFAULT NULL COMMENT 'Tipo de flujo',
  PRIMARY KEY (`id`,`puerto_comm4`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 MIN_ROWS=1 MAX_ROWS=1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `tiempo`, `correo_cuenta`, `correo_puerto`, `correo_ssl`, `correo_clave`, `correo_host`, `flag_agregar`, `ejecutando_desde`, `ultima_falla`, `ultima_revision`, `revisar_cada`, `utilizar_arduino`, `puerto_comm1`, `puerto_comm1_par`, `puerto_comm2`, `puerto_comm2_par`, `puerto_comm3`, `puerto_comm3_par`, `puerto_comm4`, `puerto_comm4_par`, `puerto_comm5`, `puerto_comm5_par`, `puerto_comm6`, `puerto_comm6_par`, `ruta_sms`, `ruta_audios`, `optimizar_llamada`, `optimizar_sms`, `optimizar_correo`, `optimizar_mmcall`, `mantener_prioridad`, `voz_predeterminada`, `escape_mmcall`, `escape_mmcall_mensaje`, `escape_mmcall_lista`, `escape_mmcall_cancelar`, `escape_llamadas`, `escape_accion`, `escape_lista`, `escape_mensaje`, `escape_mensaje_propio`, `veces_reproducir`, `gestion_log`, `gestion_meses`, `correo_titulo_falla`, `correo_titulo`, `correo_cuerpo`, `correo_firma`, `timeout_llamadas`, `timeout_sms`, `traducir`, `tiempo_corte`, `ultimo_corte`, `bajo_hasta`, `bajo_color`, `bajo_etiqueta`, `medio_hasta`, `medio_color`, `medio_etiqueta`, `alto_color`, `alto_etiqueta`, `noatendio_color`, `noatendio_etiqueta`, `escaladas_color`, `escaladas_etiqueta`, `flag_monitor`, `ruta_archivos_enviar`, `server_mmcall`, `cad_consolidado`, `ruta_imagenes`, `tiempo_imagen`, `graficas_seleccion`, `graficas_duracion`, `timeout_fallas`, `avisar_segundos`, `color_aviso`, `contar_post`, `color_post`, `escaner_prefijo`, `escaner_sufijo`, `tiempo_holgura`, `tiempo_entre_lecturas`, `tiempo_escaner`, `largo_escaner`, `lote_inspeccion_clave`, `reverso_permitir`, `reverso_referencia`, `dias_programacion`, `holgura_reprogramar`, `tipo_flujo`) VALUES
(1, 1, 'elvismontezuma@hotmail.com', '587', 'S', 'Montezum@1974', 'smtp.live.com', 'N', '2019-09-05 11:37:44', 19365, '2019-06-19 22:04:46', 10, 'S', 'COM3', '19200,8,0,1,2,S', 'COM3', 'null', 'null', 'null', '', 'null', 'null', 'null', 'null', '', 'C:\\Users\\PC\\Documents\\vw monitor\\SMS', 'C:\\Users\\PC\\Documents\\vw monitor\\audios', 'S', 'S', 'N', 'S', 'S', 'DEFAULT', 'S', 'TODOS LOS REQUESTERS OCUPADOS', 0, 'S', 3, 'L', 12, 'SE GENERARON 3 LLAMADAS SIN CONTESTAR AL NUMERO ', 'S', 2, '201909', 12, 'S', 'Monitor de WIP v1.0', 'Este mensaje se envía desde una aplicación automática, por favor no lo responda ya que esta cuenta de correos no se revisa.', 'Gracias por su soporte!', 30, 10, 'S', NULL, '2019-07-12 16:54:53', 67, 'HEX09eb09', 'BAJO', 85, 'HEXfcea19', 'REGULAR', 'HEX09eb09', 'En tiempo', 'tomato', 'Abiertas', 'orange', 'Escaladas', 'S', 'C:\\Users\\PC\\Documents\\vw monitor\\enviar', 'http://localhost:8081', 'NAVE VW 102', 'C:\\Users\\lap\\Documents\\vw\\carrusel', 10, 'S;S;S;S;N;N', '2;2;2;2;2;2', 10, 300, 'tomato', 'S', 'red', '', '', 900, 25, 500, 0, 'S', 'S', 'REV1234', 15, 1800, 'J');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `control_listas`
--

CREATE TABLE IF NOT EXISTS `control_listas` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `lista` bigint(11) DEFAULT NULL COMMENT 'ID de la lista',
  `maestro` bigint(11) DEFAULT NULL COMMENT 'ID del maestro de listas',
  `cierre` datetime DEFAULT NULL COMMENT 'Fecha y hora de cierre',
  `usuario` bigint(11) DEFAULT NULL COMMENT 'ID del usuario',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Control de listas de verificacion' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `defectos`
--

CREATE TABLE IF NOT EXISTS `defectos` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `defecto` bigint(11) DEFAULT NULL COMMENT 'ID del defecto',
  `retrabajo` char(1) DEFAULT NULL COMMENT 'Se retrabajaron',
  `automatico` char(1) DEFAULT NULL COMMENT 'El defecto fue automático',
  `equipo` bigint(11) DEFAULT NULL COMMENT 'ID del equipo',
  `turno` bigint(11) DEFAULT NULL COMMENT 'ID del turno',
  `tripulacion` bigint(11) DEFAULT NULL COMMENT 'ID de la tripulación',
  `orden` bigint(11) DEFAULT NULL COMMENT 'ID de la orden de producción',
  `material` bigint(11) DEFAULT NULL COMMENT 'ID del material',
  `fecha` datetime DEFAULT NULL COMMENT 'Fecha de registro',
  `cantidad` decimal(17,7) DEFAULT NULL COMMENT 'Cantidad de piezas defectuosas',
  `comentarios` varchar(1000) DEFAULT NULL COMMENT 'Comentarios del sistema',
  `atendido` char(1) DEFAULT NULL COMMENT 'El paro fue atendido?',
  `clasificado_por` bigint(11) DEFAULT NULL COMMENT 'Usuario que clasificó el paro',
  `clasificado_fecha` datetime DEFAULT NULL COMMENT 'Fecha de la clasificación',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Defectos sucedidos' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `det_calendario`
--

CREATE TABLE IF NOT EXISTS `det_calendario` (
  `calendario` bigint(11) NOT NULL COMMENT 'ID del calendaro',
  `fecha` date NOT NULL COMMENT 'Fecha',
  `descripcion` varchar(100) DEFAULT NULL COMMENT 'Descripción',
  `imagen` varchar(100) DEFAULT NULL COMMENT 'Imagen',
  PRIMARY KEY (`calendario`,`fecha`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Detalle del calendario';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `det_correo`
--

CREATE TABLE IF NOT EXISTS `det_correo` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `correo` bigint(11) NOT NULL COMMENT 'ID del correo',
  `secuencia` int(4) NOT NULL COMMENT 'Línea en la lista',
  `reporte` bigint(8) DEFAULT NULL COMMENT 'ID del reporte',
  `lapso` int(2) DEFAULT NULL COMMENT 'Lapso a evaluar',
  `periodo` int(2) DEFAULT NULL COMMENT 'Tipo de período',
  `periodosatras` bigint(8) DEFAULT NULL COMMENT 'Número de períodos atrás',
  PRIMARY KEY (`id`,`correo`,`secuencia`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Detalle del correo (reportes)' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `det_correo_horario`
--

CREATE TABLE IF NOT EXISTS `det_correo_horario` (
  `correo` bigint(11) NOT NULL COMMENT 'ID del correo',
  `secuencia` int(4) NOT NULL COMMENT 'Línea en la lista',
  `semana` char(7) DEFAULT NULL COMMENT 'ID del reporte',
  `diames` varchar(100) DEFAULT NULL COMMENT 'Segundos atrás',
  `hora` varchar(50) DEFAULT NULL COMMENT 'Período',
  PRIMARY KEY (`correo`,`secuencia`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Horarios de envío';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `det_disponibilidad`
--

CREATE TABLE IF NOT EXISTS `det_disponibilidad` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `calendario` bigint(20) DEFAULT NULL COMMENT 'ID del calendario',
  `equipo` bigint(20) DEFAULT NULL COMMENT 'ID del equipo',
  `fecha` date DEFAULT NULL COMMENT 'Fecha especifica',
  `disponibilidad` bigint(5) DEFAULT NULL COMMENT 'Disponibilidad en segundos',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`calendario`,`equipo`,`fecha`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Disponibilidad por equipo y fecha' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `det_distribucion`
--

CREATE TABLE IF NOT EXISTS `det_distribucion` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `distribucion` bigint(11) NOT NULL COMMENT 'ID de la lista de distribución',
  `orden` int(4) NOT NULL COMMENT 'Línea en la lista',
  `tipo` int(2) DEFAULT NULL COMMENT 'Tipo de lista (0: Móvil-Llamada, 10: Móvil-SMS, 30: Móvil-LLamada y SMS, 40: Correo electrónico, 50: Ärea de MMCall)',
  `cadena` varchar(255) DEFAULT NULL COMMENT 'Cadena',
  `alias` varchar(30) DEFAULT NULL COMMENT 'Alias',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus',
  PRIMARY KEY (`id`,`distribucion`,`orden`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Detalle de la lista de distribucón' AUTO_INCREMENT=78 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `det_estacion`
--

CREATE TABLE IF NOT EXISTS `det_estacion` (
  `estacion` bigint(11) NOT NULL COMMENT 'ID de la estación',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `equipo` bigint(11) NOT NULL COMMENT 'ID del equipo',
  PRIMARY KEY (`estacion`,`equipo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Detalle de las estaciones';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `det_lista`
--

CREATE TABLE IF NOT EXISTS `det_lista` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `lista` bigint(11) NOT NULL COMMENT 'ID de la lista',
  `variable` bigint(11) NOT NULL COMMENT 'ID de la variable',
  `orden` int(4) DEFAULT NULL COMMENT 'Orden en la lista',
  `deorigen` char(1) DEFAULT NULL COMMENT 'Tomar los datos de origen',
  `requerido` char(1) DEFAULT NULL COMMENT 'Campo requerido',
  `notas` varchar(500) DEFAULT NULL COMMENT 'Notas de la variable',
  `tipo` int(2) DEFAULT NULL COMMENT 'Tipo de valor (10=numérico, 20=Si/NO, 30=Tabla)',
  `tabla` char(1) DEFAULT NULL COMMENT 'Tomar valor de una tabla',
  `idtabla` bigint(11) DEFAULT NULL COMMENT 'ID de la tabla',
  `unidad` bigint(11) DEFAULT NULL COMMENT 'ID de la unidad de medida',
  `permitido_min` decimal(30,10) DEFAULT NULL COMMENT 'Valor mínimo',
  `permitido_max` decimal(30,10) DEFAULT NULL COMMENT 'Valor máximo',
  `alarma_min` decimal(30,10) DEFAULT NULL COMMENT 'Valor mínimo para generar alarma',
  `alarma_max` decimal(30,10) DEFAULT NULL COMMENT 'Valor máximo para generar alarma',
  `alarma_supervision` char(1) DEFAULT NULL COMMENT 'Requiere supervisión',
  `alarma_regla` char(1) DEFAULT NULL COMMENT 'Requiere regla',
  `alarma_sino` char(1) DEFAULT NULL COMMENT 'Alarma Si/No',
  `color` varchar(20) DEFAULT NULL COMMENT 'Color de fondo',
  `resaltada` char(1) DEFAULT NULL COMMENT 'Resaltar variable',
  `mostrar_rango` char(1) DEFAULT NULL COMMENT 'Mostrar rango en pantalla',
  `confirmar_respuesta` char(1) DEFAULT NULL COMMENT 'Confirmar la respuesta',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha en que se agregó',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha en que se modificó',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Usuario que agregó',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Usuario que modificó',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`lista`,`variable`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Detalle de listas de verificación' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `det_procesos`
--

CREATE TABLE IF NOT EXISTS `det_procesos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `referencia` varchar(30) DEFAULT NULL COMMENT 'Referencia con el sistema',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `prefijo` varchar(30) DEFAULT NULL COMMENT 'Prefijo del registro',
  `notas` varchar(300) DEFAULT NULL COMMENT 'Notas varias',
  `capacidad` bigint(12) DEFAULT '0' COMMENT 'Tiempo general de un lote en stock (segundos)',
  `proceso` bigint(20) DEFAULT NULL COMMENT 'ID del proceso asociado',
  `programar` char(1) DEFAULT 'N' COMMENT 'Permitir la programación',
  `ultimo_parte` bigint(20) NOT NULL DEFAULT '0',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=46 ;

--
-- Volcado de datos para la tabla `det_procesos`
--

INSERT INTO `det_procesos` (`id`, `referencia`, `nombre`, `prefijo`, `notas`, `capacidad`, `proceso`, `programar`, `ultimo_parte`, `estatus`, `creacion`, `modificacion`, `creado`, `modificado`) VALUES
(1, 'OC1010', 'OC1', NULL, NULL, 1, 17, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(2, 'OC2020', 'OC2', NULL, NULL, 1, 17, 'N', 9, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(3, 'OC3030', 'OC3', NULL, NULL, 1, 17, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(4, 'OC4040', 'OC4', NULL, NULL, 1, 17, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(5, 'DURR1010', 'Dürr 1', NULL, NULL, 1, 13, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(6, 'DURR2020', 'Dürr 2', NULL, NULL, 1, 13, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(7, 'AFC010', 'AFC', NULL, NULL, 6, 23, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(8, 'NTX2020', 'Nitrex 2 (recocido)', NULL, NULL, 6, 23, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(9, 'NTX1010', 'Nitrex 1 (Nitrurado)', NULL, NULL, 6, 16, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(10, 'GG1010', 'GG1', NULL, NULL, 1, 24, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(11, 'GG2020', 'GG2', NULL, NULL, 1, 24, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(12, 'GG3030', 'GG3', NULL, NULL, 1, 24, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(13, 'GG4040', 'GG4', NULL, NULL, 1, 24, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(14, 'CG1010', 'CG', NULL, NULL, 1, 4, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(15, 'SB1010', 'SB', NULL, NULL, 1, 27, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(16, 'PK1010', 'PK1', NULL, NULL, 1, 18, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(17, 'PK2020', 'PK2', NULL, NULL, 1, 18, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(18, 'PVD1010', 'PVD1', NULL, '', 8, 20, 'S', 0, 'A', '2019-08-29 16:16:18', '2019-09-02 12:03:49', 1, 1),
(19, 'PVD2020', 'PVD2', NULL, '', 8, 20, 'S', 0, 'A', '2019-08-29 16:16:18', '2019-09-02 12:04:02', 1, 1),
(20, 'TPR1010', 'TPR', NULL, NULL, 1, 12, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(21, 'MN1010', 'MN', NULL, NULL, 1, 12, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(22, 'DK1010', 'DK1', NULL, NULL, 1, 25, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(23, 'DK2020', 'DK2', NULL, NULL, 1, 25, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(24, 'CON1010', 'CON1', NULL, NULL, 1, 2, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(25, 'CON2020', 'CON2', NULL, NULL, 1, 2, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(26, 'CON3030', 'CON3', NULL, NULL, 1, 2, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(27, 'CON4040', 'CON4', NULL, NULL, 1, 2, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(28, 'LC1010', 'LC', NULL, NULL, 2, 9, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(29, 'IM1010', 'IM', NULL, '', 3, 11, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-09-04 16:43:18', 1, 1),
(30, 'MSA21010', 'MSA2', NULL, NULL, 1, 14, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(31, 'MSA32020', 'MSA3', NULL, NULL, 1, 14, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(32, 'IF1010', 'IF', NULL, '', 4, 10, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-09-04 16:44:09', 1, 1),
(33, 'AE1010', 'AE', NULL, '', 2, 1, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-09-04 16:43:36', 1, 1),
(34, 'RC1010', 'RC', NULL, NULL, 1, 26, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(35, 'CTP1010', 'CTP', NULL, NULL, 1, 6, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(36, 'PTP1010', 'PTP', NULL, NULL, 1, 19, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(37, 'DCT1010', 'DCT', NULL, NULL, 1, 28, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(38, 'AIDA1010', 'AIDA', NULL, NULL, 1, 29, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(39, 'MSA1010', 'MSA1', NULL, NULL, 1, 15, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(40, 'LOSS1010', 'Löser 1', NULL, NULL, 1, 3, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(41, 'GI11010', 'GI1', NULL, NULL, 1, 8, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(42, 'COL11010', 'COL1', NULL, NULL, 1, 5, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(43, 'RI11010', 'RI1', NULL, NULL, 1, 21, 'N', 0, 'A', '2019-08-29 16:16:18', '2019-08-29 16:16:18', 1, 1),
(44, 'FOS11010', 'FOS1', NULL, '', 13, 7, 'N', 0, 'A', '2019-09-02 15:44:46', '2019-09-02 15:48:10', 1, 1),
(45, 'RFSO1010', 'Recibo de fos', NULL, '', 13, 22, 'N', 0, 'A', '2019-09-04 16:20:47', '2019-09-04 16:41:38', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `det_regla`
--

CREATE TABLE IF NOT EXISTS `det_regla` (
  `lista` bigint(11) DEFAULT NULL COMMENT 'ID de la lista',
  `variable` bigint(11) DEFAULT NULL COMMENT 'ID de la variable',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia en la pantalla',
  `periodo` int(2) DEFAULT NULL COMMENT 'período',
  `acumulado` int(4) DEFAULT NULL COMMENT 'Acumulado',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  KEY `NewIndex1` (`lista`),
  KEY `NewIndex2` (`variable`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Reglas de acumulación';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `det_rutas`
--

CREATE TABLE IF NOT EXISTS `det_rutas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `ruta` bigint(20) DEFAULT NULL COMMENT 'ID de la ruta',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia de la operación',
  `referencia` varchar(30) DEFAULT NULL COMMENT 'Referencia con el sistema',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `prefijo` varchar(30) DEFAULT NULL COMMENT 'Prefijo del registro',
  `notas` varchar(300) DEFAULT NULL COMMENT 'Notas varias',
  `tiempo_stock` bigint(12) DEFAULT '0' COMMENT 'Tiempo general de un lote en stock (segundos)',
  `tiempo_proceso` bigint(12) DEFAULT '0' COMMENT 'Tiempo general de un lote en proceso (segundos)',
  `tiempo_setup` bigint(12) DEFAULT '0' COMMENT 'Tiempo de preparación',
  `proceso` bigint(20) DEFAULT NULL COMMENT 'ID del proceso asociado',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`ruta`,`secuencia`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Detalle de rutas' AUTO_INCREMENT=502 ;

--
-- Volcado de datos para la tabla `det_rutas`
--

INSERT INTO `det_rutas` (`id`, `ruta`, `secuencia`, `referencia`, `nombre`, `prefijo`, `notas`, `tiempo_stock`, `tiempo_proceso`, `tiempo_setup`, `proceso`, `estatus`, `creacion`, `modificacion`, `creado`, `modificado`) VALUES
(1, 7, 1, '', 'Oval Coiling', NULL, '', 86400, 15950, 2700, 17, 'A', '2019-08-29 16:00:14', '2019-09-02 13:41:27', 1, 1),
(2, 7, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:41:34', 1, 1),
(3, 7, 3, 'PKK010', 'Pulido Knopp', NULL, '', 129600, 21600, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-09-02 13:41:52', 1, 1),
(4, 7, 4, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 8580, 1200, 24, 'A', '2019-08-29 16:00:14', '2019-09-02 13:42:24', 1, 1),
(5, 7, 5, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:42:32', 1, 1),
(6, 7, 6, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:14', '2019-09-02 13:42:41', 1, 1),
(7, 7, 7, '', 'Rectificado axial', NULL, '', 86400, 330, 900, 25, 'A', '2019-08-29 16:00:14', '2019-09-02 13:42:53', 1, 1),
(8, 7, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:43:12', 1, 1),
(9, 7, 9, '', 'Sanblasting', NULL, '', 86400, 4500, 600, 27, 'A', '2019-08-29 16:00:14', '2019-09-02 13:43:23', 1, 1),
(10, 7, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:43:30', 1, 1),
(11, 7, 11, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 2933, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(12, 7, 12, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:43:50', 1, 1),
(13, 7, 13, '', 'PVD', NULL, '', 129600, 46800, 14400, 20, 'A', '2019-08-29 16:00:14', '2019-09-02 13:44:02', 1, 1),
(14, 7, 14, NULL, 'Pulido Knopp 2', NULL, NULL, 86400, 2933, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(15, 7, 15, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:44:18', 1, 1),
(16, 7, 16, '', 'Rectificado del gap+ chaflan del gap ', NULL, '', 86400, 8580, 1200, 24, 'A', '2019-08-29 16:00:14', '2019-09-02 13:44:53', 1, 1),
(17, 7, 17, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:14', '2019-09-02 13:45:02', 1, 1),
(18, 7, 18, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:45:12', 1, 1),
(19, 7, 19, '', 'Lapeado', NULL, '', 86400, 5500, 1200, 12, 'A', '2019-08-29 16:00:14', '2019-09-02 13:45:25', 1, 1),
(20, 7, 20, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:45:45', 1, 1),
(21, 7, 21, '', 'Rectificado axial', NULL, '', 86400, 3300, 900, 25, 'A', '2019-08-29 16:00:14', '2019-09-02 13:46:13', 1, 1),
(22, 7, 22, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:46:22', 1, 1),
(23, 7, 23, '', 'Inspección 100% linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:14', '2019-09-02 13:47:04', 1, 1),
(24, 7, 24, '', 'Inspección muestral ', NULL, '', 86400, 2700, 900, 11, 'A', '2019-08-29 16:00:14', '2019-09-02 13:46:56', 1, 1),
(25, 7, 25, '', 'MSA', NULL, '', 86400, 13200, 1500, 14, 'A', '2019-08-29 16:00:14', '2019-09-02 13:47:28', 1, 1),
(26, 7, 26, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:14', '2019-09-02 13:47:38', 1, 1),
(27, 7, 27, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 1500, 1, 'A', '2019-08-29 16:00:14', '2019-09-02 13:47:45', 1, 1),
(28, 14, 1, '', 'Oval Coiling', NULL, '', 86400, 20405, 2700, 17, 'A', '2019-08-29 16:00:14', '2019-09-02 17:12:36', 1, 1),
(29, 14, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 17:12:42', 1, 1),
(31, 14, 4, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 10725, 1200, 24, 'A', '2019-08-29 16:00:14', '2019-09-02 17:12:47', 1, 1),
(32, 14, 5, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:14', '2019-09-02 17:17:50', 1, 1),
(33, 14, 6, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 17:17:55', 1, 1),
(34, 14, 7, '', 'Sanblasting', NULL, '', 86400, 4500, 600, 27, 'A', '2019-08-29 16:00:14', '2019-09-02 17:18:05', 1, 1),
(35, 14, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 17:18:14', 1, 1),
(36, 14, 9, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 2933, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(37, 14, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 17:18:30', 1, 1),
(38, 14, 11, '', 'PVD', NULL, '', 129600, 46800, 14400, 20, 'A', '2019-08-29 16:00:14', '2019-09-02 17:18:43', 1, 1),
(39, 14, 12, '', 'Pulido Knopp 2', NULL, '', 86400, 2933, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-09-02 17:18:54', 1, 1),
(40, 14, 13, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 17:19:02', 1, 1),
(41, 14, 14, '', 'Rectificado del gap+ chaflan del gap ', NULL, '', 86400, 10725, 1200, 24, 'A', '2019-08-29 16:00:14', '2019-09-02 17:19:11', 1, 1),
(42, 14, 15, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:14', '2019-09-02 17:19:20', 1, 1),
(43, 14, 16, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 17:19:29', 1, 1),
(44, 14, 17, '', 'Lapeado', NULL, '', 86400, 5500, 1200, 12, 'A', '2019-08-29 16:00:14', '2019-09-02 17:21:36', 1, 1),
(45, 14, 18, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 17:20:33', 1, 1),
(46, 14, 19, '', 'Rectificado axial', NULL, '', 86400, 3300, 900, 25, 'A', '2019-08-29 16:00:14', '2019-09-03 09:41:58', 1, 1),
(47, 14, 20, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 17:20:20', 1, 1),
(48, 14, 21, '', 'Inspección 100% linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:14', '2019-09-02 17:20:13', 1, 1),
(49, 14, 22, '', 'Inspección muestral ', NULL, '', 86400, 1620, 900, 11, 'A', '2019-08-29 16:00:14', '2019-09-02 17:20:00', 1, 1),
(50, 14, 23, '', 'MSA', NULL, '', 86400, 13200, 1500, 14, 'A', '2019-08-29 16:00:14', '2019-09-02 17:19:54', 1, 1),
(51, 14, 24, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:14', '2019-09-02 17:19:44', 1, 1),
(52, 14, 25, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:14', '2019-09-02 17:19:37', 1, 1),
(53, 2, 1, '', 'Oval Coiling', NULL, '', 86400, 16280, 2700, 17, 'A', '2019-08-29 16:00:14', '2019-09-02 13:48:02', 1, 1),
(54, 2, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:48:13', 1, 1),
(55, 2, 3, '', 'Nitrurado', NULL, '', 86400, 43200, 18000, 16, 'A', '2019-08-29 16:00:14', '2019-09-02 13:48:28', 1, 1),
(56, 2, 4, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:48:34', 1, 1),
(57, 2, 5, '', 'Rectificado Axial', NULL, '', 86400, 3300, 900, 25, 'A', '2019-08-29 16:00:14', '2019-09-03 09:34:15', 1, 1),
(58, 2, 6, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:49:01', 1, 1),
(59, 2, 7, '', 'Rectificado del gap+ chaflan del gap ', NULL, '', 86400, 10725, 1200, 24, 'A', '2019-08-29 16:00:14', '2019-09-02 13:49:16', 1, 1),
(60, 2, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:49:24', 1, 1),
(61, 2, 9, '', 'Rectificado del gap+ chaflan del gap ', NULL, '', 86400, 10725, 1200, 24, 'A', '2019-08-29 16:00:14', '2019-09-02 13:49:38', 1, 1),
(62, 2, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:50:21', 1, 1),
(63, 2, 11, '', 'Lapeado', NULL, '', 86400, 5500, 1200, 12, 'A', '2019-08-29 16:00:14', '2019-09-02 13:50:33', 1, 1),
(64, 2, 12, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:50:41', 1, 1),
(65, 2, 13, '', 'Cepillado axial ', NULL, '', 86400, 1800, 600, 3, 'A', '2019-08-29 16:00:14', '2019-09-02 13:51:05', 1, 1),
(66, 2, 14, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:51:15', 1, 1),
(67, 2, 15, '', 'Inspección muestral ', NULL, '', 86400, 2700, 900, 11, 'A', '2019-08-29 16:00:14', '2019-09-02 13:52:14', 1, 1),
(68, 2, 16, '', 'MSA', NULL, '', 86400, 13200, 1500, 14, 'A', '2019-08-29 16:00:14', '2019-09-02 13:52:34', 1, 1),
(69, 2, 17, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:14', '2019-09-02 13:52:41', 1, 1),
(70, 2, 18, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:14', '2019-09-02 13:52:53', 1, 1),
(71, 3, 1, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:53:11', 1, 1),
(72, 3, 2, '', 'Torneado CAM+ Corte del Gap', NULL, '', 86400, 11660, 3600, 28, 'A', '2019-08-29 16:00:14', '2019-09-02 13:53:23', 1, 1),
(73, 3, 3, '', 'Torneado perfil minuto ', NULL, '', 86400, 23540, 3600, 29, 'A', '2019-08-29 16:00:14', '2019-09-02 13:54:36', 1, 1),
(74, 3, 4, NULL, 'MSA 1 ', NULL, NULL, 86400, 13200, 1800, 15, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(75, 3, 5, '', 'Cepillado axial ', NULL, '', 86400, 1800, 600, 3, 'A', '2019-08-29 16:00:14', '2019-09-02 13:55:09', 1, 1),
(76, 3, 6, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:55:17', 1, 1),
(77, 3, 7, '', 'Lapeado', NULL, '', 86400, 5500, 1200, 12, 'A', '2019-08-29 16:00:14', '2019-09-02 13:55:29', 1, 1),
(78, 3, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:55:37', 1, 1),
(79, 3, 9, '', 'Inspección 100% Linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:14', '2019-09-02 13:55:57', 1, 1),
(80, 3, 10, '', 'Empaque para fosfato', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:14', '2019-09-02 13:56:15', 1, 1),
(81, 3, 11, NULL, 'Fosfato', NULL, NULL, 691200, 691200, 1800, 7, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(82, 3, 12, '', 'Recibo de fosfato', NULL, '', 172800, 3600, 7200, 22, 'A', '2019-08-29 16:00:14', '2019-09-04 12:05:22', 1, 1),
(83, 3, 13, '', 'Inspección muestral ', NULL, '', 86400, 2700, 900, 11, 'A', '2019-08-29 16:00:14', '2019-09-02 13:58:09', 1, 1),
(84, 3, 14, '', 'MSA', NULL, '', 86400, 13200, 1500, 14, 'A', '2019-08-29 16:00:14', '2019-09-02 13:58:18', 1, 1),
(85, 3, 15, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:14', '2019-09-02 13:58:26', 1, 1),
(86, 3, 16, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:14', '2019-09-02 13:58:34', 1, 1),
(87, 5, 1, '', 'Oval Coiling', NULL, '', 86400, 16775, 2700, 17, 'A', '2019-08-29 16:00:14', '2019-09-02 13:58:49', 1, 1),
(88, 5, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:58:55', 1, 1),
(89, 5, 3, '', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-08-29 16:00:14', '2019-09-02 13:59:05', 1, 1),
(90, 5, 4, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 10725, 1200, 24, 'A', '2019-08-29 16:00:14', '2019-09-02 13:59:11', 1, 1),
(91, 5, 5, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 13:59:18', 1, 1),
(92, 5, 6, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:14', '2019-09-02 13:59:46', 1, 1),
(93, 5, 7, '', 'Rectificado axial', NULL, '', 86400, 3300, 900, 25, 'A', '2019-08-29 16:00:14', '2019-09-03 09:34:47', 1, 1),
(94, 5, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 14:07:53', 1, 1),
(95, 5, 9, '', 'Sanblasting', NULL, '', 86400, 4500, 600, 27, 'A', '2019-08-29 16:00:14', '2019-09-02 14:08:18', 1, 1),
(96, 5, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 14:08:25', 1, 1),
(97, 5, 11, '', 'Lapeado', NULL, '', 86400, 8800, 1200, 12, 'A', '2019-08-29 16:00:14', '2019-09-02 14:08:37', 1, 1),
(98, 5, 12, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 14:08:43', 1, 1),
(99, 5, 13, '', 'Pulido Knopp 1', NULL, '', 86400, 2933, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-09-02 14:09:04', 1, 1),
(100, 5, 14, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 14:09:17', 1, 1),
(101, 5, 15, '', 'PVD', NULL, '', 129600, 46800, 14400, 20, 'A', '2019-08-29 16:00:14', '2019-09-02 14:09:36', 1, 1),
(102, 5, 16, NULL, 'Pulido Knopp 2', NULL, NULL, 86400, 2933, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(103, 5, 17, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 14:10:14', 1, 1),
(104, 5, 18, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 10725, 1200, 24, 'A', '2019-08-29 16:00:14', '2019-09-02 14:10:24', 1, 1),
(105, 5, 19, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 14:10:39', 1, 1),
(106, 5, 20, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:14', '2019-09-02 14:10:49', 1, 1),
(107, 5, 21, '', 'Rectificado axial', NULL, '', 86400, 3300, 900, 25, 'A', '2019-08-29 16:00:14', '2019-09-03 09:34:57', 1, 1),
(108, 5, 22, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 14:11:39', 1, 1),
(109, 5, 23, '', 'Cepillado axial ', NULL, '', 86400, 150, 1500, 3, 'A', '2019-08-29 16:00:14', '2019-09-02 15:27:02', 1, 1),
(110, 5, 24, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 14:13:37', 1, 1),
(111, 5, 25, '', 'Lapeado', NULL, '', 86400, 5500, 1200, 12, 'A', '2019-08-29 16:00:14', '2019-09-02 14:13:17', 1, 1),
(112, 5, 26, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 14:13:27', 1, 1),
(113, 5, 27, '', 'Inspección 100% Linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:14', '2019-09-02 14:13:08', 1, 1),
(114, 5, 28, '', 'Inspección muestral ', NULL, '', 86400, 1620, 900, 11, 'A', '2019-08-29 16:00:14', '2019-09-02 14:12:59', 1, 1),
(115, 5, 29, '', 'Gap Inspection', NULL, '', 86400, 13200, 1800, 8, 'A', '2019-08-29 16:00:14', '2019-09-02 14:12:49', 1, 1),
(116, 5, 30, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:14', '2019-09-02 14:12:21', 1, 1),
(117, 5, 31, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:14', '2019-09-02 14:12:09', 1, 1),
(118, 4, 1, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 15:31:18', 1, 1),
(119, 4, 2, '', 'Torneado CAM+ Corte del Gap', NULL, '', 86400, 11702, 3600, 28, 'A', '2019-08-29 16:00:14', '2019-09-02 15:31:27', 1, 1),
(120, 4, 3, '', 'Torneado perfil minuto ', NULL, '', 86400, 23571, 3600, 29, 'A', '2019-08-29 16:00:14', '2019-09-02 15:31:38', 1, 1),
(121, 4, 4, NULL, 'MSA 1 ', NULL, NULL, 86400, 13200, 1800, 15, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(122, 4, 5, NULL, 'Cepillado axial ', NULL, NULL, 86400, 0, 1800, 3, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(123, 4, 6, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 15:31:53', 1, 1),
(124, 4, 7, '', 'Lapeado', NULL, '', 86400, 5500, 1200, 12, 'A', '2019-08-29 16:00:14', '2019-09-02 15:33:06', 1, 1),
(125, 4, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 15:33:14', 1, 1),
(126, 4, 9, '', 'Rectificado axial', NULL, '', 86400, 3300, 900, 25, 'A', '2019-08-29 16:00:14', '2019-09-03 09:35:13', 1, 1),
(127, 4, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 15:33:41', 1, 1),
(128, 4, 11, '', 'Inspección 100% Linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:14', '2019-09-02 15:34:02', 1, 1),
(129, 4, 12, '', 'Empaque para fosfato', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:14', '2019-09-02 15:34:20', 1, 1),
(130, 4, 13, NULL, 'Fosfato', NULL, NULL, 691200, 691200, 1800, 7, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(131, 4, 14, '', 'Recibo de fosfato', NULL, '', 172800, 3600, 1800, 22, 'A', '2019-08-29 16:00:14', '2019-09-04 12:05:57', 1, 1),
(132, 4, 15, '', 'Inspección muestral ', NULL, '', 86400, 3600, 900, 11, 'A', '2019-08-29 16:00:14', '2019-09-02 15:52:09', 1, 1),
(133, 4, 16, '', 'MSA', NULL, '', 86400, 13200, 1500, 14, 'A', '2019-08-29 16:00:14', '2019-09-02 15:53:25', 1, 1),
(134, 4, 17, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:14', '2019-09-02 15:53:32', 1, 1),
(135, 4, 18, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:14', '2019-09-02 15:53:38', 1, 1),
(136, 13, 1, '', 'Oval Coiling', NULL, '', 86400, 17490, 2700, 17, 'A', '2019-08-29 16:00:14', '2019-09-02 16:21:27', 1, 1),
(137, 13, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:21:34', 1, 1),
(138, 13, 3, '', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-08-29 16:00:14', '2019-09-02 16:24:20', 1, 1),
(139, 13, 4, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 8580, 1200, 24, 'A', '2019-08-29 16:00:14', '2019-09-02 16:24:43', 1, 1),
(140, 13, 5, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:24:50', 1, 1),
(141, 13, 6, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:14', '2019-09-02 16:24:56', 1, 1),
(142, 13, 7, '', 'Sanblasting', NULL, '', 86400, 4500, 600, 27, 'A', '2019-08-29 16:00:14', '2019-09-02 16:26:20', 1, 1),
(143, 13, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:26:27', 1, 1),
(144, 13, 9, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 2933, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(145, 13, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:26:44', 1, 1),
(146, 13, 11, '', 'PVD', NULL, '', 129600, 46800, 14400, 20, 'A', '2019-08-29 16:00:14', '2019-09-02 16:26:52', 1, 1),
(147, 13, 12, NULL, 'Pulido Knopp 2', NULL, NULL, 86400, 2933, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(148, 13, 13, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:27:05', 1, 1),
(149, 13, 14, '', 'Rectificado del gap+ chaflan del gap ', NULL, '', 86400, 8580, 1200, 24, 'A', '2019-08-29 16:00:14', '2019-09-02 16:27:15', 1, 1),
(150, 13, 15, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:27:23', 1, 1),
(151, 13, 16, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:14', '2019-09-02 16:27:35', 1, 1),
(152, 13, 17, '', 'Lapeado', NULL, '', 86400, 5500, 1200, 12, 'A', '2019-08-29 16:00:14', '2019-09-02 16:28:39', 1, 1),
(153, 13, 18, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:28:28', 1, 1),
(154, 13, 19, '', 'Rectificado axial', NULL, '', 86400, 3300, 900, 25, 'A', '2019-08-29 16:00:14', '2019-09-03 09:36:14', 1, 1),
(155, 13, 20, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:29:15', 1, 1),
(156, 13, 21, '', 'Acuñado', NULL, '', 86400, 24200, 2100, 2, 'A', '2019-08-29 16:00:14', '2019-09-02 16:29:40', 1, 1),
(157, 13, 22, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:29:48', 1, 1),
(158, 13, 23, '', 'Inspección 100% linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:14', '2019-09-02 16:29:59', 1, 1),
(159, 13, 24, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:30:09', 1, 1),
(160, 13, 25, '', 'Inspección muestral ', NULL, '', 86400, 3600, 900, 11, 'A', '2019-08-29 16:00:14', '2019-09-02 16:32:40', 1, 1),
(161, 13, 26, '', 'MSA', NULL, '', 86400, 13200, 1500, 14, 'A', '2019-08-29 16:00:14', '2019-09-02 16:32:57', 1, 1),
(162, 13, 27, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:14', '2019-09-02 16:35:15', 1, 1),
(163, 13, 28, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:14', '2019-09-02 16:35:23', 1, 1),
(164, 11, 1, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:16:09', 1, 1),
(165, 11, 2, '', 'Torneado CAM+ Corte del Gap', NULL, '', 86400, 12872, 3600, 28, 'A', '2019-08-29 16:00:14', '2019-09-02 16:16:23', 1, 1),
(166, 11, 3, '', 'Torneado perfil minuto ', NULL, '', 86400, 26714, 3600, 29, 'A', '2019-08-29 16:00:14', '2019-09-02 16:16:34', 1, 1),
(167, 11, 4, NULL, 'MSA 1 ', NULL, NULL, 86400, 13200, 1800, 15, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(168, 11, 5, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:14', '2019-09-02 16:16:49', 1, 1),
(169, 11, 6, '', 'Lapeado', NULL, '', 86400, 5500, 1200, 12, 'A', '2019-08-29 16:00:14', '2019-09-02 16:16:56', 1, 1),
(170, 11, 7, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:17:01', 1, 1),
(171, 11, 8, '', 'Inspección 100% Linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:14', '2019-09-02 16:17:11', 1, 1),
(172, 11, 9, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 2933, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(173, 11, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:17:31', 1, 1),
(174, 11, 11, '', 'PVD', NULL, '', 129600, 46800, 14400, 20, 'A', '2019-08-29 16:00:14', '2019-09-02 16:18:07', 1, 1),
(175, 11, 12, NULL, 'Pulido Knopp 2', NULL, NULL, 86400, 2933, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(176, 11, 13, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:18:21', 1, 1),
(177, 11, 14, '', 'Rectificado Axial', NULL, '', 86400, 3300, 900, 25, 'A', '2019-08-29 16:00:14', '2019-09-03 09:35:45', 1, 1),
(178, 11, 15, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:18:46', 1, 1),
(179, 11, 16, '', 'Inspección Final', NULL, '', 86400, 3600, 600, 10, 'A', '2019-08-29 16:00:14', '2019-09-02 16:19:07', 1, 1),
(180, 11, 17, '', 'Cepillado axial ', NULL, '', 86400, 150, 1200, 3, 'A', '2019-08-29 16:00:14', '2019-09-02 16:19:50', 1, 1),
(181, 11, 18, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:20:12', 1, 1),
(182, 11, 19, '', 'Inspección muestral ', NULL, '', 86400, 3600, 900, 11, 'A', '2019-08-29 16:00:14', '2019-09-02 16:20:28', 1, 1),
(183, 11, 20, '', 'MSA', NULL, '', 86400, 13200, 1500, 14, 'A', '2019-08-29 16:00:14', '2019-09-02 16:20:36', 1, 1),
(184, 11, 21, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:14', '2019-09-02 16:20:45', 1, 1),
(185, 11, 22, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:14', '2019-09-02 16:20:56', 1, 1),
(186, 10, 1, '', 'Round Coiling', NULL, '', 86400, 5148, 2100, 26, 'A', '2019-08-29 16:00:14', '2019-09-02 16:02:27', 1, 1),
(187, 10, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:05:27', 1, 1),
(188, 10, 3, '', 'Nitrurado', NULL, '', 86400, 36000, 18000, 16, 'A', '2019-08-29 16:00:14', '2019-09-02 16:23:21', 1, 1),
(189, 10, 4, NULL, 'Lavadora Dürr 1/2', NULL, NULL, 1800, 900, 1800, 13, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(190, 10, 5, '', 'Pulido TP', NULL, '', 86400, 7200, 1200, 19, 'A', '2019-08-29 16:00:14', '2019-09-02 16:11:01', 1, 1),
(191, 10, 6, NULL, 'Lavadora Dürr 1/2', NULL, NULL, 1800, 900, 1800, 13, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(192, 10, 7, '', 'PVD', NULL, '', 86400, 46800, 14400, 20, 'A', '2019-08-29 16:00:14', '2019-09-02 16:11:41', 1, 1),
(193, 10, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:11:51', 1, 1),
(194, 10, 9, '', 'Corte TP', NULL, '', 86400, 10313, 1200, 6, 'A', '2019-08-29 16:00:14', '2019-09-02 16:12:04', 1, 1),
(195, 10, 10, '', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-08-29 16:00:14', '2019-09-02 16:23:33', 1, 1),
(196, 10, 11, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 7333, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(197, 10, 12, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 16:13:35', 1, 1),
(198, 10, 13, '', 'Inspección muestral ', NULL, '', 86400, 3600, 900, 11, 'A', '2019-08-29 16:00:14', '2019-09-02 16:13:47', 1, 1),
(199, 10, 14, '', 'Rail inspection', NULL, '', 86400, 11000, 2400, 21, 'A', '2019-08-29 16:00:14', '2019-09-02 16:14:24', 1, 1),
(200, 10, 15, '', 'Inspección Final', NULL, '', 86400, 7200, 600, 10, 'A', '2019-08-29 16:00:14', '2019-09-02 16:15:05', 1, 1),
(201, 10, 16, '', 'Coloring', NULL, '', 86400, 2700, 1200, 5, 'A', '2019-08-29 16:00:14', '2019-09-02 16:15:18', 1, 1),
(202, 10, 17, '', 'Aceitado y empaque', NULL, '', 86400, 5400, 900, 1, 'A', '2019-08-29 16:00:14', '2019-09-02 16:15:41', 1, 1),
(203, 17, 1, '', 'Round Coiling', NULL, '', 86400, 4478, 2100, 26, 'A', '2019-08-29 16:00:14', '2019-09-02 17:06:57', 1, 1),
(204, 17, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 17:07:02', 1, 1),
(205, 17, 3, '', 'Nitrurado', NULL, '', 86400, 36000, 18000, 16, 'A', '2019-08-29 16:00:14', '2019-09-02 17:07:10', 1, 1),
(206, 17, 4, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 17:07:15', 1, 1),
(207, 17, 5, '', 'Pulido TP', NULL, '', 86400, 7200, 1200, 19, 'A', '2019-08-29 16:00:14', '2019-09-02 17:07:27', 1, 1),
(208, 17, 6, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 17:07:33', 1, 1),
(209, 17, 7, '', 'PVD', NULL, '', 86400, 46800, 14400, 20, 'A', '2019-08-29 16:00:14', '2019-09-02 17:07:39', 1, 1),
(210, 17, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 17:07:45', 1, 1),
(211, 17, 9, '', 'Corte TP', NULL, '', 86400, 8967, 1200, 6, 'A', '2019-08-29 16:00:14', '2019-09-02 17:07:51', 1, 1),
(212, 17, 10, '', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-08-29 16:00:14', '2019-09-02 17:07:59', 1, 1),
(213, 17, 11, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 6336, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(214, 17, 12, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 17:08:10', 1, 1),
(215, 17, 13, '', 'Inspección muestral ', NULL, '', 86400, 3600, 900, 11, 'A', '2019-08-29 16:00:14', '2019-09-02 17:08:19', 1, 1),
(216, 17, 14, '', 'Rail inspection', NULL, '', 86400, 11000, 2400, 21, 'A', '2019-08-29 16:00:14', '2019-09-02 17:08:27', 1, 1),
(217, 17, 15, '', 'Inspección Final', NULL, '', 86400, 7200, 600, 10, 'A', '2019-08-29 16:00:14', '2019-09-02 17:08:34', 1, 1),
(218, 17, 16, '', 'Coloring', NULL, '', 86400, 2700, 1200, 5, 'A', '2019-08-29 16:00:14', '2019-09-02 17:08:40', 1, 1),
(219, 17, 17, '', 'Aceitado y empaque', NULL, '', 86400, 5400, 900, 1, 'A', '2019-08-29 16:00:14', '2019-09-02 17:08:46', 1, 1),
(220, 12, 1, '', 'Oval Coiling', NULL, '', 86400, 13200, 2700, 17, 'A', '2019-08-29 16:00:14', '2019-08-30 16:23:11', 1, 1),
(221, 12, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-08-30 17:44:48', 1, 1),
(222, 12, 3, '', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-08-29 16:00:14', '2019-08-30 17:46:17', 1, 1),
(223, 12, 4, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 5148, 1200, 24, 'A', '2019-08-29 16:00:14', '2019-09-02 10:59:25', 1, 1),
(224, 12, 5, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 09:48:46', 1, 1),
(225, 12, 6, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:14', '2019-09-02 09:49:05', 1, 1),
(226, 12, 7, '', 'Sanblasting', NULL, '', 86400, 4500, 600, 27, 'A', '2019-08-29 16:00:14', '2019-09-02 09:50:53', 1, 1),
(227, 12, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 09:51:04', 1, 1),
(228, 12, 9, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 1759, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(229, 12, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 09:51:32', 1, 1),
(230, 12, 11, '', 'PVD', NULL, '', 129600, 46800, 14400, 20, 'A', '2019-08-29 16:00:14', '2019-09-02 10:00:51', 1, 1),
(231, 12, 12, NULL, 'Pulido Knopp 2', NULL, NULL, 86400, 1759, 1800, 18, 'A', '2019-08-29 16:00:14', '2019-08-29 16:00:14', 1, 1),
(232, 12, 13, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 10:01:31', 1, 1),
(233, 12, 14, '', 'Rectificado del gap+ chaflan del gap ', NULL, '', 86400, 5148, 1200, 24, 'A', '2019-08-29 16:00:14', '2019-09-02 11:00:08', 1, 1),
(234, 12, 15, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:14', '2019-09-02 10:01:43', 1, 1),
(235, 12, 16, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-02 10:02:12', 1, 1),
(236, 12, 17, '', 'Lapeado', NULL, '', 86400, 3300, 1200, 12, 'A', '2019-08-29 16:00:15', '2019-09-02 11:00:18', 1, 1),
(237, 12, 18, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 10:01:57', 1, 1),
(238, 12, 19, '', 'Rectificado axial', NULL, '', 86400, 1980, 900, 25, 'A', '2019-08-29 16:00:15', '2019-09-03 09:33:35', 1, 1),
(239, 12, 20, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 10:02:52', 1, 1),
(240, 12, 21, '', 'Acuñado', NULL, '', 86400, 14520, 2100, 2, 'A', '2019-08-29 16:00:15', '2019-09-02 13:39:32', 1, 1),
(241, 12, 22, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 10:03:15', 1, 1),
(242, 12, 23, NULL, 'Inspección 100% Linea de contacto', NULL, NULL, 86400, 3600, 1800, 9, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(243, 12, 24, NULL, 'Lavadora Dürr 1/2', NULL, NULL, 1800, 900, 1800, 13, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(244, 12, 25, '', 'Inspección muestral ', NULL, '', 86400, 3600, 600, 11, 'A', '2019-08-29 16:00:15', '2019-09-02 10:27:49', 1, 1),
(245, 12, 26, '', 'MSA', NULL, '', 86400, 7920, 1500, 14, 'A', '2019-08-29 16:00:15', '2019-09-02 11:00:28', 1, 1),
(246, 12, 27, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:15', '2019-09-02 10:27:32', 1, 1),
(247, 12, 28, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:15', '2019-09-02 10:27:22', 1, 1),
(248, 8, 1, '', 'Oval Coiling', NULL, '', 86400, 12705, 2700, 17, 'A', '2019-08-29 16:00:15', '2019-09-03 09:37:51', 1, 1),
(249, 8, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-03 09:37:57', 1, 1),
(250, 8, 3, '', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-08-29 16:00:15', '2019-09-03 09:38:02', 1, 1),
(251, 8, 4, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 5148, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-03 09:38:09', 1, 1),
(252, 8, 5, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-03 09:38:14', 1, 1),
(253, 8, 6, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-03 09:38:19', 1, 1),
(254, 8, 7, '', 'Sanblasting', NULL, '', 86400, 4500, 600, 27, 'A', '2019-08-29 16:00:15', '2019-09-03 09:38:27', 1, 1),
(255, 8, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-03 09:38:33', 1, 1),
(256, 8, 9, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 1759, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(257, 8, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-03 09:38:45', 1, 1),
(258, 8, 11, '', 'PVD', NULL, '', 129600, 46800, 14400, 20, 'A', '2019-08-29 16:00:15', '2019-09-03 09:38:55', 1, 1),
(259, 8, 12, NULL, 'Pulido Knopp 2', NULL, NULL, 86400, 1759, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(260, 8, 13, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-03 09:39:09', 1, 1),
(261, 8, 14, '', 'Rectificado del gap+ chaflan del gap ', NULL, '', 86400, 5148, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-03 09:39:18', 1, 1),
(262, 8, 15, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-03 09:39:26', 1, 1),
(263, 8, 16, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-03 09:39:34', 1, 1),
(264, 8, 17, '', 'Lapeado', NULL, '', 86400, 3300, 1200, 12, 'A', '2019-08-29 16:00:15', '2019-09-03 09:39:43', 1, 1),
(265, 8, 18, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-03 09:39:52', 1, 1),
(266, 8, 19, '', 'Rectificado axial', NULL, '', 86400, 1980, 900, 25, 'A', '2019-08-29 16:00:15', '2019-09-03 09:40:07', 1, 1),
(267, 8, 20, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-03 09:41:23', 1, 1),
(268, 8, 21, '', 'Acuñado', NULL, '', 86400, 14520, 2100, 2, 'A', '2019-08-29 16:00:15', '2019-09-03 09:41:13', 1, 1),
(269, 8, 22, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-03 09:41:01', 1, 1),
(270, 8, 23, '', 'Inspección 100% Linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:15', '2019-09-03 09:40:54', 1, 1),
(271, 8, 24, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-03 09:40:48', 1, 1),
(272, 8, 25, '', 'Inspección muestral ', NULL, '', 86400, 3600, 900, 11, 'A', '2019-08-29 16:00:15', '2019-09-03 09:40:39', 1, 1),
(273, 8, 26, '', 'MSA', NULL, '', 86400, 7920, 1500, 14, 'A', '2019-08-29 16:00:15', '2019-09-03 09:40:30', 1, 1),
(274, 8, 27, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:15', '2019-09-03 09:40:23', 1, 1),
(275, 8, 28, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:15', '2019-09-03 09:40:16', 1, 1),
(276, 19, 1, '', 'Oval Coiling', NULL, '', 86400, 12705, 2700, 17, 'A', '2019-08-29 16:00:15', '2019-08-30 16:22:53', 1, 1),
(277, 19, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-08-30 16:35:50', 1, 1),
(278, 19, 3, '', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-08-29 16:00:15', '2019-08-30 16:48:10', 1, 1),
(279, 19, 4, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 5148, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-02 10:58:12', 1, 1),
(280, 19, 5, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-08-30 16:36:36', 1, 1),
(281, 19, 6, 'CGG010', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-08-30 16:50:53', 1, 1),
(282, 19, 7, '', 'Sanblasting', NULL, '', 86400, 4500, 600, 27, 'A', '2019-08-29 16:00:15', '2019-08-30 16:43:46', 1, 1),
(283, 19, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-08-30 16:44:48', 1, 1),
(284, 19, 9, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 1759, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(285, 19, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-08-30 16:48:47', 1, 1),
(286, 19, 11, '', 'PVD', NULL, '', 129600, 46800, 14400, 20, 'A', '2019-08-29 16:00:15', '2019-09-02 10:01:04', 1, 1),
(287, 19, 12, NULL, 'Pulido Knopp 2', NULL, NULL, 86400, 1759, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(288, 19, 13, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-08-30 16:49:41', 1, 1),
(289, 19, 14, '', 'Rectificado del gap+ chaflan del gap ', NULL, '', 86400, 5148, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-02 10:51:59', 1, 1),
(290, 19, 15, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-08-30 16:50:02', 1, 1),
(291, 19, 16, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-08-30 16:51:19', 1, 1),
(292, 19, 17, '', 'Lapeado', NULL, '', 86400, 3300, 1200, 12, 'A', '2019-08-29 16:00:15', '2019-09-02 10:52:13', 1, 1),
(293, 19, 18, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 600, 13, 'A', '2019-08-29 16:00:15', '2019-08-30 16:51:38', 1, 1),
(294, 19, 19, '', 'Rectificado axial', NULL, '', 86400, 1980, 900, 25, 'A', '2019-08-29 16:00:15', '2019-09-02 10:52:54', 1, 1),
(295, 19, 20, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-08-30 16:54:08', 1, 1),
(296, 19, 21, '', 'Acuñado', NULL, '', 86400, 14520, 2100, 2, 'A', '2019-08-29 16:00:15', '2019-09-02 13:38:43', 1, 1),
(297, 19, 22, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-08-30 16:57:34', 1, 1),
(298, 19, 23, NULL, 'Inspección 100% Linea de contacto', NULL, NULL, 86400, 3600, 1800, 9, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(299, 19, 24, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 10:29:29', 1, 1),
(300, 19, 25, '', 'Inspección muestral ', NULL, '', 86400, 3600, 900, 11, 'A', '2019-08-29 16:00:15', '2019-09-02 10:29:04', 1, 1),
(301, 19, 26, '', 'MSA', NULL, '', 86400, 7920, 1500, 14, 'A', '2019-08-29 16:00:15', '2019-09-02 10:53:12', 1, 1),
(302, 19, 27, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:15', '2019-08-30 17:03:21', 1, 1),
(303, 19, 28, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:15', '2019-08-30 17:00:47', 1, 1),
(304, 20, 1, '', 'Oval Coiling', NULL, '', 86400, 13200, 2700, 17, 'A', '2019-08-29 16:00:15', '2019-08-30 16:24:49', 1, 1),
(305, 20, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 10:30:14', 1, 1),
(306, 20, 3, '', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-08-29 16:00:15', '2019-09-02 10:30:24', 1, 1),
(307, 20, 4, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 5148, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-02 11:02:34', 1, 1),
(308, 20, 5, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 10:30:35', 1, 1),
(309, 20, 6, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-02 10:30:44', 1, 1),
(310, 20, 7, '', 'Sanblasting', NULL, '', 86400, 4500, 600, 27, 'A', '2019-08-29 16:00:15', '2019-09-02 10:30:55', 1, 1),
(311, 20, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 10:31:04', 1, 1),
(312, 20, 9, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 1759, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(313, 20, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 10:31:14', 1, 1),
(314, 20, 11, '', 'PVD', NULL, '', 129600, 46800, 14400, 20, 'A', '2019-08-29 16:00:15', '2019-09-02 10:31:29', 1, 1),
(315, 20, 12, NULL, 'Pulido Knopp 2', NULL, NULL, 86400, 1759, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(316, 20, 13, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 10:31:57', 1, 1),
(317, 20, 14, '', 'Rectificado del gap+ chaflan del gap ', NULL, '', 86400, 5148, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-02 11:02:52', 1, 1),
(318, 20, 15, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 10:32:18', 1, 1),
(319, 20, 16, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-02 10:32:44', 1, 1),
(320, 20, 17, '', 'Lapeado', NULL, '', 86400, 3300, 1200, 12, 'A', '2019-08-29 16:00:15', '2019-09-02 11:03:03', 1, 1),
(321, 20, 18, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 10:32:59', 1, 1),
(322, 20, 19, '', 'Rectificado axial', NULL, '', 86400, 1980, 900, 25, 'A', '2019-08-29 16:00:15', '2019-09-03 09:33:46', 1, 1),
(323, 20, 20, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 11:06:20', 1, 1),
(324, 20, 21, '', 'Acuñado', NULL, '', 86400, 14520, 2100, 2, 'A', '2019-08-29 16:00:15', '2019-09-02 13:39:59', 1, 1),
(325, 20, 22, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 11:06:08', 1, 1),
(326, 20, 23, '', 'Inspección 100% Linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:15', '2019-09-02 11:03:53', 1, 1),
(327, 20, 24, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 11:05:36', 1, 1),
(328, 20, 25, '', 'Inspección muestral ', NULL, '', 86400, 3600, 900, 11, 'A', '2019-08-29 16:00:15', '2019-09-02 11:05:46', 1, 1),
(329, 20, 26, '', 'MSA', NULL, '', 86400, 7920, 1500, 14, 'A', '2019-08-29 16:00:15', '2019-09-02 11:05:59', 1, 1),
(330, 20, 27, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:15', '2019-09-02 11:04:03', 1, 1),
(331, 20, 28, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:15', '2019-09-02 11:04:11', 1, 1),
(332, 21, 1, '', 'Oval Coiling', NULL, '', 86400, 16104, 2700, 17, 'A', '2019-08-29 16:00:15', '2019-09-02 17:22:56', 1, 1),
(333, 21, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:23:02', 1, 1),
(334, 21, 3, '', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-08-29 16:00:15', '2019-09-02 17:23:07', 1, 1),
(335, 21, 4, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 6864, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-02 17:23:12', 1, 1),
(336, 21, 5, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:23:17', 1, 1),
(337, 21, 6, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-02 17:25:04', 1, 1),
(338, 21, 7, '', 'Sanblasting', NULL, '', 86400, 4500, 600, 27, 'A', '2019-08-29 16:00:15', '2019-09-02 17:25:11', 1, 1),
(339, 21, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:25:17', 1, 1),
(340, 21, 9, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 2345, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(341, 21, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:25:27', 1, 1),
(342, 21, 11, '', 'PVD', NULL, '', 129600, 46800, 14400, 20, 'A', '2019-08-29 16:00:15', '2019-09-02 17:25:36', 1, 1),
(343, 21, 12, NULL, 'Pulido Knopp 2', NULL, NULL, 86400, 2345, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(344, 21, 13, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:25:50', 1, 1),
(345, 21, 14, '', 'Rectificado del gap+ chaflan del gap ', NULL, '', 86400, 6864, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-02 17:26:07', 1, 1),
(346, 21, 15, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:26:14', 1, 1),
(347, 21, 16, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-02 17:26:21', 1, 1),
(348, 21, 17, NULL, 'Lapeado', NULL, NULL, 86400, 4400, 1800, 12, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(349, 21, 18, NULL, 'Lavadora Dürr 1/2', NULL, NULL, 1800, 900, 1800, 13, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(350, 21, 19, '', 'Rectificado axial', NULL, '', 86400, 2640, 900, 25, 'A', '2019-08-29 16:00:15', '2019-09-02 17:28:46', 1, 1),
(351, 21, 20, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:27:26', 1, 1),
(352, 21, 21, '', 'Acuñado', NULL, '', 86400, 19360, 2100, 2, 'A', '2019-08-29 16:00:15', '2019-09-02 17:27:18', 1, 1),
(353, 21, 22, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:27:06', 1, 1),
(354, 21, 23, '', 'Inspección 100% Linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:15', '2019-09-02 17:26:58', 1, 1),
(355, 21, 24, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:26:52', 1, 1),
(356, 21, 25, '', 'Inspección muestral ', NULL, '', 86400, 3600, 900, 11, 'A', '2019-08-29 16:00:15', '2019-09-02 17:26:44', 1, 1),
(357, 21, 26, '', 'MSA', NULL, '', 86400, 10560, 1500, 14, 'A', '2019-08-29 16:00:15', '2019-09-02 17:26:39', 1, 1),
(358, 21, 27, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:15', '2019-09-02 17:26:32', 1, 1),
(359, 21, 28, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:15', '2019-09-02 17:26:27', 1, 1),
(360, 9, 1, '', 'Oval Coiling', NULL, '', 86400, 16104, 2700, 17, 'A', '2019-08-29 16:00:15', '2019-09-02 17:09:01', 1, 1),
(361, 9, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:09:11', 1, 1),
(362, 9, 3, '', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-08-29 16:00:15', '2019-09-02 17:09:18', 1, 1),
(363, 9, 4, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 6864, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-02 17:09:24', 1, 1),
(364, 9, 5, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:09:29', 1, 1),
(365, 9, 6, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-02 17:09:37', 1, 1),
(366, 9, 7, '', 'Sanblasting', NULL, '', 86400, 4500, 600, 27, 'A', '2019-08-29 16:00:15', '2019-09-02 17:09:44', 1, 1),
(367, 9, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:09:51', 1, 1),
(368, 9, 9, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 2345, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(369, 9, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:10:01', 1, 1),
(370, 9, 11, '', 'PVD', NULL, '', 129600, 46800, 14400, 20, 'A', '2019-08-29 16:00:15', '2019-09-02 17:10:09', 1, 1),
(371, 9, 12, NULL, 'Pulido Knopp 2', NULL, NULL, 86400, 2345, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(372, 9, 13, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:10:19', 1, 1),
(373, 9, 14, '', 'Rectificado del gap+ chaflan del gap ', NULL, '', 86400, 6864, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-02 17:10:27', 1, 1),
(374, 9, 15, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:10:36', 1, 1),
(375, 9, 16, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-02 17:10:44', 1, 1),
(376, 9, 17, '', 'Lapeado', NULL, '', 86400, 4400, 1200, 12, 'A', '2019-08-29 16:00:15', '2019-09-02 17:10:54', 1, 1),
(377, 9, 18, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:11:05', 1, 1),
(378, 9, 19, '', 'Rectificado axial', NULL, '', 86400, 2640, 900, 25, 'A', '2019-08-29 16:00:15', '2019-09-03 09:42:10', 1, 1),
(379, 9, 20, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:12:10', 1, 1),
(380, 9, 21, '', 'Acuñado', NULL, '', 86400, 19360, 2100, 2, 'A', '2019-08-29 16:00:15', '2019-09-02 17:12:00', 1, 1),
(381, 9, 22, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:11:50', 1, 1),
(382, 9, 23, '', 'Inspección 100% Linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:15', '2019-09-02 17:11:42', 1, 1),
(383, 9, 24, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:11:36', 1, 1),
(384, 9, 25, '', 'Inspección muestral ', NULL, '', 86400, 3600, 900, 11, 'A', '2019-08-29 16:00:15', '2019-09-02 17:11:28', 1, 1),
(385, 9, 26, '', 'MSA', NULL, '', 86400, 10560, 1500, 14, 'A', '2019-08-29 16:00:15', '2019-09-02 17:11:22', 1, 1),
(386, 9, 27, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:15', '2019-09-02 17:11:17', 1, 1),
(387, 9, 28, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:15', '2019-09-02 17:11:11', 1, 1),
(388, 15, 1, '', 'Oval Coiling', NULL, '', 86400, 17655, 2700, 17, 'A', '2019-08-29 16:00:15', '2019-09-02 16:54:40', 1, 1),
(389, 15, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:54:47', 1, 1),
(390, 15, 3, '', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-08-29 16:00:15', '2019-09-02 16:54:54', 1, 1),
(391, 15, 4, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 8580, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-02 16:55:04', 1, 1),
(392, 15, 5, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:55:09', 1, 1),
(393, 15, 6, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-02 16:55:16', 1, 1),
(394, 15, 7, '', 'Sanblasting', NULL, '', 86400, 4500, 600, 27, 'A', '2019-08-29 16:00:15', '2019-09-02 16:55:23', 1, 1),
(395, 15, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:55:31', 1, 1),
(396, 15, 9, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 2932, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1);
INSERT INTO `det_rutas` (`id`, `ruta`, `secuencia`, `referencia`, `nombre`, `prefijo`, `notas`, `tiempo_stock`, `tiempo_proceso`, `tiempo_setup`, `proceso`, `estatus`, `creacion`, `modificacion`, `creado`, `modificado`) VALUES
(397, 15, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:55:41', 1, 1),
(398, 15, 11, '', 'PVD', NULL, '', 129600, 46800, 14400, 20, 'A', '2019-08-29 16:00:15', '2019-09-02 16:55:51', 1, 1),
(399, 15, 12, NULL, 'Pulido Knopp 2', NULL, NULL, 86400, 2932, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(400, 15, 13, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:56:22', 1, 1),
(401, 15, 14, '', 'Rectificado del gap+ chaflan del gap ', NULL, '', 86400, 8580, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-02 16:56:30', 1, 1),
(402, 15, 15, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:56:39', 1, 1),
(403, 15, 16, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-02 16:56:50', 1, 1),
(404, 15, 17, '', 'Lapeado', NULL, '', 86400, 5500, 1200, 12, 'A', '2019-08-29 16:00:15', '2019-09-02 16:57:08', 1, 1),
(405, 15, 18, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:57:23', 1, 1),
(406, 15, 19, '', 'Rectificado axial', NULL, '', 86400, 2640, 900, 25, 'A', '2019-08-29 16:00:15', '2019-09-03 09:42:29', 1, 1),
(407, 15, 20, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:57:48', 1, 1),
(408, 15, 21, '', 'Acuñado', NULL, '', 86400, 19360, 2100, 2, 'A', '2019-08-29 16:00:15', '2019-09-02 16:59:36', 1, 1),
(409, 15, 22, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:01:00', 1, 1),
(410, 15, 23, '', 'Inspección 100% Linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:15', '2019-09-02 17:01:34', 1, 1),
(411, 15, 24, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 17:04:28', 1, 1),
(412, 15, 25, '', 'Inspección muestral ', NULL, '', 86400, 3600, 900, 11, 'A', '2019-08-29 16:00:15', '2019-09-02 17:04:51', 1, 1),
(413, 15, 26, '', 'MSA', NULL, '', 86400, 10560, 1500, 14, 'A', '2019-08-29 16:00:15', '2019-09-02 17:05:49', 1, 1),
(414, 15, 27, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:15', '2019-09-02 17:05:57', 1, 1),
(415, 15, 28, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:15', '2019-09-02 17:06:04', 1, 1),
(416, 16, 1, '', 'Round Coiling', NULL, '', 86400, 4478, 2100, 26, 'A', '2019-08-29 16:00:15', '2019-09-02 16:51:29', 1, 1),
(417, 16, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:51:35', 1, 1),
(418, 16, 3, '', 'Nitrurado', NULL, '', 86400, 36000, 18000, 16, 'A', '2019-08-29 16:00:15', '2019-09-02 16:51:41', 1, 1),
(419, 16, 4, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:51:49', 1, 1),
(420, 16, 5, '', 'Pulido TP', NULL, '', 86400, 7200, 1200, 19, 'A', '2019-08-29 16:00:15', '2019-09-02 16:52:35', 1, 1),
(421, 16, 6, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:52:47', 1, 1),
(422, 16, 7, '', 'Corte TP', NULL, '', 86400, 8967, 1200, 6, 'A', '2019-08-29 16:00:15', '2019-09-02 16:52:54', 1, 1),
(423, 16, 8, '', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-08-29 16:00:15', '2019-09-02 16:53:02', 1, 1),
(424, 16, 9, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 6336, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(425, 16, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:53:19', 1, 1),
(426, 16, 12, '', 'Inspección muestral ', NULL, '', 86400, 3600, 900, 11, 'A', '2019-08-29 16:00:15', '2019-09-02 16:53:28', 1, 1),
(427, 16, 13, '', 'Rail inspection', NULL, '', 86400, 11000, 2400, 21, 'A', '2019-08-29 16:00:15', '2019-09-02 16:53:45', 1, 1),
(428, 16, 14, '', 'Inspección final', NULL, '', 86400, 7200, 600, 10, 'A', '2019-08-29 16:00:15', '2019-09-02 16:53:52', 1, 1),
(429, 16, 15, '', 'Coloring', NULL, '', 86400, 2700, 1200, 5, 'A', '2019-08-29 16:00:15', '2019-09-02 16:53:58', 1, 1),
(430, 16, 16, '', 'Aceitado y empaque', NULL, '', 86400, 5400, 900, 1, 'A', '2019-08-29 16:00:15', '2019-09-02 16:54:07', 1, 1),
(431, 6, 1, '', 'Oval Coiling', NULL, '', 86400, 17490, 2700, 17, 'A', '2019-08-29 16:00:15', '2019-09-02 16:39:39', 1, 1),
(432, 6, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:39:46', 1, 1),
(433, 6, 3, '', 'PVD', NULL, '', 129600, 46800, 14400, 20, 'A', '2019-08-29 16:00:15', '2019-09-02 16:39:53', 1, 1),
(434, 6, 4, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 10725, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-02 16:40:00', 1, 1),
(435, 6, 5, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:40:06', 1, 1),
(436, 6, 6, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-02 16:40:12', 1, 1),
(437, 6, 7, '', 'Rectificado axial', NULL, '', 86400, 3300, 900, 25, 'A', '2019-08-29 16:00:15', '2019-09-03 09:36:38', 1, 1),
(438, 6, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:40:27', 1, 1),
(439, 6, 9, '', 'Nitrurado', NULL, '', 86400, 36000, 18000, 16, 'A', '2019-08-29 16:00:15', '2019-09-02 16:40:39', 1, 1),
(440, 6, 10, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:40:48', 1, 1),
(441, 6, 11, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 2932, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(442, 6, 12, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:41:00', 1, 1),
(443, 6, 13, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 10725, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-02 16:41:10', 1, 1),
(444, 6, 14, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:41:19', 1, 1),
(445, 6, 15, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-02 16:41:32', 1, 1),
(446, 6, 16, '', 'Lapeado', NULL, '', 86400, 5500, 1200, 12, 'A', '2019-08-29 16:00:15', '2019-09-02 16:41:44', 1, 1),
(447, 6, 17, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:41:54', 1, 1),
(448, 6, 18, '', 'Rectificado axial', NULL, '', 86400, 3300, 900, 25, 'A', '2019-08-29 16:00:15', '2019-09-03 09:36:49', 1, 1),
(449, 6, 19, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:42:18', 1, 1),
(450, 6, 20, '', 'Inspección 100% Linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:15', '2019-09-02 16:42:35', 1, 1),
(451, 6, 21, '', 'Inspección muestral ', NULL, '', 86400, 3600, 900, 11, 'A', '2019-08-29 16:00:15', '2019-09-02 16:42:43', 1, 1),
(452, 6, 22, '', 'MSA', NULL, '', 86400, 13200, 1500, 14, 'A', '2019-08-29 16:00:15', '2019-09-02 16:42:50', 1, 1),
(453, 6, 23, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:15', '2019-09-02 16:43:07', 1, 1),
(454, 6, 24, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:15', '2019-09-02 16:43:15', 1, 1),
(455, 18, 1, '', 'Oval Coiling', NULL, '', 86400, 17490, 2700, 17, 'A', '2019-08-29 16:00:15', '2019-09-02 16:43:32', 1, 1),
(456, 18, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:43:38', 1, 1),
(457, 18, 3, '', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-08-29 16:00:15', '2019-09-02 16:43:44', 1, 1),
(458, 18, 4, '', 'Inspección 100% linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:15', '2019-09-02 16:43:53', 1, 1),
(459, 18, 5, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 10725, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-02 16:44:02', 1, 1),
(460, 18, 6, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:44:23', 1, 1),
(461, 18, 7, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-02 16:44:31', 1, 1),
(462, 18, 8, '', 'Sanblasting', NULL, '', 86400, 4500, 600, 27, 'A', '2019-08-29 16:00:15', '2019-09-02 16:44:42', 1, 1),
(463, 18, 9, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:44:50', 1, 1),
(464, 18, 10, '', 'Pulido Knopp 1', NULL, '', 86400, 2932, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-09-02 16:45:04', 1, 1),
(465, 18, 11, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:45:13', 1, 1),
(466, 18, 12, '', 'PVD', NULL, '', 129600, 46800, 14400, 20, 'A', '2019-08-29 16:00:15', '2019-09-02 16:45:42', 1, 1),
(467, 18, 13, NULL, 'Pulido Knopp 2', NULL, NULL, 86400, 2932, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(468, 18, 14, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:45:51', 1, 1),
(469, 18, 15, '', 'Inspección 100% linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:15', '2019-09-02 16:45:58', 1, 1),
(470, 18, 16, '', 'Rectificado + chaflan del gap', NULL, '', 86400, 10725, 1200, 24, 'A', '2019-08-29 16:00:15', '2019-09-02 16:46:29', 1, 1),
(471, 18, 17, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:46:37', 1, 1),
(472, 18, 18, '', 'Cepillado del gap', NULL, '', 86400, 1800, 600, 4, 'A', '2019-08-29 16:00:15', '2019-09-02 16:46:49', 1, 1),
(473, 18, 19, '', 'Inspección 100% linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:15', '2019-09-02 16:47:07', 1, 1),
(474, 18, 20, '', 'Lapeado', NULL, '', 86400, 5500, 1200, 12, 'A', '2019-08-29 16:00:15', '2019-09-02 16:48:53', 1, 1),
(475, 18, 21, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:49:06', 1, 1),
(476, 18, 22, '', 'Rectificado axial', NULL, '', 86400, 3300, 900, 25, 'A', '2019-08-29 16:00:15', '2019-09-03 09:37:38', 1, 1),
(477, 18, 23, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:49:36', 1, 1),
(478, 18, 24, '', 'Inspección 100% linea de contacto', NULL, '', 86400, 3600, 600, 9, 'A', '2019-08-29 16:00:15', '2019-09-02 16:49:51', 1, 1),
(479, 18, 25, '', 'Inspección muestral ', NULL, '', 86400, 2700, 900, 11, 'A', '2019-08-29 16:00:15', '2019-09-02 16:50:37', 1, 1),
(480, 18, 26, '', 'MSA', NULL, '', 86400, 13200, 1500, 14, 'A', '2019-08-29 16:00:15', '2019-09-02 16:50:54', 1, 1),
(481, 18, 27, '', 'Inspección Final', NULL, '', 86400, 5400, 600, 10, 'A', '2019-08-29 16:00:15', '2019-09-02 16:51:02', 1, 1),
(482, 18, 28, '', 'Aceitado y empaque', NULL, '', 86400, 3600, 900, 1, 'A', '2019-08-29 16:00:15', '2019-09-02 16:51:08', 1, 1),
(483, 1, 1, '', 'Round Coiling', NULL, '', 86400, 4478, 2100, 26, 'A', '2019-08-29 16:00:15', '2019-09-02 16:35:52', 1, 1),
(484, 1, 2, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:35:58', 1, 1),
(485, 1, 3, '', 'Nitrurado', NULL, '', 86400, 36000, 18000, 16, 'A', '2019-08-29 16:00:15', '2019-09-02 16:36:09', 1, 1),
(486, 1, 4, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:36:17', 1, 1),
(487, 1, 5, '', 'Pulido TP', NULL, '', 86400, 7200, 1200, 19, 'A', '2019-08-29 16:00:15', '2019-09-02 16:36:46', 1, 1),
(488, 1, 6, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:37:01', 1, 1),
(489, 1, 7, '', 'PVD', NULL, '', 86400, 46800, 14400, 20, 'A', '2019-08-29 16:00:15', '2019-09-02 16:37:13', 1, 1),
(490, 1, 8, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:37:30', 1, 1),
(491, 1, 9, '', 'Corte TP', NULL, '', 86400, 8967, 1200, 6, 'A', '2019-08-29 16:00:15', '2019-09-02 16:37:43', 1, 1),
(492, 1, 10, '', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-08-29 16:00:15', '2019-09-02 16:37:57', 1, 1),
(493, 1, 11, NULL, 'Pulido Knopp 1', NULL, NULL, 86400, 6336, 1800, 18, 'A', '2019-08-29 16:00:15', '2019-08-29 16:00:15', 1, 1),
(494, 1, 12, '', 'Lavadora Dürr 1/2', NULL, '', 1800, 900, 300, 13, 'A', '2019-08-29 16:00:15', '2019-09-02 16:38:14', 1, 1),
(495, 1, 13, '', 'Inspección muestral ', NULL, '', 86400, 900, 900, 11, 'A', '2019-08-29 16:00:15', '2019-09-02 16:38:26', 1, 1),
(496, 1, 14, '', 'Rail inspection', NULL, '', 86400, 11000, 2400, 21, 'A', '2019-08-29 16:00:15', '2019-09-02 16:38:40', 1, 1),
(497, 1, 15, '', 'Inspección Final', NULL, '', 86400, 7200, 600, 10, 'A', '2019-08-29 16:00:15', '2019-09-02 16:38:55', 1, 1),
(498, 1, 16, '', 'Coloring', NULL, '', 86400, 2700, 1200, 5, 'A', '2019-08-29 16:00:15', '2019-09-02 16:39:15', 1, 1),
(499, 1, 17, '', 'Aceitado y empaque', NULL, '', 86400, 5400, 900, 1, 'A', '2019-08-29 16:00:15', '2019-09-02 16:39:25', 1, 1),
(501, 14, 3, 'RE010', 'Recocido', NULL, '', 129600, 21600, 18000, 23, 'A', '2019-09-02 17:17:01', '2019-09-02 17:24:15', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `disponibilidad_general`
--

CREATE TABLE IF NOT EXISTS `disponibilidad_general` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `calendario` bigint(20) DEFAULT NULL COMMENT 'ID del calendario',
  `equipo` bigint(20) DEFAULT NULL COMMENT 'ID del equipo',
  `lunes` int(5) DEFAULT NULL COMMENT 'Disponibilidad lunes',
  `martes` int(5) DEFAULT NULL COMMENT 'Disponibilidad martes',
  `miercoles` int(5) DEFAULT NULL COMMENT 'Disponibilidad miercoles',
  `jueves` int(5) DEFAULT NULL COMMENT 'Disponibilidad jueves',
  `viernes` int(5) DEFAULT NULL COMMENT 'Disponibilidad viernes',
  `sabado` int(5) DEFAULT NULL COMMENT 'Disponibilidad sabado',
  `domingo` int(5) DEFAULT NULL COMMENT 'Disponibilidad domingo',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`calendario`,`equipo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Tabla de disponibilidad general' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estimados`
--

CREATE TABLE IF NOT EXISTS `estimados` (
  `equipo` bigint(11) DEFAULT NULL COMMENT 'ID del equipo',
  `anio` int(4) DEFAULT NULL COMMENT 'Año del estimado',
  `semana` int(2) DEFAULT NULL COMMENT 'Semana del estimado',
  `oee_minimo` decimal(10,5) DEFAULT NULL COMMENT 'Mínimo de OEE',
  `oee_maximo` decimal(10,5) DEFAULT NULL COMMENT 'Máximo de OEE',
  `ftq_minimo` decimal(10,5) DEFAULT NULL COMMENT 'Mínimo de FTQ',
  `ftq_maximo` decimal(10,5) DEFAULT NULL COMMENT 'Máximo de FTQ',
  `efi_minimo` decimal(10,5) DEFAULT NULL COMMENT 'Mínimo de Eficiencia',
  `efi_maximo` decimal(10,5) DEFAULT NULL COMMENT 'Máximo de Eficiencia',
  `dis_minimo` decimal(10,5) DEFAULT NULL COMMENT 'Mínimo de Disponibilidad',
  `dis_maximo` decimal(10,5) DEFAULT NULL COMMENT 'Máximo de Disponibilidad',
  UNIQUE KEY `NewIndex1` (`equipo`,`anio`,`semana`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Estimado de cumplimiento por semana';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE IF NOT EXISTS `horarios` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `tipo` char(1) DEFAULT 'S' COMMENT 'Tipo de horario (S/N)',
  `proceso` bigint(20) DEFAULT '0' COMMENT 'ID del proceso',
  `dia` int(1) DEFAULT '0' COMMENT 'Dia de semana (9=por fecha)',
  `fecha` date DEFAULT NULL COMMENT 'Fecha a revisar',
  `desde` time DEFAULT NULL COMMENT 'Hora desde',
  `hasta` time DEFAULT NULL COMMENT 'Hora hasta',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Horarios' AUTO_INCREMENT=50 ;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`id`, `tipo`, `proceso`, `dia`, `fecha`, `desde`, `hasta`) VALUES
(38, 'S', 0, 1, '2019-08-28', '06:30:00', '23:59:59'),
(39, 'S', 0, 2, '2019-08-29', '00:00:00', '23:59:59'),
(40, 'S', 0, 3, '2019-08-29', '00:00:00', '23:59:59'),
(41, 'S', 0, 4, '2019-08-29', '00:00:00', '23:59:59'),
(42, 'S', 0, 5, '2019-08-29', '00:00:00', '23:59:59'),
(44, 'S', 0, 6, '2019-08-28', '00:00:00', '21:59:59'),
(45, 'N', 0, 9, '2019-09-16', '00:00:00', '23:59:59'),
(49, 'N', 0, 9, '2019-09-17', '00:00:00', '06:29:59'),
(47, 'N', 0, 9, '2019-11-19', '00:00:00', '06:29:59'),
(48, 'S', 0, 9, '2019-11-18', '00:00:00', '23:59:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kanban`
--

CREATE TABLE IF NOT EXISTS `kanban` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `planta` bigint(20) DEFAULT NULL COMMENT 'ID de la planta',
  `linea` bigint(20) DEFAULT NULL COMMENT 'ID de la línea',
  `equipo` bigint(20) DEFAULT NULL COMMENT 'ID del equipo',
  `ruta` bigint(20) DEFAULT NULL COMMENT 'ID de la ruta',
  `operacion` bigint(20) DEFAULT NULL COMMENT 'ID de la operacion',
  `orden` varchar(50) DEFAULT NULL COMMENT 'ID de la O/P',
  `parte` varchar(100) DEFAULT NULL COMMENT 'Número de parte',
  `existencia` decimal(25,6) DEFAULT NULL COMMENT 'Cantidad en Stock',
  `desde` datetime DEFAULT NULL COMMENT 'Fecha y hora de entrada',
  `estatus` int(2) DEFAULT NULL COMMENT 'Estatus del stock',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Detalle de existencias en kanban' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log`
--

CREATE TABLE IF NOT EXISTS `log` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora del registro',
  `aplicacion` int(6) DEFAULT NULL COMMENT 'ID de la aplicación',
  `tipo` int(1) DEFAULT '0' COMMENT 'Tipo de mensaje',
  `tiempo` bigint(8) DEFAULT NULL COMMENT 'Segundos en espera',
  `reporte` bigint(11) DEFAULT NULL COMMENT 'Número de reporte',
  `intentados` bigint(8) DEFAULT NULL COMMENT 'Alertas intentadas',
  `enviados` bigint(8) DEFAULT NULL COMMENT 'Alertas enviadas con exito',
  `texto` varchar(250) DEFAULT NULL COMMENT 'Mensaje descriptivo (hasta 250 caracteres)',
  `visto` char(1) DEFAULT 'N' COMMENT 'Ya se vió en el visor?',
  `visto_pc` char(1) DEFAULT 'N' COMMENT 'Ya se vió en el log del PC?',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`fecha`),
  KEY `NewIndex2` (`aplicacion`,`visto`,`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=217407 ;

--
-- Volcado de datos para la tabla `log`
--

INSERT INTO `log` (`id`, `fecha`, `aplicacion`, `tipo`, `tiempo`, `reporte`, `intentados`, `enviados`, `texto`, `visto`, `visto_pc`) VALUES
(216706, '2019-08-29 16:59:55', 0, 1, NULL, 0, NULL, NULL, 'Se incicia el programa', 'N', 'N'),
(216707, '2019-08-29 16:59:55', 0, 1, NULL, 0, NULL, NULL, 'Se incicia el programa', 'N', 'N'),
(216708, '2019-08-29 16:59:55', 0, 1, NULL, 0, NULL, NULL, 'Se inicia la aplicación de Envío de correos', 'N', 'N'),
(216709, '2019-08-29 16:59:55', 0, 1, NULL, 0, NULL, NULL, 'Se inicia la aplicación de Envío de correos', 'N', 'N'),
(216710, '2019-08-29 16:59:55', 0, 1, NULL, 0, NULL, NULL, 'Conexión satisfactoria a MySQL', 'N', 'N'),
(216711, '2019-08-29 16:59:55', 0, 1, NULL, 0, NULL, NULL, 'Conexión satisfactoria a MySQL', 'N', 'N'),
(216712, '2019-08-30 22:28:16', 0, 1, NULL, 0, NULL, NULL, 'Se incicia el programa', 'N', 'N'),
(216713, '2019-08-30 22:28:16', 0, 1, NULL, 0, NULL, NULL, 'Se inicia la aplicación de Envío de correos', 'N', 'N'),
(216714, '2019-08-30 22:28:16', 0, 1, NULL, 0, NULL, NULL, 'Conexión satisfactoria a MySQL', 'N', 'N'),
(216715, '2019-08-30 22:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea escalamiento de NIVEL 2 en el reporte: 6141- a 147:57:54', 'N', 'N'),
(216716, '2019-08-30 22:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 1 del escalamiento de NIVEL 1 en el reporte: 6141- a 147:57:54', 'N', 'N'),
(216717, '2019-08-30 22:37:49', 0, 9, NULL, 0, NULL, NULL, 'La aplicación se cerró el usuario: ', 'N', 'N'),
(216718, '2019-08-30 22:45:49', 0, 1, NULL, 0, NULL, NULL, 'Se incicia el programa', 'N', 'N'),
(216719, '2019-08-30 22:45:49', 0, 1, NULL, 0, NULL, NULL, 'Se inicia la aplicación de Envío de correos', 'N', 'N'),
(216720, '2019-08-30 22:45:50', 0, 1, NULL, 0, NULL, NULL, 'Conexión satisfactoria a MySQL', 'N', 'N'),
(216721, '2019-08-30 22:45:52', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(216722, '2019-08-30 22:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea escalamiento de NIVEL 3 en el reporte: 6141- a 148:27:54', 'N', 'N'),
(216723, '2019-08-30 22:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 1 del escalamiento de NIVEL 2 en el reporte: 6141- a 148:27:54', 'N', 'N'),
(216724, '2019-08-30 22:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 2 del escalamiento de NIVEL 1 en el reporte: 6141- a 148:27:54', 'N', 'N'),
(216725, '2019-08-30 22:58:28', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 3 notifación(es)', 'N', 'N'),
(216726, '2019-08-30 23:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 1 del escalamiento de NIVEL 3 en el reporte: 6141- a 148:57:54', 'N', 'N'),
(216727, '2019-08-30 23:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 2 del escalamiento de NIVEL 2 en el reporte: 6141- a 148:57:54', 'N', 'N'),
(216728, '2019-08-30 23:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 3 del escalamiento de NIVEL 1 en el reporte: 6141- a 148:57:54', 'N', 'N'),
(216729, '2019-08-30 23:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 2 del escalamiento de NIVEL 3 en el reporte: 6141- a 149:27:54', 'N', 'N'),
(216730, '2019-08-30 23:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 3 del escalamiento de NIVEL 2 en el reporte: 6141- a 149:27:54', 'N', 'N'),
(216731, '2019-08-30 23:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 4 del escalamiento de NIVEL 1 en el reporte: 6141- a 149:27:54', 'N', 'N'),
(216732, '2019-08-30 23:58:29', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216733, '2019-08-31 00:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 3 del escalamiento de NIVEL 3 en el reporte: 6141- a 149:57:54', 'N', 'N'),
(216734, '2019-08-31 00:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 4 del escalamiento de NIVEL 2 en el reporte: 6141- a 149:57:54', 'N', 'N'),
(216735, '2019-08-31 00:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 5 del escalamiento de NIVEL 1 en el reporte: 6141- a 149:57:54', 'N', 'N'),
(216736, '2019-08-31 00:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 4 del escalamiento de NIVEL 3 en el reporte: 6141- a 150:27:54', 'N', 'N'),
(216737, '2019-08-31 00:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 5 del escalamiento de NIVEL 2 en el reporte: 6141- a 150:27:54', 'N', 'N'),
(216738, '2019-08-31 00:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 6 del escalamiento de NIVEL 1 en el reporte: 6141- a 150:27:54', 'N', 'N'),
(216739, '2019-08-31 00:58:29', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216740, '2019-08-31 01:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 5 del escalamiento de NIVEL 3 en el reporte: 6141- a 150:57:54', 'N', 'N'),
(216741, '2019-08-31 01:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 6 del escalamiento de NIVEL 2 en el reporte: 6141- a 150:57:54', 'N', 'N'),
(216742, '2019-08-31 01:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 7 del escalamiento de NIVEL 1 en el reporte: 6141- a 150:57:54', 'N', 'N'),
(216743, '2019-08-31 01:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 6 del escalamiento de NIVEL 3 en el reporte: 6141- a 151:27:54', 'N', 'N'),
(216744, '2019-08-31 01:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 7 del escalamiento de NIVEL 2 en el reporte: 6141- a 151:27:54', 'N', 'N'),
(216745, '2019-08-31 01:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 8 del escalamiento de NIVEL 1 en el reporte: 6141- a 151:27:54', 'N', 'N'),
(216746, '2019-08-31 01:58:28', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216747, '2019-08-31 02:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 7 del escalamiento de NIVEL 3 en el reporte: 6141- a 151:57:54', 'N', 'N'),
(216748, '2019-08-31 02:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 8 del escalamiento de NIVEL 2 en el reporte: 6141- a 151:57:54', 'N', 'N'),
(216749, '2019-08-31 02:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 9 del escalamiento de NIVEL 1 en el reporte: 6141- a 151:57:54', 'N', 'N'),
(216750, '2019-08-31 02:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 8 del escalamiento de NIVEL 3 en el reporte: 6141- a 152:27:54', 'N', 'N'),
(216751, '2019-08-31 02:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 9 del escalamiento de NIVEL 2 en el reporte: 6141- a 152:27:54', 'N', 'N'),
(216752, '2019-08-31 02:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 10 del escalamiento de NIVEL 1 en el reporte: 6141- a 152:27:54', 'N', 'N'),
(216753, '2019-08-31 02:58:27', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216754, '2019-08-31 03:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 9 del escalamiento de NIVEL 3 en el reporte: 6141- a 152:57:54', 'N', 'N'),
(216755, '2019-08-31 03:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 10 del escalamiento de NIVEL 2 en el reporte: 6141- a 152:57:54', 'N', 'N'),
(216756, '2019-08-31 03:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 11 del escalamiento de NIVEL 1 en el reporte: 6141- a 152:57:54', 'N', 'N'),
(216757, '2019-08-31 03:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 10 del escalamiento de NIVEL 3 en el reporte: 6141- a 153:27:54', 'N', 'N'),
(216758, '2019-08-31 03:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 11 del escalamiento de NIVEL 2 en el reporte: 6141- a 153:27:54', 'N', 'N'),
(216759, '2019-08-31 03:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 12 del escalamiento de NIVEL 1 en el reporte: 6141- a 153:27:54', 'N', 'N'),
(216760, '2019-08-31 03:58:30', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216761, '2019-08-31 04:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 11 del escalamiento de NIVEL 3 en el reporte: 6141- a 153:57:54', 'N', 'N'),
(216762, '2019-08-31 04:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 12 del escalamiento de NIVEL 2 en el reporte: 6141- a 153:57:54', 'N', 'N'),
(216763, '2019-08-31 04:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 13 del escalamiento de NIVEL 1 en el reporte: 6141- a 153:57:54', 'N', 'N'),
(216764, '2019-08-31 04:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 12 del escalamiento de NIVEL 3 en el reporte: 6141- a 154:27:54', 'N', 'N'),
(216765, '2019-08-31 04:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 13 del escalamiento de NIVEL 2 en el reporte: 6141- a 154:27:54', 'N', 'N'),
(216766, '2019-08-31 04:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 14 del escalamiento de NIVEL 1 en el reporte: 6141- a 154:27:54', 'N', 'N'),
(216767, '2019-08-31 04:58:22', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216768, '2019-08-31 05:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 13 del escalamiento de NIVEL 3 en el reporte: 6141- a 154:57:54', 'N', 'N'),
(216769, '2019-08-31 05:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 14 del escalamiento de NIVEL 2 en el reporte: 6141- a 154:57:54', 'N', 'N'),
(216770, '2019-08-31 05:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 15 del escalamiento de NIVEL 1 en el reporte: 6141- a 154:57:54', 'N', 'N'),
(216771, '2019-08-31 05:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 14 del escalamiento de NIVEL 3 en el reporte: 6141- a 155:27:54', 'N', 'N'),
(216772, '2019-08-31 05:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 15 del escalamiento de NIVEL 2 en el reporte: 6141- a 155:27:54', 'N', 'N'),
(216773, '2019-08-31 05:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 16 del escalamiento de NIVEL 1 en el reporte: 6141- a 155:27:54', 'N', 'N'),
(216774, '2019-08-31 05:58:25', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216775, '2019-08-31 06:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 15 del escalamiento de NIVEL 3 en el reporte: 6141- a 155:57:54', 'N', 'N'),
(216776, '2019-08-31 06:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 16 del escalamiento de NIVEL 2 en el reporte: 6141- a 155:57:54', 'N', 'N'),
(216777, '2019-08-31 06:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 17 del escalamiento de NIVEL 1 en el reporte: 6141- a 155:57:54', 'N', 'N'),
(216778, '2019-08-31 06:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 16 del escalamiento de NIVEL 3 en el reporte: 6141- a 156:27:54', 'N', 'N'),
(216779, '2019-08-31 06:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 17 del escalamiento de NIVEL 2 en el reporte: 6141- a 156:27:54', 'N', 'N'),
(216780, '2019-08-31 06:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 18 del escalamiento de NIVEL 1 en el reporte: 6141- a 156:27:54', 'N', 'N'),
(216781, '2019-08-31 06:58:21', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216782, '2019-08-31 07:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 17 del escalamiento de NIVEL 3 en el reporte: 6141- a 156:57:54', 'N', 'N'),
(216783, '2019-08-31 07:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 18 del escalamiento de NIVEL 2 en el reporte: 6141- a 156:57:54', 'N', 'N'),
(216784, '2019-08-31 07:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 19 del escalamiento de NIVEL 1 en el reporte: 6141- a 156:57:54', 'N', 'N'),
(216785, '2019-08-31 07:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 18 del escalamiento de NIVEL 3 en el reporte: 6141- a 157:27:54', 'N', 'N'),
(216786, '2019-08-31 07:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 19 del escalamiento de NIVEL 2 en el reporte: 6141- a 157:27:54', 'N', 'N'),
(216787, '2019-08-31 07:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 20 del escalamiento de NIVEL 1 en el reporte: 6141- a 157:27:54', 'N', 'N'),
(216788, '2019-08-31 07:58:29', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216789, '2019-08-31 08:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 19 del escalamiento de NIVEL 3 en el reporte: 6141- a 157:57:54', 'N', 'N'),
(216790, '2019-08-31 08:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 20 del escalamiento de NIVEL 2 en el reporte: 6141- a 157:57:54', 'N', 'N'),
(216791, '2019-08-31 08:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 21 del escalamiento de NIVEL 1 en el reporte: 6141- a 157:57:54', 'N', 'N'),
(216792, '2019-08-31 08:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 20 del escalamiento de NIVEL 3 en el reporte: 6141- a 158:27:54', 'N', 'N'),
(216793, '2019-08-31 08:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 21 del escalamiento de NIVEL 2 en el reporte: 6141- a 158:27:54', 'N', 'N'),
(216794, '2019-08-31 08:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 22 del escalamiento de NIVEL 1 en el reporte: 6141- a 158:27:54', 'N', 'N'),
(216795, '2019-08-31 08:58:28', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216796, '2019-08-31 09:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 21 del escalamiento de NIVEL 3 en el reporte: 6141- a 158:57:54', 'N', 'N'),
(216797, '2019-08-31 09:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 22 del escalamiento de NIVEL 2 en el reporte: 6141- a 158:57:54', 'N', 'N'),
(216798, '2019-08-31 09:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 23 del escalamiento de NIVEL 1 en el reporte: 6141- a 158:57:54', 'N', 'N'),
(216799, '2019-08-31 09:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 22 del escalamiento de NIVEL 3 en el reporte: 6141- a 159:27:54', 'N', 'N'),
(216800, '2019-08-31 09:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 23 del escalamiento de NIVEL 2 en el reporte: 6141- a 159:27:54', 'N', 'N'),
(216801, '2019-08-31 09:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 24 del escalamiento de NIVEL 1 en el reporte: 6141- a 159:27:54', 'N', 'N'),
(216802, '2019-08-31 09:58:28', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216803, '2019-08-31 10:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 23 del escalamiento de NIVEL 3 en el reporte: 6141- a 159:57:54', 'N', 'N'),
(216804, '2019-08-31 10:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 24 del escalamiento de NIVEL 2 en el reporte: 6141- a 159:57:54', 'N', 'N'),
(216805, '2019-08-31 10:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 25 del escalamiento de NIVEL 1 en el reporte: 6141- a 159:57:54', 'N', 'N'),
(216806, '2019-08-31 10:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 24 del escalamiento de NIVEL 3 en el reporte: 6141- a 160:27:54', 'N', 'N'),
(216807, '2019-08-31 10:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 25 del escalamiento de NIVEL 2 en el reporte: 6141- a 160:27:54', 'N', 'N'),
(216808, '2019-08-31 10:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 26 del escalamiento de NIVEL 1 en el reporte: 6141- a 160:27:54', 'N', 'N'),
(216809, '2019-08-31 10:58:27', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216810, '2019-08-31 11:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 25 del escalamiento de NIVEL 3 en el reporte: 6141- a 160:57:54', 'N', 'N'),
(216811, '2019-08-31 11:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 26 del escalamiento de NIVEL 2 en el reporte: 6141- a 160:57:54', 'N', 'N'),
(216812, '2019-08-31 11:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 27 del escalamiento de NIVEL 1 en el reporte: 6141- a 160:57:54', 'N', 'N'),
(216813, '2019-08-31 11:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 26 del escalamiento de NIVEL 3 en el reporte: 6141- a 161:27:54', 'N', 'N'),
(216814, '2019-08-31 11:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 27 del escalamiento de NIVEL 2 en el reporte: 6141- a 161:27:54', 'N', 'N'),
(216815, '2019-08-31 11:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 28 del escalamiento de NIVEL 1 en el reporte: 6141- a 161:27:54', 'N', 'N'),
(216816, '2019-08-31 12:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 27 del escalamiento de NIVEL 3 en el reporte: 6141- a 161:57:54', 'N', 'N'),
(216817, '2019-08-31 12:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 28 del escalamiento de NIVEL 2 en el reporte: 6141- a 161:57:54', 'N', 'N'),
(216818, '2019-08-31 12:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 29 del escalamiento de NIVEL 1 en el reporte: 6141- a 161:57:54', 'N', 'N'),
(216819, '2019-08-31 12:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 28 del escalamiento de NIVEL 3 en el reporte: 6141- a 162:27:54', 'N', 'N'),
(216820, '2019-08-31 12:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 29 del escalamiento de NIVEL 2 en el reporte: 6141- a 162:27:54', 'N', 'N'),
(216821, '2019-08-31 12:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 30 del escalamiento de NIVEL 1 en el reporte: 6141- a 162:27:54', 'N', 'N'),
(216822, '2019-08-31 13:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 29 del escalamiento de NIVEL 3 en el reporte: 6141- a 162:57:54', 'N', 'N'),
(216823, '2019-08-31 13:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 30 del escalamiento de NIVEL 2 en el reporte: 6141- a 162:57:54', 'N', 'N'),
(216824, '2019-08-31 13:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 31 del escalamiento de NIVEL 1 en el reporte: 6141- a 162:57:54', 'N', 'N'),
(216825, '2019-08-31 13:35:56', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 5 notifación(es)', 'N', 'N'),
(216826, '2019-08-31 13:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 30 del escalamiento de NIVEL 3 en el reporte: 6141- a 163:27:54', 'N', 'N'),
(216827, '2019-08-31 13:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 31 del escalamiento de NIVEL 2 en el reporte: 6141- a 163:27:54', 'N', 'N'),
(216828, '2019-08-31 13:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 32 del escalamiento de NIVEL 1 en el reporte: 6141- a 163:27:54', 'N', 'N'),
(216829, '2019-08-31 14:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 31 del escalamiento de NIVEL 3 en el reporte: 6141- a 163:57:54', 'N', 'N'),
(216830, '2019-08-31 14:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 32 del escalamiento de NIVEL 2 en el reporte: 6141- a 163:57:54', 'N', 'N'),
(216831, '2019-08-31 14:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 33 del escalamiento de NIVEL 1 en el reporte: 6141- a 163:57:54', 'N', 'N'),
(216832, '2019-08-31 14:32:02', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216833, '2019-08-31 14:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 32 del escalamiento de NIVEL 3 en el reporte: 6141- a 164:27:54', 'N', 'N'),
(216834, '2019-08-31 14:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 33 del escalamiento de NIVEL 2 en el reporte: 6141- a 164:27:54', 'N', 'N'),
(216835, '2019-08-31 14:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 34 del escalamiento de NIVEL 1 en el reporte: 6141- a 164:27:54', 'N', 'N'),
(216836, '2019-08-31 15:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 33 del escalamiento de NIVEL 3 en el reporte: 6141- a 164:57:54', 'N', 'N'),
(216837, '2019-08-31 15:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 34 del escalamiento de NIVEL 2 en el reporte: 6141- a 164:57:54', 'N', 'N'),
(216838, '2019-08-31 15:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 35 del escalamiento de NIVEL 1 en el reporte: 6141- a 164:57:54', 'N', 'N'),
(216839, '2019-08-31 15:34:43', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216840, '2019-08-31 15:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 34 del escalamiento de NIVEL 3 en el reporte: 6141- a 165:27:54', 'N', 'N'),
(216841, '2019-08-31 15:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 35 del escalamiento de NIVEL 2 en el reporte: 6141- a 165:27:54', 'N', 'N'),
(216842, '2019-08-31 15:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 36 del escalamiento de NIVEL 1 en el reporte: 6141- a 165:27:54', 'N', 'N'),
(216843, '2019-08-31 16:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 35 del escalamiento de NIVEL 3 en el reporte: 6141- a 165:57:54', 'N', 'N'),
(216844, '2019-08-31 16:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 36 del escalamiento de NIVEL 2 en el reporte: 6141- a 165:57:54', 'N', 'N'),
(216845, '2019-08-31 16:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 37 del escalamiento de NIVEL 1 en el reporte: 6141- a 165:57:54', 'N', 'N'),
(216846, '2019-08-31 16:37:41', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216847, '2019-08-31 16:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 36 del escalamiento de NIVEL 3 en el reporte: 6141- a 166:27:54', 'N', 'N'),
(216848, '2019-08-31 16:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 37 del escalamiento de NIVEL 2 en el reporte: 6141- a 166:27:54', 'N', 'N'),
(216849, '2019-08-31 16:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 38 del escalamiento de NIVEL 1 en el reporte: 6141- a 166:27:54', 'N', 'N'),
(216850, '2019-08-31 17:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 37 del escalamiento de NIVEL 3 en el reporte: 6141- a 166:57:54', 'N', 'N'),
(216851, '2019-08-31 17:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 38 del escalamiento de NIVEL 2 en el reporte: 6141- a 166:57:54', 'N', 'N'),
(216852, '2019-08-31 17:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 39 del escalamiento de NIVEL 1 en el reporte: 6141- a 166:57:54', 'N', 'N'),
(216853, '2019-08-31 17:33:50', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216854, '2019-08-31 17:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 38 del escalamiento de NIVEL 3 en el reporte: 6141- a 167:27:54', 'N', 'N'),
(216855, '2019-08-31 17:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 39 del escalamiento de NIVEL 2 en el reporte: 6141- a 167:27:54', 'N', 'N'),
(216856, '2019-08-31 17:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 40 del escalamiento de NIVEL 1 en el reporte: 6141- a 167:27:54', 'N', 'N'),
(216857, '2019-08-31 18:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 39 del escalamiento de NIVEL 3 en el reporte: 6141- a 167:57:54', 'N', 'N'),
(216858, '2019-08-31 18:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 40 del escalamiento de NIVEL 2 en el reporte: 6141- a 167:57:54', 'N', 'N'),
(216859, '2019-08-31 18:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 41 del escalamiento de NIVEL 1 en el reporte: 6141- a 167:57:54', 'N', 'N'),
(216860, '2019-08-31 18:28:26', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216861, '2019-08-31 18:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 40 del escalamiento de NIVEL 3 en el reporte: 6141- a 168:27:54', 'N', 'N'),
(216862, '2019-08-31 18:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 41 del escalamiento de NIVEL 2 en el reporte: 6141- a 168:27:54', 'N', 'N'),
(216863, '2019-08-31 18:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 42 del escalamiento de NIVEL 1 en el reporte: 6141- a 168:27:54', 'N', 'N'),
(216864, '2019-08-31 19:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 41 del escalamiento de NIVEL 3 en el reporte: 6141- a 168:57:54', 'N', 'N'),
(216865, '2019-08-31 19:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 42 del escalamiento de NIVEL 2 en el reporte: 6141- a 168:57:54', 'N', 'N'),
(216866, '2019-08-31 19:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 43 del escalamiento de NIVEL 1 en el reporte: 6141- a 168:57:54', 'N', 'N'),
(216867, '2019-08-31 19:28:26', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216868, '2019-08-31 19:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 42 del escalamiento de NIVEL 3 en el reporte: 6141- a 169:27:54', 'N', 'N'),
(216869, '2019-08-31 19:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 43 del escalamiento de NIVEL 2 en el reporte: 6141- a 169:27:54', 'N', 'N'),
(216870, '2019-08-31 19:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 44 del escalamiento de NIVEL 1 en el reporte: 6141- a 169:27:54', 'N', 'N'),
(216871, '2019-08-31 20:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 43 del escalamiento de NIVEL 3 en el reporte: 6141- a 169:57:54', 'N', 'N'),
(216872, '2019-08-31 20:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 44 del escalamiento de NIVEL 2 en el reporte: 6141- a 169:57:54', 'N', 'N'),
(216873, '2019-08-31 20:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 45 del escalamiento de NIVEL 1 en el reporte: 6141- a 169:57:54', 'N', 'N'),
(216874, '2019-08-31 20:28:27', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216875, '2019-08-31 20:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 44 del escalamiento de NIVEL 3 en el reporte: 6141- a 170:27:54', 'N', 'N'),
(216876, '2019-08-31 20:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 45 del escalamiento de NIVEL 2 en el reporte: 6141- a 170:27:54', 'N', 'N'),
(216877, '2019-08-31 20:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 46 del escalamiento de NIVEL 1 en el reporte: 6141- a 170:27:54', 'N', 'N'),
(216878, '2019-08-31 21:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 45 del escalamiento de NIVEL 3 en el reporte: 6141- a 170:57:54', 'N', 'N'),
(216879, '2019-08-31 21:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 46 del escalamiento de NIVEL 2 en el reporte: 6141- a 170:57:54', 'N', 'N'),
(216880, '2019-08-31 21:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 47 del escalamiento de NIVEL 1 en el reporte: 6141- a 170:57:54', 'N', 'N'),
(216881, '2019-08-31 21:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 46 del escalamiento de NIVEL 3 en el reporte: 6141- a 171:27:54', 'N', 'N'),
(216882, '2019-08-31 21:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 47 del escalamiento de NIVEL 2 en el reporte: 6141- a 171:27:54', 'N', 'N'),
(216883, '2019-08-31 21:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 48 del escalamiento de NIVEL 1 en el reporte: 6141- a 171:27:54', 'N', 'N'),
(216884, '2019-08-31 22:01:59', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 3 notifación(es)', 'N', 'N'),
(216885, '2019-08-31 22:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 47 del escalamiento de NIVEL 3 en el reporte: 6141- a 171:57:54', 'N', 'N'),
(216886, '2019-08-31 22:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 48 del escalamiento de NIVEL 2 en el reporte: 6141- a 171:57:54', 'N', 'N'),
(216887, '2019-08-31 22:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 49 del escalamiento de NIVEL 1 en el reporte: 6141- a 171:57:54', 'N', 'N'),
(216888, '2019-08-31 22:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se ha creado el reporte: 6142', 'N', 'N'),
(216889, '2019-08-31 22:46:12', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86548620', 'N', 'N'),
(216890, '2019-08-31 22:46:14', 0, 1, NULL, 0, NULL, NULL, 'Errores en la generación de llamada a MMCall. No se generaron 1 llamada(s) a MMCall. Error: ', 'N', 'N'),
(216891, '2019-08-31 22:46:14', 0, 1, NULL, 0, NULL, NULL, 'Errores en la generación de llamada a MMCall. No se generaron 1 llamada(s) a MMCall. Error: Error en el servidor remoto: (500) Error interno del servidor.', 'N', 'N'),
(216892, '2019-08-31 22:46:15', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216893, '2019-08-31 22:46:24', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86548620', 'N', 'N'),
(216894, '2019-08-31 22:46:25', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(216895, '2019-08-31 22:49:08', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 1 de alerta para el reporte: 6142- a 0:03:00', 'N', 'N'),
(216896, '2019-08-31 22:49:17', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86548620 *R1 0:03:00', 'N', 'N'),
(216897, '2019-08-31 22:49:17', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(216898, '2019-08-31 22:49:20', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(216899, '2019-08-31 22:52:08', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 2 de alerta para el reporte: 6142- a 0:06:00', 'N', 'N'),
(216900, '2019-08-31 22:52:10', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86548620 *R2 0:06:00', 'N', 'N'),
(216901, '2019-08-31 22:52:10', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(216902, '2019-08-31 22:52:12', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(216903, '2019-08-31 22:55:08', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 3 de alerta para el reporte: 6142- a 0:09:00', 'N', 'N'),
(216904, '2019-08-31 22:55:13', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86548620 *R3 0:09:00', 'N', 'N'),
(216905, '2019-08-31 22:55:13', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(216906, '2019-08-31 22:55:16', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(216907, '2019-08-31 22:58:08', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 4 de alerta para el reporte: 6142- a 0:12:00', 'N', 'N'),
(216908, '2019-08-31 22:58:16', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86548620 *R4 0:12:00', 'N', 'N'),
(216909, '2019-08-31 22:58:16', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(216910, '2019-08-31 22:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 48 del escalamiento de NIVEL 3 en el reporte: 6141- a 172:27:54', 'N', 'N'),
(216911, '2019-08-31 22:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 49 del escalamiento de NIVEL 2 en el reporte: 6141- a 172:27:54', 'N', 'N'),
(216912, '2019-08-31 22:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 50 del escalamiento de NIVEL 1 en el reporte: 6141- a 172:27:54', 'N', 'N'),
(216913, '2019-08-31 22:58:20', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(216914, '2019-08-31 23:01:08', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 5 de alerta para el reporte: 6142- a 0:15:00', 'N', 'N'),
(216915, '2019-08-31 23:01:08', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86548620 *R5 0:15:00', 'N', 'N'),
(216916, '2019-08-31 23:01:09', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(216917, '2019-08-31 23:01:11', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(216918, '2019-08-31 23:04:08', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 6 de alerta para el reporte: 6142- a 0:18:00', 'N', 'N'),
(216919, '2019-08-31 23:04:11', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86548620 *R6 0:18:00', 'N', 'N'),
(216920, '2019-08-31 23:04:12', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(216921, '2019-08-31 23:04:14', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(216922, '2019-08-31 23:07:09', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 7 de alerta para el reporte: 6142- a 0:21:01', 'N', 'N'),
(216923, '2019-08-31 23:07:14', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86548620 *R7 0:21:01', 'N', 'N'),
(216924, '2019-08-31 23:07:14', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(216925, '2019-08-31 23:07:17', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(216926, '2019-08-31 23:10:10', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 8 de alerta para el reporte: 6142- a 0:24:02', 'N', 'N'),
(216927, '2019-08-31 23:10:17', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86548620 *R8 0:24:02', 'N', 'N'),
(216928, '2019-08-31 23:10:17', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(216929, '2019-08-31 23:10:20', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(216930, '2019-08-31 23:13:11', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 9 de alerta para el reporte: 6142- a 0:27:02', 'N', 'N'),
(216931, '2019-08-31 23:13:19', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86548620 *R9 0:27:02', 'N', 'N'),
(216932, '2019-08-31 23:13:20', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(216933, '2019-08-31 23:13:23', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(216934, '2019-08-31 23:16:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea escalamiento de NIVEL 1 en el reporte: 6142- a 0:30:00', 'N', 'N'),
(216935, '2019-08-31 23:16:12', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86548620 *E1 0:30:00', 'N', 'N'),
(216936, '2019-08-31 23:16:12', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(216937, '2019-08-31 23:16:15', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216938, '2019-08-31 23:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 49 del escalamiento de NIVEL 3 en el reporte: 6141- a 172:57:54', 'N', 'N'),
(216939, '2019-08-31 23:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 50 del escalamiento de NIVEL 2 en el reporte: 6141- a 172:57:54', 'N', 'N'),
(216940, '2019-08-31 23:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 51 del escalamiento de NIVEL 1 en el reporte: 6141- a 172:57:54', 'N', 'N'),
(216941, '2019-08-31 23:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea escalamiento de NIVEL 2 en el reporte: 6142- a 1:00:00', 'N', 'N'),
(216942, '2019-08-31 23:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 1 del escalamiento de NIVEL 1 en el reporte: 6142- a 1:00:00', 'N', 'N'),
(216943, '2019-08-31 23:46:21', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216944, '2019-08-31 23:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 50 del escalamiento de NIVEL 3 en el reporte: 6141- a 173:27:54', 'N', 'N'),
(216945, '2019-08-31 23:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 51 del escalamiento de NIVEL 2 en el reporte: 6141- a 173:27:54', 'N', 'N'),
(216946, '2019-08-31 23:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 52 del escalamiento de NIVEL 1 en el reporte: 6141- a 173:27:54', 'N', 'N'),
(216947, '2019-09-01 00:16:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea escalamiento de NIVEL 3 en el reporte: 6142- a 1:30:00', 'N', 'N'),
(216948, '2019-09-01 00:16:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 1 del escalamiento de NIVEL 2 en el reporte: 6142- a 1:30:00', 'N', 'N'),
(216949, '2019-09-01 00:16:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 2 del escalamiento de NIVEL 1 en el reporte: 6142- a 1:30:00', 'N', 'N'),
(216950, '2019-09-01 00:16:12', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86548620 *E3 1:30:00', 'N', 'N'),
(216951, '2019-09-01 00:16:12', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(216952, '2019-09-01 00:16:15', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 5 notifación(es)', 'N', 'N'),
(216953, '2019-09-01 00:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 51 del escalamiento de NIVEL 3 en el reporte: 6141- a 173:57:54', 'N', 'N'),
(216954, '2019-09-01 00:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 52 del escalamiento de NIVEL 2 en el reporte: 6141- a 173:57:54', 'N', 'N'),
(216955, '2019-09-01 00:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 53 del escalamiento de NIVEL 1 en el reporte: 6141- a 173:57:54', 'N', 'N'),
(216956, '2019-09-01 00:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 1 del escalamiento de NIVEL 3 en el reporte: 6142- a 2:00:00', 'N', 'N'),
(216957, '2019-09-01 00:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 2 del escalamiento de NIVEL 2 en el reporte: 6142- a 2:00:00', 'N', 'N'),
(216958, '2019-09-01 00:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 3 del escalamiento de NIVEL 1 en el reporte: 6142- a 2:00:00', 'N', 'N'),
(216959, '2019-09-01 00:46:12', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(216960, '2019-09-01 00:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 52 del escalamiento de NIVEL 3 en el reporte: 6141- a 174:27:54', 'N', 'N'),
(216961, '2019-09-01 00:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 53 del escalamiento de NIVEL 2 en el reporte: 6141- a 174:27:54', 'N', 'N'),
(216962, '2019-09-01 00:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 54 del escalamiento de NIVEL 1 en el reporte: 6141- a 174:27:54', 'N', 'N'),
(216963, '2019-09-01 01:16:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 2 del escalamiento de NIVEL 3 en el reporte: 6142- a 2:30:00', 'N', 'N'),
(216964, '2019-09-01 01:16:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 3 del escalamiento de NIVEL 2 en el reporte: 6142- a 2:30:00', 'N', 'N'),
(216965, '2019-09-01 01:16:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 4 del escalamiento de NIVEL 1 en el reporte: 6142- a 2:30:00', 'N', 'N'),
(216966, '2019-09-01 01:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 53 del escalamiento de NIVEL 3 en el reporte: 6141- a 174:57:54', 'N', 'N'),
(216967, '2019-09-01 01:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 54 del escalamiento de NIVEL 2 en el reporte: 6141- a 174:57:54', 'N', 'N'),
(216968, '2019-09-01 01:28:18', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 55 del escalamiento de NIVEL 1 en el reporte: 6141- a 174:57:54', 'N', 'N'),
(216969, '2019-09-01 01:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 3 del escalamiento de NIVEL 3 en el reporte: 6142- a 3:00:00', 'N', 'N'),
(216970, '2019-09-01 01:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 4 del escalamiento de NIVEL 2 en el reporte: 6142- a 3:00:00', 'N', 'N'),
(216971, '2019-09-01 01:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 5 del escalamiento de NIVEL 1 en el reporte: 6142- a 3:00:00', 'N', 'N'),
(216972, '2019-09-01 01:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 54 del escalamiento de NIVEL 3 en el reporte: 6141- a 175:27:54', 'N', 'N'),
(216973, '2019-09-01 01:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 55 del escalamiento de NIVEL 2 en el reporte: 6141- a 175:27:54', 'N', 'N'),
(216974, '2019-09-01 01:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 56 del escalamiento de NIVEL 1 en el reporte: 6141- a 175:27:55', 'N', 'N'),
(216975, '2019-09-01 02:16:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 4 del escalamiento de NIVEL 3 en el reporte: 6142- a 3:30:00', 'N', 'N'),
(216976, '2019-09-01 02:16:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 5 del escalamiento de NIVEL 2 en el reporte: 6142- a 3:30:00', 'N', 'N'),
(216977, '2019-09-01 02:16:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 6 del escalamiento de NIVEL 1 en el reporte: 6142- a 3:30:00', 'N', 'N'),
(216978, '2019-09-01 02:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 55 del escalamiento de NIVEL 3 en el reporte: 6141- a 175:57:54', 'N', 'N'),
(216979, '2019-09-01 02:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 56 del escalamiento de NIVEL 2 en el reporte: 6141- a 175:57:54', 'N', 'N'),
(216980, '2019-09-01 02:28:20', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 57 del escalamiento de NIVEL 1 en el reporte: 6141- a 175:57:57', 'N', 'N'),
(216981, '2019-09-01 02:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 5 del escalamiento de NIVEL 3 en el reporte: 6142- a 4:00:00', 'N', 'N'),
(216982, '2019-09-01 02:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 6 del escalamiento de NIVEL 2 en el reporte: 6142- a 4:00:00', 'N', 'N'),
(216983, '2019-09-01 02:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 7 del escalamiento de NIVEL 1 en el reporte: 6142- a 4:00:00', 'N', 'N'),
(216984, '2019-09-01 02:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 56 del escalamiento de NIVEL 3 en el reporte: 6141- a 176:27:54', 'N', 'N'),
(216985, '2019-09-01 02:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 57 del escalamiento de NIVEL 2 en el reporte: 6141- a 176:27:54', 'N', 'N'),
(216986, '2019-09-01 02:58:20', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 58 del escalamiento de NIVEL 1 en el reporte: 6141- a 176:27:57', 'N', 'N'),
(216987, '2019-09-01 03:00:48', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 9 notifación(es)', 'N', 'N'),
(216988, '2019-09-01 03:16:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 6 del escalamiento de NIVEL 3 en el reporte: 6142- a 4:30:00', 'N', 'N'),
(216989, '2019-09-01 03:16:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 7 del escalamiento de NIVEL 2 en el reporte: 6142- a 4:30:00', 'N', 'N'),
(216990, '2019-09-01 03:16:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 8 del escalamiento de NIVEL 1 en el reporte: 6142- a 4:30:00', 'N', 'N'),
(216991, '2019-09-01 03:16:12', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(216992, '2019-09-01 03:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 57 del escalamiento de NIVEL 3 en el reporte: 6141- a 176:57:54', 'N', 'N'),
(216993, '2019-09-01 03:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 58 del escalamiento de NIVEL 2 en el reporte: 6141- a 176:57:54', 'N', 'N'),
(216994, '2019-09-01 03:28:20', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 59 del escalamiento de NIVEL 1 en el reporte: 6141- a 176:57:57', 'N', 'N'),
(216995, '2019-09-01 03:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 7 del escalamiento de NIVEL 3 en el reporte: 6142- a 5:00:00', 'N', 'N'),
(216996, '2019-09-01 03:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 8 del escalamiento de NIVEL 2 en el reporte: 6142- a 5:00:00', 'N', 'N'),
(216997, '2019-09-01 03:46:08', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 9 del escalamiento de NIVEL 1 en el reporte: 6142- a 5:00:00', 'N', 'N'),
(216998, '2019-09-01 03:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 58 del escalamiento de NIVEL 3 en el reporte: 6141- a 177:27:54', 'N', 'N'),
(216999, '2019-09-01 03:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 59 del escalamiento de NIVEL 2 en el reporte: 6141- a 177:27:54', 'N', 'N'),
(217000, '2019-09-01 03:58:20', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 60 del escalamiento de NIVEL 1 en el reporte: 6141- a 177:27:57', 'N', 'N'),
(217001, '2019-09-01 04:14:10', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 3 notifación(es)', 'N', 'N'),
(217002, '2019-09-01 04:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 8 del escalamiento de NIVEL 3 en el reporte: 6142- a 5:30:00', 'N', 'N'),
(217003, '2019-09-01 04:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 9 del escalamiento de NIVEL 2 en el reporte: 6142- a 5:30:01', 'N', 'N'),
(217004, '2019-09-01 04:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 10 del escalamiento de NIVEL 1 en el reporte: 6142- a 5:30:01', 'N', 'N'),
(217005, '2019-09-01 04:16:12', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(217006, '2019-09-01 04:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 59 del escalamiento de NIVEL 3 en el reporte: 6141- a 177:57:54', 'N', 'N'),
(217007, '2019-09-01 04:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 60 del escalamiento de NIVEL 2 en el reporte: 6141- a 177:57:54', 'N', 'N'),
(217008, '2019-09-01 04:28:20', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 61 del escalamiento de NIVEL 1 en el reporte: 6141- a 177:57:57', 'N', 'N'),
(217009, '2019-09-01 04:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 9 del escalamiento de NIVEL 3 en el reporte: 6142- a 6:00:01', 'N', 'N'),
(217010, '2019-09-01 04:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 10 del escalamiento de NIVEL 2 en el reporte: 6142- a 6:00:01', 'N', 'N'),
(217011, '2019-09-01 04:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 11 del escalamiento de NIVEL 1 en el reporte: 6142- a 6:00:01', 'N', 'N'),
(217012, '2019-09-01 04:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 60 del escalamiento de NIVEL 3 en el reporte: 6141- a 178:27:54', 'N', 'N'),
(217013, '2019-09-01 04:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 61 del escalamiento de NIVEL 2 en el reporte: 6141- a 178:27:54', 'N', 'N'),
(217014, '2019-09-01 04:58:20', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 62 del escalamiento de NIVEL 1 en el reporte: 6141- a 178:27:57', 'N', 'N'),
(217015, '2019-09-01 05:04:03', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 3 notifación(es)', 'N', 'N'),
(217016, '2019-09-01 05:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 10 del escalamiento de NIVEL 3 en el reporte: 6142- a 6:30:01', 'N', 'N'),
(217017, '2019-09-01 05:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 11 del escalamiento de NIVEL 2 en el reporte: 6142- a 6:30:01', 'N', 'N'),
(217018, '2019-09-01 05:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 12 del escalamiento de NIVEL 1 en el reporte: 6142- a 6:30:01', 'N', 'N'),
(217019, '2019-09-01 05:16:14', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(217020, '2019-09-01 05:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 61 del escalamiento de NIVEL 3 en el reporte: 6141- a 178:57:54', 'N', 'N'),
(217021, '2019-09-01 05:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 62 del escalamiento de NIVEL 2 en el reporte: 6141- a 178:57:54', 'N', 'N'),
(217022, '2019-09-01 05:28:20', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 63 del escalamiento de NIVEL 1 en el reporte: 6141- a 178:57:57', 'N', 'N'),
(217023, '2019-09-01 05:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 11 del escalamiento de NIVEL 3 en el reporte: 6142- a 7:00:01', 'N', 'N'),
(217024, '2019-09-01 05:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 12 del escalamiento de NIVEL 2 en el reporte: 6142- a 7:00:01', 'N', 'N');
INSERT INTO `log` (`id`, `fecha`, `aplicacion`, `tipo`, `tiempo`, `reporte`, `intentados`, `enviados`, `texto`, `visto`, `visto_pc`) VALUES
(217025, '2019-09-01 05:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 13 del escalamiento de NIVEL 1 en el reporte: 6142- a 7:00:01', 'N', 'N'),
(217026, '2019-09-01 05:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 62 del escalamiento de NIVEL 3 en el reporte: 6141- a 179:27:54', 'N', 'N'),
(217027, '2019-09-01 05:58:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 63 del escalamiento de NIVEL 2 en el reporte: 6141- a 179:27:54', 'N', 'N'),
(217028, '2019-09-01 05:58:20', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 64 del escalamiento de NIVEL 1 en el reporte: 6141- a 179:27:57', 'N', 'N'),
(217029, '2019-09-01 06:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 12 del escalamiento de NIVEL 3 en el reporte: 6142- a 7:30:01', 'N', 'N'),
(217030, '2019-09-01 06:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 13 del escalamiento de NIVEL 2 en el reporte: 6142- a 7:30:01', 'N', 'N'),
(217031, '2019-09-01 06:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 14 del escalamiento de NIVEL 1 en el reporte: 6142- a 7:30:01', 'N', 'N'),
(217032, '2019-09-01 06:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 63 del escalamiento de NIVEL 3 en el reporte: 6141- a 179:57:54', 'N', 'N'),
(217033, '2019-09-01 06:28:17', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 64 del escalamiento de NIVEL 2 en el reporte: 6141- a 179:57:54', 'N', 'N'),
(217034, '2019-09-01 06:28:20', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 65 del escalamiento de NIVEL 1 en el reporte: 6141- a 179:57:57', 'N', 'N'),
(217035, '2019-09-01 06:37:51', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 5 notifación(es)', 'N', 'N'),
(217036, '2019-09-01 06:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 13 del escalamiento de NIVEL 3 en el reporte: 6142- a 8:00:01', 'N', 'N'),
(217037, '2019-09-01 06:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 14 del escalamiento de NIVEL 2 en el reporte: 6142- a 8:00:01', 'N', 'N'),
(217038, '2019-09-01 06:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 15 del escalamiento de NIVEL 1 en el reporte: 6142- a 8:00:01', 'N', 'N'),
(217039, '2019-09-01 06:46:19', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(217040, '2019-09-01 06:58:18', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 64 del escalamiento de NIVEL 3 en el reporte: 6141- a 180:27:54', 'N', 'N'),
(217041, '2019-09-01 06:58:18', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 65 del escalamiento de NIVEL 2 en el reporte: 6141- a 180:27:55', 'N', 'N'),
(217042, '2019-09-01 06:58:20', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 66 del escalamiento de NIVEL 1 en el reporte: 6141- a 180:27:57', 'N', 'N'),
(217043, '2019-09-01 07:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 14 del escalamiento de NIVEL 3 en el reporte: 6142- a 8:30:01', 'N', 'N'),
(217044, '2019-09-01 07:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 15 del escalamiento de NIVEL 2 en el reporte: 6142- a 8:30:01', 'N', 'N'),
(217045, '2019-09-01 07:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 16 del escalamiento de NIVEL 1 en el reporte: 6142- a 8:30:01', 'N', 'N'),
(217046, '2019-09-01 07:16:12', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(217047, '2019-09-01 07:28:18', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 65 del escalamiento de NIVEL 3 en el reporte: 6141- a 180:57:55', 'N', 'N'),
(217048, '2019-09-01 07:28:18', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 66 del escalamiento de NIVEL 2 en el reporte: 6141- a 180:57:55', 'N', 'N'),
(217049, '2019-09-01 07:28:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 67 del escalamiento de NIVEL 1 en el reporte: 6141- a 180:57:58', 'N', 'N'),
(217050, '2019-09-01 07:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 15 del escalamiento de NIVEL 3 en el reporte: 6142- a 9:00:01', 'N', 'N'),
(217051, '2019-09-01 07:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 16 del escalamiento de NIVEL 2 en el reporte: 6142- a 9:00:01', 'N', 'N'),
(217052, '2019-09-01 07:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 17 del escalamiento de NIVEL 1 en el reporte: 6142- a 9:00:01', 'N', 'N'),
(217053, '2019-09-01 07:58:18', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 66 del escalamiento de NIVEL 3 en el reporte: 6141- a 181:27:55', 'N', 'N'),
(217054, '2019-09-01 07:58:18', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 67 del escalamiento de NIVEL 2 en el reporte: 6141- a 181:27:55', 'N', 'N'),
(217055, '2019-09-01 07:58:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 68 del escalamiento de NIVEL 1 en el reporte: 6141- a 181:27:58', 'N', 'N'),
(217056, '2019-09-01 08:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 16 del escalamiento de NIVEL 3 en el reporte: 6142- a 9:30:01', 'N', 'N'),
(217057, '2019-09-01 08:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 17 del escalamiento de NIVEL 2 en el reporte: 6142- a 9:30:01', 'N', 'N'),
(217058, '2019-09-01 08:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 18 del escalamiento de NIVEL 1 en el reporte: 6142- a 9:30:01', 'N', 'N'),
(217059, '2019-09-01 08:28:18', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 67 del escalamiento de NIVEL 3 en el reporte: 6141- a 181:57:55', 'N', 'N'),
(217060, '2019-09-01 08:28:18', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 68 del escalamiento de NIVEL 2 en el reporte: 6141- a 181:57:55', 'N', 'N'),
(217061, '2019-09-01 08:28:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 69 del escalamiento de NIVEL 1 en el reporte: 6141- a 181:57:58', 'N', 'N'),
(217062, '2019-09-01 08:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 17 del escalamiento de NIVEL 3 en el reporte: 6142- a 10:00:01', 'N', 'N'),
(217063, '2019-09-01 08:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 18 del escalamiento de NIVEL 2 en el reporte: 6142- a 10:00:01', 'N', 'N'),
(217064, '2019-09-01 08:46:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 19 del escalamiento de NIVEL 1 en el reporte: 6142- a 10:00:01', 'N', 'N'),
(217065, '2019-09-01 08:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 68 del escalamiento de NIVEL 3 en el reporte: 6141- a 182:27:56', 'N', 'N'),
(217066, '2019-09-01 08:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 69 del escalamiento de NIVEL 2 en el reporte: 6141- a 182:27:56', 'N', 'N'),
(217067, '2019-09-01 08:58:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 70 del escalamiento de NIVEL 1 en el reporte: 6141- a 182:27:58', 'N', 'N'),
(217068, '2019-09-01 09:05:00', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 7 notifación(es)', 'N', 'N'),
(217069, '2019-09-01 09:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 18 del escalamiento de NIVEL 3 en el reporte: 6142- a 10:30:01', 'N', 'N'),
(217070, '2019-09-01 09:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 19 del escalamiento de NIVEL 2 en el reporte: 6142- a 10:30:01', 'N', 'N'),
(217071, '2019-09-01 09:16:09', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 20 del escalamiento de NIVEL 1 en el reporte: 6142- a 10:30:01', 'N', 'N'),
(217072, '2019-09-01 09:16:19', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(217073, '2019-09-01 09:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 69 del escalamiento de NIVEL 3 en el reporte: 6141- a 182:57:56', 'N', 'N'),
(217074, '2019-09-01 09:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 70 del escalamiento de NIVEL 2 en el reporte: 6141- a 182:57:56', 'N', 'N'),
(217075, '2019-09-01 09:28:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 71 del escalamiento de NIVEL 1 en el reporte: 6141- a 182:57:58', 'N', 'N'),
(217076, '2019-09-01 09:46:10', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 19 del escalamiento de NIVEL 3 en el reporte: 6142- a 11:00:02', 'N', 'N'),
(217077, '2019-09-01 09:46:10', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 20 del escalamiento de NIVEL 2 en el reporte: 6142- a 11:00:02', 'N', 'N'),
(217078, '2019-09-01 09:46:10', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 21 del escalamiento de NIVEL 1 en el reporte: 6142- a 11:00:02', 'N', 'N'),
(217079, '2019-09-01 09:46:19', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(217080, '2019-09-01 09:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 70 del escalamiento de NIVEL 3 en el reporte: 6141- a 183:27:56', 'N', 'N'),
(217081, '2019-09-01 09:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 71 del escalamiento de NIVEL 2 en el reporte: 6141- a 183:27:56', 'N', 'N'),
(217082, '2019-09-01 09:58:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 72 del escalamiento de NIVEL 1 en el reporte: 6141- a 183:27:58', 'N', 'N'),
(217083, '2019-09-01 10:05:32', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217084, '2019-09-01 10:06:13', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217085, '2019-09-01 10:08:26', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217086, '2019-09-01 10:16:10', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 20 del escalamiento de NIVEL 3 en el reporte: 6142- a 11:30:02', 'N', 'N'),
(217087, '2019-09-01 10:16:10', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 21 del escalamiento de NIVEL 2 en el reporte: 6142- a 11:30:02', 'N', 'N'),
(217088, '2019-09-01 10:16:10', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 22 del escalamiento de NIVEL 1 en el reporte: 6142- a 11:30:02', 'N', 'N'),
(217089, '2019-09-01 10:20:23', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(217090, '2019-09-01 10:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 71 del escalamiento de NIVEL 3 en el reporte: 6141- a 183:57:56', 'N', 'N'),
(217091, '2019-09-01 10:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 72 del escalamiento de NIVEL 2 en el reporte: 6141- a 183:57:56', 'N', 'N'),
(217092, '2019-09-01 10:28:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 73 del escalamiento de NIVEL 1 en el reporte: 6141- a 183:57:58', 'N', 'N'),
(217093, '2019-09-01 10:46:10', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 21 del escalamiento de NIVEL 3 en el reporte: 6142- a 12:00:02', 'N', 'N'),
(217094, '2019-09-01 10:46:10', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 22 del escalamiento de NIVEL 2 en el reporte: 6142- a 12:00:02', 'N', 'N'),
(217095, '2019-09-01 10:46:10', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 23 del escalamiento de NIVEL 1 en el reporte: 6142- a 12:00:02', 'N', 'N'),
(217096, '2019-09-01 10:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 72 del escalamiento de NIVEL 3 en el reporte: 6141- a 184:27:56', 'N', 'N'),
(217097, '2019-09-01 10:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 73 del escalamiento de NIVEL 2 en el reporte: 6141- a 184:27:56', 'N', 'N'),
(217098, '2019-09-01 10:58:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 74 del escalamiento de NIVEL 1 en el reporte: 6141- a 184:27:58', 'N', 'N'),
(217099, '2019-09-01 11:16:10', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 22 del escalamiento de NIVEL 3 en el reporte: 6142- a 12:30:02', 'N', 'N'),
(217100, '2019-09-01 11:16:10', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 23 del escalamiento de NIVEL 2 en el reporte: 6142- a 12:30:02', 'N', 'N'),
(217101, '2019-09-01 11:16:10', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 24 del escalamiento de NIVEL 1 en el reporte: 6142- a 12:30:02', 'N', 'N'),
(217102, '2019-09-01 11:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 73 del escalamiento de NIVEL 3 en el reporte: 6141- a 184:57:56', 'N', 'N'),
(217103, '2019-09-01 11:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 74 del escalamiento de NIVEL 2 en el reporte: 6141- a 184:57:56', 'N', 'N'),
(217104, '2019-09-01 11:28:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 75 del escalamiento de NIVEL 1 en el reporte: 6141- a 184:57:58', 'N', 'N'),
(217105, '2019-09-01 11:30:52', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 5 notifación(es)', 'N', 'N'),
(217106, '2019-09-01 11:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 23 del escalamiento de NIVEL 3 en el reporte: 6142- a 13:00:03', 'N', 'N'),
(217107, '2019-09-01 11:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 24 del escalamiento de NIVEL 2 en el reporte: 6142- a 13:00:03', 'N', 'N'),
(217108, '2019-09-01 11:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 25 del escalamiento de NIVEL 1 en el reporte: 6142- a 13:00:03', 'N', 'N'),
(217109, '2019-09-01 11:46:18', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(217110, '2019-09-01 11:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 74 del escalamiento de NIVEL 3 en el reporte: 6141- a 185:27:56', 'N', 'N'),
(217111, '2019-09-01 11:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 75 del escalamiento de NIVEL 2 en el reporte: 6141- a 185:27:56', 'N', 'N'),
(217112, '2019-09-01 11:58:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 76 del escalamiento de NIVEL 1 en el reporte: 6141- a 185:27:58', 'N', 'N'),
(217113, '2019-09-01 12:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 24 del escalamiento de NIVEL 3 en el reporte: 6142- a 13:30:03', 'N', 'N'),
(217114, '2019-09-01 12:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 25 del escalamiento de NIVEL 2 en el reporte: 6142- a 13:30:03', 'N', 'N'),
(217115, '2019-09-01 12:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 26 del escalamiento de NIVEL 1 en el reporte: 6142- a 13:30:03', 'N', 'N'),
(217116, '2019-09-01 12:16:17', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(217117, '2019-09-01 12:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 75 del escalamiento de NIVEL 3 en el reporte: 6141- a 185:57:56', 'N', 'N'),
(217118, '2019-09-01 12:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 76 del escalamiento de NIVEL 2 en el reporte: 6141- a 185:57:56', 'N', 'N'),
(217119, '2019-09-01 12:28:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 77 del escalamiento de NIVEL 1 en el reporte: 6141- a 185:57:58', 'N', 'N'),
(217120, '2019-09-01 12:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 25 del escalamiento de NIVEL 3 en el reporte: 6142- a 14:00:03', 'N', 'N'),
(217121, '2019-09-01 12:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 26 del escalamiento de NIVEL 2 en el reporte: 6142- a 14:00:03', 'N', 'N'),
(217122, '2019-09-01 12:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 27 del escalamiento de NIVEL 1 en el reporte: 6142- a 14:00:03', 'N', 'N'),
(217123, '2019-09-01 12:46:18', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(217124, '2019-09-01 12:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 76 del escalamiento de NIVEL 3 en el reporte: 6141- a 186:27:56', 'N', 'N'),
(217125, '2019-09-01 12:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 77 del escalamiento de NIVEL 2 en el reporte: 6141- a 186:27:56', 'N', 'N'),
(217126, '2019-09-01 12:58:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 78 del escalamiento de NIVEL 1 en el reporte: 6141- a 186:27:58', 'N', 'N'),
(217127, '2019-09-01 13:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 26 del escalamiento de NIVEL 3 en el reporte: 6142- a 14:30:03', 'N', 'N'),
(217128, '2019-09-01 13:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 27 del escalamiento de NIVEL 2 en el reporte: 6142- a 14:30:03', 'N', 'N'),
(217129, '2019-09-01 13:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 28 del escalamiento de NIVEL 1 en el reporte: 6142- a 14:30:03', 'N', 'N'),
(217130, '2019-09-01 13:16:23', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(217131, '2019-09-01 13:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 77 del escalamiento de NIVEL 3 en el reporte: 6141- a 186:57:56', 'N', 'N'),
(217132, '2019-09-01 13:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 78 del escalamiento de NIVEL 2 en el reporte: 6141- a 186:57:56', 'N', 'N'),
(217133, '2019-09-01 13:28:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 79 del escalamiento de NIVEL 1 en el reporte: 6141- a 186:57:58', 'N', 'N'),
(217134, '2019-09-01 13:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 27 del escalamiento de NIVEL 3 en el reporte: 6142- a 15:00:03', 'N', 'N'),
(217135, '2019-09-01 13:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 28 del escalamiento de NIVEL 2 en el reporte: 6142- a 15:00:03', 'N', 'N'),
(217136, '2019-09-01 13:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 29 del escalamiento de NIVEL 1 en el reporte: 6142- a 15:00:03', 'N', 'N'),
(217137, '2019-09-01 13:46:18', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(217138, '2019-09-01 13:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 78 del escalamiento de NIVEL 3 en el reporte: 6141- a 187:27:56', 'N', 'N'),
(217139, '2019-09-01 13:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 79 del escalamiento de NIVEL 2 en el reporte: 6141- a 187:27:56', 'N', 'N'),
(217140, '2019-09-01 13:58:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 80 del escalamiento de NIVEL 1 en el reporte: 6141- a 187:27:58', 'N', 'N'),
(217141, '2019-09-01 14:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 28 del escalamiento de NIVEL 3 en el reporte: 6142- a 15:30:03', 'N', 'N'),
(217142, '2019-09-01 14:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 29 del escalamiento de NIVEL 2 en el reporte: 6142- a 15:30:03', 'N', 'N'),
(217143, '2019-09-01 14:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 30 del escalamiento de NIVEL 1 en el reporte: 6142- a 15:30:03', 'N', 'N'),
(217144, '2019-09-01 14:16:23', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(217145, '2019-09-01 14:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 79 del escalamiento de NIVEL 3 en el reporte: 6141- a 187:57:56', 'N', 'N'),
(217146, '2019-09-01 14:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 80 del escalamiento de NIVEL 2 en el reporte: 6141- a 187:57:56', 'N', 'N'),
(217147, '2019-09-01 14:28:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 81 del escalamiento de NIVEL 1 en el reporte: 6141- a 187:57:58', 'N', 'N'),
(217148, '2019-09-01 14:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 29 del escalamiento de NIVEL 3 en el reporte: 6142- a 16:00:03', 'N', 'N'),
(217149, '2019-09-01 14:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 30 del escalamiento de NIVEL 2 en el reporte: 6142- a 16:00:03', 'N', 'N'),
(217150, '2019-09-01 14:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 31 del escalamiento de NIVEL 1 en el reporte: 6142- a 16:00:03', 'N', 'N'),
(217151, '2019-09-01 14:46:16', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(217152, '2019-09-01 14:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 80 del escalamiento de NIVEL 3 en el reporte: 6141- a 188:27:56', 'N', 'N'),
(217153, '2019-09-01 14:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 81 del escalamiento de NIVEL 2 en el reporte: 6141- a 188:27:56', 'N', 'N'),
(217154, '2019-09-01 14:58:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 82 del escalamiento de NIVEL 1 en el reporte: 6141- a 188:27:58', 'N', 'N'),
(217155, '2019-09-01 15:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 30 del escalamiento de NIVEL 3 en el reporte: 6142- a 16:30:03', 'N', 'N'),
(217156, '2019-09-01 15:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 31 del escalamiento de NIVEL 2 en el reporte: 6142- a 16:30:03', 'N', 'N'),
(217157, '2019-09-01 15:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 32 del escalamiento de NIVEL 1 en el reporte: 6142- a 16:30:03', 'N', 'N'),
(217158, '2019-09-01 15:16:24', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(217159, '2019-09-01 15:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 81 del escalamiento de NIVEL 3 en el reporte: 6141- a 188:57:56', 'N', 'N'),
(217160, '2019-09-01 15:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 82 del escalamiento de NIVEL 2 en el reporte: 6141- a 188:57:56', 'N', 'N'),
(217161, '2019-09-01 15:28:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 83 del escalamiento de NIVEL 1 en el reporte: 6141- a 188:57:58', 'N', 'N'),
(217162, '2019-09-01 15:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 31 del escalamiento de NIVEL 3 en el reporte: 6142- a 17:00:03', 'N', 'N'),
(217163, '2019-09-01 15:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 32 del escalamiento de NIVEL 2 en el reporte: 6142- a 17:00:03', 'N', 'N'),
(217164, '2019-09-01 15:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 33 del escalamiento de NIVEL 1 en el reporte: 6142- a 17:00:03', 'N', 'N'),
(217165, '2019-09-01 15:46:17', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(217166, '2019-09-01 15:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 82 del escalamiento de NIVEL 3 en el reporte: 6141- a 189:27:56', 'N', 'N'),
(217167, '2019-09-01 15:58:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 83 del escalamiento de NIVEL 2 en el reporte: 6141- a 189:27:56', 'N', 'N'),
(217168, '2019-09-01 15:58:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 84 del escalamiento de NIVEL 1 en el reporte: 6141- a 189:27:58', 'N', 'N'),
(217169, '2019-09-01 16:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 32 del escalamiento de NIVEL 3 en el reporte: 6142- a 17:30:03', 'N', 'N'),
(217170, '2019-09-01 16:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 33 del escalamiento de NIVEL 2 en el reporte: 6142- a 17:30:03', 'N', 'N'),
(217171, '2019-09-01 16:16:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 34 del escalamiento de NIVEL 1 en el reporte: 6142- a 17:30:03', 'N', 'N'),
(217172, '2019-09-01 16:16:19', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 2 notifación(es)', 'N', 'N'),
(217173, '2019-09-01 16:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 83 del escalamiento de NIVEL 3 en el reporte: 6141- a 189:57:56', 'N', 'N'),
(217174, '2019-09-01 16:28:19', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 84 del escalamiento de NIVEL 2 en el reporte: 6141- a 189:57:56', 'N', 'N'),
(217175, '2019-09-01 16:28:21', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 85 del escalamiento de NIVEL 1 en el reporte: 6141- a 189:57:58', 'N', 'N'),
(217176, '2019-09-01 16:45:06', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217177, '2019-09-01 16:46:07', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217178, '2019-09-01 16:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 33 del escalamiento de NIVEL 3 en el reporte: 6142- a 18:00:03', 'N', 'N'),
(217179, '2019-09-01 16:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 34 del escalamiento de NIVEL 2 en el reporte: 6142- a 18:00:03', 'N', 'N'),
(217180, '2019-09-01 16:46:11', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 35 del escalamiento de NIVEL 1 en el reporte: 6142- a 18:00:03', 'N', 'N'),
(217181, '2019-09-01 16:46:28', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217182, '2019-09-01 16:46:38', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217183, '2019-09-01 16:48:50', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217184, '2019-09-02 13:55:56', 0, 1, NULL, 0, NULL, NULL, 'Se incicia el programa', 'N', 'N'),
(217185, '2019-09-02 13:55:56', 0, 1, NULL, 0, NULL, NULL, 'Se inicia la aplicación de Envío de correos', 'N', 'N'),
(217186, '2019-09-02 13:55:56', 0, 1, NULL, 0, NULL, NULL, 'Conexión satisfactoria a MySQL', 'N', 'N'),
(217187, '2019-09-02 13:55:56', 0, 7, NULL, 0, NULL, NULL, 'Se ejecutó la depuración de la base de datos para el período septiembre-2019 (todo lo anterior al día: 2018/09/01). Se eliminaron permanentemente 0 registro(s)', 'N', 'N'),
(217188, '2019-09-02 13:55:57', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 84 del escalamiento de NIVEL 3 en el reporte: 6141- a 211:25:34', 'N', 'N'),
(217189, '2019-09-02 13:55:57', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 34 del escalamiento de NIVEL 3 en el reporte: 6142- a 39:09:49', 'N', 'N'),
(217190, '2019-09-02 13:55:57', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 85 del escalamiento de NIVEL 2 en el reporte: 6141- a 211:25:34', 'N', 'N'),
(217191, '2019-09-02 13:55:57', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 35 del escalamiento de NIVEL 2 en el reporte: 6142- a 39:09:49', 'N', 'N'),
(217192, '2019-09-02 13:55:57', 0, 1, NULL, 6141, NULL, NULL, 'Se crea una repetición 86 del escalamiento de NIVEL 1 en el reporte: 6141- a 211:25:34', 'N', 'N'),
(217193, '2019-09-02 13:55:57', 0, 1, NULL, 6142, NULL, NULL, 'Se crea una repetición 36 del escalamiento de NIVEL 1 en el reporte: 6142- a 39:09:49', 'N', 'N'),
(217194, '2019-09-02 13:56:12', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 4 notifación(es)', 'N', 'N'),
(217195, '2019-09-02 15:04:38', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217196, '2019-09-02 15:04:45', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217197, '2019-09-02 16:44:50', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217198, '2019-09-02 16:47:01', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217199, '2019-09-02 16:53:49', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217200, '2019-09-02 17:18:26', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217201, '2019-09-02 17:20:14', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217202, '2019-09-02 17:20:14', 0, 1, NULL, 6143, NULL, NULL, 'Se ha creado el reporte: 6143', 'N', 'N'),
(217203, '2019-09-02 17:20:18', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=SALTO. LOTE  86548610. REF  70039540', 'N', 'N'),
(217204, '2019-09-02 17:20:18', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217205, '2019-09-02 17:20:22', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(217206, '2019-09-02 17:27:05', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217207, '2019-09-02 17:27:12', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217208, '2019-09-02 17:27:20', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217209, '2019-09-02 17:27:20', 0, 1, NULL, 6144, NULL, NULL, 'Se ha creado el reporte: 6144', 'N', 'N'),
(217210, '2019-09-02 17:27:25', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=SALTO. LOTE  86548629. REF  70039540', 'N', 'N'),
(217211, '2019-09-02 17:27:25', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217212, '2019-09-02 17:27:28', 20, 1, NULL, 0, NULL, NULL, 'Se  envío 1 correo electrónico  que incluye(n) 1 notifación(es)', 'N', 'N'),
(217213, '2019-09-02 18:15:56', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217214, '2019-09-02 18:16:24', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217215, '2019-09-02 18:20:04', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217216, '2019-09-02 18:20:13', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217217, '2019-09-02 18:29:12', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217218, '2019-09-02 18:30:45', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217219, '2019-09-02 19:59:45', 0, 1, NULL, 6145, NULL, NULL, 'Se ha creado el reporte: 6145', 'N', 'N'),
(217220, '2019-09-02 19:59:49', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=PLAN/EXCEDIDO CARGA # 002', 'N', 'N'),
(217221, '2019-09-02 19:59:49', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217222, '2019-09-02 19:59:53', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217223, '2019-09-02 23:18:53', 0, 1, NULL, 6146, NULL, NULL, 'Se ha creado el reporte: 6146', 'N', 'N'),
(217224, '2019-09-02 23:19:02', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=PROC/EXCED L-86551364', 'N', 'N'),
(217225, '2019-09-02 23:19:03', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217226, '2019-09-02 23:19:07', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217227, '2019-09-03 14:23:37', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217228, '2019-09-03 14:49:28', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217229, '2019-09-03 14:50:10', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217230, '2019-09-03 14:50:25', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217231, '2019-09-03 14:51:29', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217232, '2019-09-03 14:51:52', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217233, '2019-09-03 14:53:34', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217234, '2019-09-03 14:54:01', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217235, '2019-09-03 14:54:30', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217236, '2019-09-03 14:54:30', 0, 1, NULL, 6147, NULL, NULL, 'Se ha creado el reporte: 6147', 'N', 'N'),
(217237, '2019-09-03 14:54:40', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=SALTO. LOTE  86546473. REF  70052840', 'N', 'N'),
(217238, '2019-09-03 14:54:41', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217239, '2019-09-03 14:54:46', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217240, '2019-09-03 14:56:51', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217241, '2019-09-03 14:57:32', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217242, '2019-09-03 14:57:32', 0, 1, NULL, 6148, NULL, NULL, 'Se ha creado el reporte: 6148', 'N', 'N'),
(217243, '2019-09-03 14:57:34', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=SALTO. LOTE  86546473. REF  70052840', 'N', 'N'),
(217244, '2019-09-03 14:57:34', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217245, '2019-09-03 14:57:40', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217246, '2019-09-03 15:04:54', 0, 1, NULL, 6149, NULL, NULL, 'Se ha creado el reporte: 6149', 'N', 'N'),
(217247, '2019-09-03 15:05:01', 0, 1, NULL, 6150, NULL, NULL, 'Se ha creado el reporte: 6150', 'N', 'N'),
(217248, '2019-09-03 15:05:02', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=USTED TIENE 2 mensaje(s) POR ATENDER', 'N', 'N'),
(217249, '2019-09-03 15:05:02', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (2 notifación(es))', 'N', 'N'),
(217250, '2019-09-03 15:05:06', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 4 notifación(es)', 'N', 'N'),
(217251, '2019-09-03 15:07:54', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 1 de alerta para el reporte: 6149- a 0:03:00', 'N', 'N'),
(217252, '2019-09-03 15:07:55', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-70039540 *R1 0:03:00', 'N', 'N'),
(217253, '2019-09-03 15:07:55', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217254, '2019-09-03 15:07:59', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217255, '2019-09-03 15:08:01', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 1 de alerta para el reporte: 6150- a 0:03:00', 'N', 'N'),
(217256, '2019-09-03 15:08:05', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86546441 *R1 0:03:00', 'N', 'N'),
(217257, '2019-09-03 15:08:05', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217258, '2019-09-03 15:08:10', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217259, '2019-09-03 15:10:54', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 2 de alerta para el reporte: 6149- a 0:06:00', 'N', 'N'),
(217260, '2019-09-03 15:10:58', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-70039540 *R2 0:06:00', 'N', 'N'),
(217261, '2019-09-03 15:10:58', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217262, '2019-09-03 15:11:01', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 2 de alerta para el reporte: 6150- a 0:06:00', 'N', 'N'),
(217263, '2019-09-03 15:11:03', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217264, '2019-09-03 15:11:08', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86546441 *R2 0:06:00', 'N', 'N'),
(217265, '2019-09-03 15:11:09', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217266, '2019-09-03 15:13:54', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 3 de alerta para el reporte: 6149- a 0:09:00', 'N', 'N'),
(217267, '2019-09-03 15:14:01', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 3 de alerta para el reporte: 6150- a 0:09:00', 'N', 'N'),
(217268, '2019-09-03 15:14:02', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=USTED TIENE 2 mensaje(s) POR ATENDER', 'N', 'N'),
(217269, '2019-09-03 15:14:02', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (2 notifación(es))', 'N', 'N'),
(217270, '2019-09-03 15:14:06', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 4 notifación(es)', 'N', 'N'),
(217271, '2019-09-03 15:16:54', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 4 de alerta para el reporte: 6149- a 0:12:00', 'N', 'N'),
(217272, '2019-09-03 15:16:55', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-70039540 *R4 0:12:00', 'N', 'N'),
(217273, '2019-09-03 15:16:55', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217274, '2019-09-03 15:16:59', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217275, '2019-09-03 15:17:01', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 4 de alerta para el reporte: 6150- a 0:12:00', 'N', 'N'),
(217276, '2019-09-03 15:17:05', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86546441 *R4 0:12:00', 'N', 'N'),
(217277, '2019-09-03 15:17:05', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217278, '2019-09-03 15:17:10', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217279, '2019-09-03 15:19:54', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 5 de alerta para el reporte: 6149- a 0:15:00', 'N', 'N'),
(217280, '2019-09-03 15:19:58', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-70039540 *R5 0:15:00', 'N', 'N'),
(217281, '2019-09-03 15:19:58', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217282, '2019-09-03 15:20:02', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 5 de alerta para el reporte: 6150- a 0:15:01', 'N', 'N'),
(217283, '2019-09-03 15:20:03', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217284, '2019-09-03 15:20:08', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86546441 *R5 0:15:01', 'N', 'N'),
(217285, '2019-09-03 15:20:09', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217286, '2019-09-03 15:22:54', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 6 de alerta para el reporte: 6149- a 0:18:00', 'N', 'N'),
(217287, '2019-09-03 15:23:01', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-70039540 *R6 0:18:00', 'N', 'N'),
(217288, '2019-09-03 15:23:02', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217289, '2019-09-03 15:23:02', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 6 de alerta para el reporte: 6150- a 0:18:01', 'N', 'N'),
(217290, '2019-09-03 15:23:06', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217291, '2019-09-03 15:23:12', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86546441 *R6 0:18:01', 'N', 'N'),
(217292, '2019-09-03 15:23:12', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217293, '2019-09-03 15:25:54', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 7 de alerta para el reporte: 6149- a 0:21:00', 'N', 'N'),
(217294, '2019-09-03 15:25:54', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-70039540 *R7 0:21:00', 'N', 'N'),
(217295, '2019-09-03 15:25:55', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217296, '2019-09-03 15:25:59', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217297, '2019-09-03 15:26:02', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 7 de alerta para el reporte: 6150- a 0:21:01', 'N', 'N'),
(217298, '2019-09-03 15:26:05', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86546441 *R7 0:21:01', 'N', 'N'),
(217299, '2019-09-03 15:26:05', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217300, '2019-09-03 15:26:10', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217301, '2019-09-03 15:28:54', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 8 de alerta para el reporte: 6149- a 0:24:00', 'N', 'N'),
(217302, '2019-09-03 15:28:58', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-70039540 *R8 0:24:00', 'N', 'N'),
(217303, '2019-09-03 15:28:58', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217304, '2019-09-03 15:29:02', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 8 de alerta para el reporte: 6150- a 0:24:01', 'N', 'N'),
(217305, '2019-09-03 15:29:03', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217306, '2019-09-03 15:29:08', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86546441 *R8 0:24:01', 'N', 'N'),
(217307, '2019-09-03 15:29:08', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217308, '2019-09-03 15:31:54', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 9 de alerta para el reporte: 6149- a 0:27:00', 'N', 'N'),
(217309, '2019-09-03 15:32:02', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-70039540 *R9 0:27:00', 'N', 'N'),
(217310, '2019-09-03 15:32:02', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217311, '2019-09-03 15:32:02', 0, 1, NULL, 1, NULL, NULL, 'Se envía repetición 9 de alerta para el reporte: 6150- a 0:27:01', 'N', 'N'),
(217312, '2019-09-03 15:32:06', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217313, '2019-09-03 15:32:12', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86546441 *R9 0:27:01', 'N', 'N'),
(217314, '2019-09-03 15:32:12', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217315, '2019-09-03 15:34:54', 0, 1, NULL, 6149, NULL, NULL, 'Se crea escalamiento de NIVEL 1 en el reporte: 6149- a 0:30:00', 'N', 'N'),
(217316, '2019-09-03 15:34:55', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-70039540 *E1 0:30:00', 'N', 'N'),
(217317, '2019-09-03 15:34:55', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217318, '2019-09-03 15:35:00', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 3 notifación(es)', 'N', 'N'),
(217319, '2019-09-03 15:35:01', 0, 1, NULL, 6150, NULL, NULL, 'Se crea escalamiento de NIVEL 1 en el reporte: 6150- a 0:30:00', 'N', 'N'),
(217320, '2019-09-03 15:35:05', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=STOCK/EXCED L-86546441 *E1 0:30:00', 'N', 'N'),
(217321, '2019-09-03 15:35:06', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (1 notifación(es))', 'N', 'N'),
(217322, '2019-09-03 15:35:10', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 3 notifación(es)', 'N', 'N'),
(217323, '2019-09-03 15:52:58', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 1 fechs de vencimiento en lote(s)', 'N', 'N'),
(217324, '2019-09-05 14:25:57', 0, 1, NULL, 0, NULL, NULL, 'Se incicia el programa', 'N', 'N'),
(217325, '2019-09-05 14:25:57', 0, 1, NULL, 0, NULL, NULL, 'Se inicia la aplicación de Envío de correos', 'N', 'N'),
(217326, '2019-09-05 14:25:57', 0, 1, NULL, 0, NULL, NULL, 'Conexión satisfactoria a MySQL', 'N', 'N'),
(217327, '2019-09-05 14:25:57', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) calculado: 6 fechs de vencimiento en lote(s)', 'N', 'N'),
(217328, '2019-09-05 14:26:05', 0, 1, NULL, 6149, NULL, NULL, 'Se crea escalamiento de NIVEL 2 en el reporte: 6149- a 47:21:11', 'N', 'N'),
(217329, '2019-09-05 14:26:05', 0, 1, NULL, 6150, NULL, NULL, 'Se crea escalamiento de NIVEL 2 en el reporte: 6150- a 47:21:04', 'N', 'N'),
(217330, '2019-09-05 14:26:05', 0, 1, NULL, 6149, NULL, NULL, 'Se crea una repetición 1 del escalamiento de NIVEL 1 en el reporte: 6149- a 47:21:11', 'N', 'N'),
(217331, '2019-09-05 14:26:05', 0, 1, NULL, 6150, NULL, NULL, 'Se crea una repetición 1 del escalamiento de NIVEL 1 en el reporte: 6150- a 47:21:04', 'N', 'N'),
(217332, '2019-09-05 14:26:14', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217333, '2019-09-05 14:56:05', 0, 1, NULL, 6149, NULL, NULL, 'Se crea escalamiento de NIVEL 3 en el reporte: 6149- a 47:51:11', 'N', 'N'),
(217334, '2019-09-05 14:56:05', 0, 1, NULL, 6150, NULL, NULL, 'Se crea escalamiento de NIVEL 3 en el reporte: 6150- a 47:51:04', 'N', 'N'),
(217335, '2019-09-05 14:56:05', 0, 1, NULL, 6149, NULL, NULL, 'Se crea una repetición 1 del escalamiento de NIVEL 2 en el reporte: 6149- a 47:51:11', 'N', 'N'),
(217336, '2019-09-05 14:56:05', 0, 1, NULL, 6150, NULL, NULL, 'Se crea una repetición 1 del escalamiento de NIVEL 2 en el reporte: 6150- a 47:51:04', 'N', 'N'),
(217337, '2019-09-05 14:56:05', 0, 1, NULL, 6149, NULL, NULL, 'Se crea una repetición 2 del escalamiento de NIVEL 1 en el reporte: 6149- a 47:51:11', 'N', 'N'),
(217338, '2019-09-05 14:56:05', 0, 1, NULL, 6150, NULL, NULL, 'Se crea una repetición 2 del escalamiento de NIVEL 1 en el reporte: 6150- a 47:51:04', 'N', 'N'),
(217339, '2019-09-05 14:56:06', 0, 1, NULL, 0, NULL, NULL, 'Se consume servicio de MMCall: http://localhost:8081/locations/integration/group_message/division=1&message=USTED TIENE 2 mensaje(s) POR ATENDER', 'N', 'N'),
(217340, '2019-09-05 14:56:07', 0, 1, NULL, 0, NULL, NULL, 'Se generaron 1 mensaje(s) a MMCall (2 notifación(es))', 'N', 'N'),
(217341, '2019-09-05 14:56:20', 20, 1, NULL, 0, NULL, NULL, 'Errores en la generación de correos electrónicos. No se generaron 0 correos electrónicos. Error: Error de sintaxis, comando no reconocido. La respuesta del servidor fue: 4.3.2 STOREDRV.ClientSubmit; sender thread limit exceeded [Hostname=BY5PR19MB365', 'N', 'N'),
(217342, '2019-09-05 14:56:21', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 10 correos electrónicos que incluye(n) 10 notifación(es)', 'N', 'N'),
(217343, '2019-09-05 14:56:26', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 3 correos electrónicos que incluye(n) 4 notifación(es)', 'N', 'N'),
(217344, '2019-09-05 15:26:05', 0, 1, NULL, 6149, NULL, NULL, 'Se crea una repetición 1 del escalamiento de NIVEL 3 en el reporte: 6149- a 48:21:11', 'N', 'N'),
(217345, '2019-09-05 15:26:05', 0, 1, NULL, 6150, NULL, NULL, 'Se crea una repetición 1 del escalamiento de NIVEL 3 en el reporte: 6150- a 48:21:04', 'N', 'N'),
(217346, '2019-09-05 15:26:05', 0, 1, NULL, 6149, NULL, NULL, 'Se crea una repetición 2 del escalamiento de NIVEL 2 en el reporte: 6149- a 48:21:11', 'N', 'N'),
(217347, '2019-09-05 15:26:05', 0, 1, NULL, 6150, NULL, NULL, 'Se crea una repetición 2 del escalamiento de NIVEL 2 en el reporte: 6150- a 48:21:04', 'N', 'N'),
(217348, '2019-09-05 15:26:05', 0, 1, NULL, 6149, NULL, NULL, 'Se crea una repetición 3 del escalamiento de NIVEL 1 en el reporte: 6149- a 48:21:11', 'N', 'N'),
(217349, '2019-09-05 15:26:05', 0, 1, NULL, 6150, NULL, NULL, 'Se crea una repetición 3 del escalamiento de NIVEL 1 en el reporte: 6150- a 48:21:04', 'N', 'N');
INSERT INTO `log` (`id`, `fecha`, `aplicacion`, `tipo`, `tiempo`, `reporte`, `intentados`, `enviados`, `texto`, `visto`, `visto_pc`) VALUES
(217350, '2019-09-05 15:26:22', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217351, '2019-09-05 15:56:05', 0, 1, NULL, 6149, NULL, NULL, 'Se crea una repetición 2 del escalamiento de NIVEL 3 en el reporte: 6149- a 48:51:11', 'N', 'N'),
(217352, '2019-09-05 15:56:05', 0, 1, NULL, 6150, NULL, NULL, 'Se crea una repetición 2 del escalamiento de NIVEL 3 en el reporte: 6150- a 48:51:04', 'N', 'N'),
(217353, '2019-09-05 15:56:05', 0, 1, NULL, 6149, NULL, NULL, 'Se crea una repetición 3 del escalamiento de NIVEL 2 en el reporte: 6149- a 48:51:11', 'N', 'N'),
(217354, '2019-09-05 15:56:05', 0, 1, NULL, 6150, NULL, NULL, 'Se crea una repetición 3 del escalamiento de NIVEL 2 en el reporte: 6150- a 48:51:04', 'N', 'N'),
(217355, '2019-09-05 15:56:05', 0, 1, NULL, 6149, NULL, NULL, 'Se crea una repetición 4 del escalamiento de NIVEL 1 en el reporte: 6149- a 48:51:11', 'N', 'N'),
(217356, '2019-09-05 15:56:05', 0, 1, NULL, 6150, NULL, NULL, 'Se crea una repetición 4 del escalamiento de NIVEL 1 en el reporte: 6150- a 48:51:04', 'N', 'N'),
(217357, '2019-09-05 15:56:21', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217358, '2019-09-05 16:26:05', 0, 1, NULL, 6149, NULL, NULL, 'Se crea una repetición 3 del escalamiento de NIVEL 3 en el reporte: 6149- a 49:21:11', 'N', 'N'),
(217359, '2019-09-05 16:26:05', 0, 1, NULL, 6150, NULL, NULL, 'Se crea una repetición 3 del escalamiento de NIVEL 3 en el reporte: 6150- a 49:21:04', 'N', 'N'),
(217360, '2019-09-05 16:26:05', 0, 1, NULL, 6149, NULL, NULL, 'Se crea una repetición 4 del escalamiento de NIVEL 2 en el reporte: 6149- a 49:21:11', 'N', 'N'),
(217361, '2019-09-05 16:26:05', 0, 1, NULL, 6150, NULL, NULL, 'Se crea una repetición 4 del escalamiento de NIVEL 2 en el reporte: 6150- a 49:21:04', 'N', 'N'),
(217362, '2019-09-05 16:26:05', 0, 1, NULL, 6149, NULL, NULL, 'Se crea una repetición 5 del escalamiento de NIVEL 1 en el reporte: 6149- a 49:21:11', 'N', 'N'),
(217363, '2019-09-05 16:26:05', 0, 1, NULL, 6150, NULL, NULL, 'Se crea una repetición 5 del escalamiento de NIVEL 1 en el reporte: 6150- a 49:21:04', 'N', 'N'),
(217364, '2019-09-05 16:26:11', 20, 1, NULL, 0, NULL, NULL, 'Se enviaron 2 correos electrónicos que incluye(n) 2 notifación(es)', 'N', 'N'),
(217365, '2019-09-05 16:30:00', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217366, '2019-09-05 16:30:10', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217367, '2019-09-05 16:30:20', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217368, '2019-09-05 16:30:30', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217369, '2019-09-05 16:30:40', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217370, '2019-09-05 16:30:50', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217371, '2019-09-05 16:31:00', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217372, '2019-09-05 16:31:10', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217373, '2019-09-05 16:31:20', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217374, '2019-09-05 16:31:30', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217375, '2019-09-05 16:31:40', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217376, '2019-09-05 16:31:50', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217377, '2019-09-05 16:32:00', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217378, '2019-09-05 16:32:10', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217379, '2019-09-05 16:32:20', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217380, '2019-09-05 16:32:30', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217381, '2019-09-05 16:32:40', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217382, '2019-09-05 16:32:50', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217383, '2019-09-05 16:33:00', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217384, '2019-09-05 16:33:10', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217385, '2019-09-05 16:33:20', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217386, '2019-09-05 16:33:30', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217387, '2019-09-05 16:33:40', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217388, '2019-09-05 16:33:50', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217389, '2019-09-05 16:34:00', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217390, '2019-09-05 16:34:10', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217391, '2019-09-05 16:34:20', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217392, '2019-09-05 16:34:30', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217393, '2019-09-05 16:34:40', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217394, '2019-09-05 16:34:50', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217395, '2019-09-05 16:35:00', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217396, '2019-09-05 16:35:10', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217397, '2019-09-05 16:35:20', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217398, '2019-09-05 16:35:30', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217399, '2019-09-05 16:35:40', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217400, '2019-09-05 16:35:50', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217401, '2019-09-05 16:36:00', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217402, '2019-09-05 16:36:10', 0, 7, NULL, 0, NULL, NULL, 'Error en la ejecución de la aplicación de envío de correos. Error: Archivo no encontrado.', 'N', 'N'),
(217403, '2019-09-05 16:37:44', 0, 1, NULL, 0, NULL, NULL, 'Se incicia el programa', 'N', 'N'),
(217404, '2019-09-05 16:37:44', 0, 1, NULL, 0, NULL, NULL, 'Se inicia la aplicación de Envío de correos', 'N', 'N'),
(217405, '2019-09-05 16:37:44', 0, 1, NULL, 0, NULL, NULL, 'Conexión satisfactoria a MySQL', 'N', 'N'),
(217406, '2019-09-05 16:37:44', 0, 1, NULL, 1, NULL, NULL, 'Se ha(n) transferido: 7 lote(s) a la siguiente situación', 'N', 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lotes`
--

CREATE TABLE IF NOT EXISTS `lotes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `numero` varchar(100) DEFAULT NULL COMMENT 'Número la orden de producción/proceso',
  `parte` bigint(20) DEFAULT '0' COMMENT 'ID del Número de parte',
  `fecha` datetime DEFAULT NULL COMMENT 'Fecha de entrada del lote',
  `hasta` datetime DEFAULT NULL COMMENT 'Fecha estimada de salida del proceso',
  `calcular_hasta` char(1) DEFAULT 'N' COMMENT 'Calcular el tiempo hasta del lote (N=No calcular, 1=Calcular tiempo de stock, 2=calcular tiempo de proceso)',
  `rechazo` datetime DEFAULT NULL COMMENT 'Fecha de rechazo',
  `inspeccion_id` bigint(20) DEFAULT '0' COMMENT 'Número de inspección',
  `rechazo_id` bigint(20) DEFAULT '0' COMMENT 'Número de rechazo',
  `inspeccion` datetime DEFAULT NULL COMMENT 'Fecha de inspeccion',
  `inspecciones` int(4) DEFAULT '0' COMMENT 'Veces que se inspecciona',
  `rechazos` int(4) DEFAULT '0' COMMENT 'Veces que se rechaza',
  `alarmas` int(4) DEFAULT '0' COMMENT 'Cantidas de alarmas en el lote',
  `reversos` int(4) DEFAULT '0' COMMENT 'Veces que se reversó',
  `proceso` bigint(20) DEFAULT '0' COMMENT 'ID del proceso',
  `equipo` bigint(20) DEFAULT '0' COMMENT 'ID del equipo',
  `ruta` bigint(20) DEFAULT '0' COMMENT 'ID de la ruta',
  `ruta_detalle` bigint(20) DEFAULT '0' COMMENT 'ID del detalle de la ruta',
  `ruta_secuencia` int(6) DEFAULT '0' COMMENT 'Secuencia de la operación',
  `inicia` datetime DEFAULT NULL COMMENT 'Fecha de inicio en el sistema',
  `finaliza` datetime DEFAULT NULL COMMENT 'Fecha de fin en el sistema',
  `estimada` datetime DEFAULT NULL COMMENT 'Fecha estimada de completación',
  `tiempo_estimado` bigint(12) DEFAULT '0' COMMENT 'Tiempo estimado del lote',
  `tiempo` bigint(12) DEFAULT '0' COMMENT 'Tiempo total del lote',
  `estado` int(2) DEFAULT '0' COMMENT 'Estado del lote',
  `inspeccionado_por` bigint(20) DEFAULT '0' COMMENT 'Usuario que inspecciono la última vez',
  `rechazado_por` bigint(20) DEFAULT '0' COMMENT 'Usuario que rechazó la última vez',
  `alarma_tse` char(1) DEFAULT 'N' COMMENT 'Esta alarmada por tiempo de stock excedido',
  `alarma_tpe` char(1) DEFAULT 'N' COMMENT 'Esta alarmada por tiempo de proceso excedido',
  `alarma_plan` char(1) DEFAULT 'N' COMMENT 'Esta alarmada por programación no alcanzada',
  `carga` bigint(20) DEFAULT '0' COMMENT 'ID de la carga (temporal)',
  `estatus` char(1) DEFAULT 'A' COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(20) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(20) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`proceso`,`estado`,`estatus`,`creacion`),
  KEY `NewIndex2` (`parte`,`carga`),
  KEY `NewIndex3` (`carga`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Lotes' AUTO_INCREMENT=161 ;

--
-- Volcado de datos para la tabla `lotes`
--

INSERT INTO `lotes` (`id`, `numero`, `parte`, `fecha`, `hasta`, `calcular_hasta`, `rechazo`, `inspeccion_id`, `rechazo_id`, `inspeccion`, `inspecciones`, `rechazos`, `alarmas`, `reversos`, `proceso`, `equipo`, `ruta`, `ruta_detalle`, `ruta_secuencia`, `inicia`, `finaliza`, `estimada`, `tiempo_estimado`, `tiempo`, `estado`, `inspeccionado_por`, `rechazado_por`, `alarma_tse`, `alarma_tpe`, `alarma_plan`, `carga`, `estatus`, `creacion`, `modificacion`, `creado`, `modificado`) VALUES
(154, '86546438', 9, '2019-09-05 11:20:48', '2019-09-06 04:37:45', 'N', NULL, 0, 0, NULL, 0, 0, 0, 0, 20, 0, 9, 370, 11, '2019-09-05 10:30:14', NULL, '2019-10-02 14:46:58', 2348204, 0, 0, 0, 0, 'N', 'N', 'N', 0, 'A', '2019-09-05 10:30:14', NULL, 1, NULL),
(155, '86546473', 12, '2019-09-05 11:37:44', '2019-09-06 11:37:45', 'N', NULL, 0, 0, NULL, 0, 0, 0, 0, 17, 0, 12, 220, 1, '2019-09-05 10:31:52', NULL, NULL, 0, 0, 20, 0, 0, 'N', 'N', 'N', 0, 'A', '2019-09-05 10:31:52', NULL, 1, NULL),
(156, '86548620', 9, '2019-09-05 11:37:44', '2019-09-06 11:37:45', 'N', NULL, 0, 0, NULL, 0, 0, 0, 0, 17, 0, 9, 360, 1, '2019-09-05 10:31:59', NULL, NULL, 0, 0, 20, 0, 0, 'N', 'N', 'N', 0, 'A', '2019-09-05 10:31:59', NULL, 1, NULL),
(157, '86548613', 9, '2019-09-05 11:37:44', '2019-09-06 11:37:45', 'N', NULL, 0, 0, NULL, 0, 0, 0, 0, 17, 0, 9, 360, 1, '2019-09-05 10:32:07', NULL, NULL, 0, 0, 20, 0, 0, 'N', 'N', 'N', 0, 'A', '2019-09-05 10:32:07', NULL, 1, NULL),
(158, '86546449', 9, '2019-09-05 11:37:44', '2019-09-06 11:37:45', 'N', NULL, 0, 0, NULL, 0, 0, 0, 0, 17, 0, 9, 360, 1, '2019-09-05 10:32:28', NULL, NULL, 0, 0, 20, 0, 0, 'N', 'N', 'N', 0, 'A', '2019-09-05 10:32:28', NULL, 1, NULL),
(159, '86546441', 9, '2019-09-05 11:30:37', '2019-09-06 04:37:45', 'N', NULL, 0, 0, NULL, 0, 0, 0, 0, 20, 0, 9, 370, 11, '2019-09-05 10:32:39', NULL, NULL, 0, 0, 0, 0, 0, 'N', 'N', 'N', 0, 'A', '2019-09-05 10:32:39', NULL, 1, NULL),
(160, '86546451', 9, '2019-09-05 11:37:44', '2019-09-06 11:37:45', 'N', NULL, 0, 0, NULL, 0, 0, 0, 0, 17, 0, 9, 360, 1, '2019-09-05 10:33:07', NULL, NULL, 0, 0, 20, 0, 0, 'N', 'N', 'N', 0, 'A', '2019-09-05 10:33:07', NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lotes_cambiados`
--

CREATE TABLE IF NOT EXISTS `lotes_cambiados` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `lote` bigint(20) DEFAULT NULL COMMENT 'ID del lote',
  `fecha` datetime DEFAULT NULL COMMENT 'Fecha de la actualización',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`lote`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='TRIGGER - Lotes cambiados' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lotes_historia`
--

CREATE TABLE IF NOT EXISTS `lotes_historia` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `lote` bigint(20) DEFAULT '0' COMMENT 'ID de lote',
  `ruta` bigint(20) DEFAULT '0' COMMENT 'ID de la ruta',
  `ruta_detalle` bigint(20) DEFAULT '0' COMMENT 'ID del detalle de la ruta',
  `ruta_detalle_anterior` bigint(20) DEFAULT '0' COMMENT 'ID del detalle de la ruta anterior',
  `ruta_secuencia` int(6) DEFAULT '0' COMMENT 'Secuecia de la operación',
  `ruta_secuencia_antes` int(6) DEFAULT '0' COMMENT 'Secuecia de la anterior',
  `proceso` bigint(20) DEFAULT '0' COMMENT 'ID del proceso',
  `proceso_anterior` int(20) DEFAULT '0' COMMENT 'ID del proceso anterior',
  `equipo` bigint(20) DEFAULT '0' COMMENT 'ID del equipo',
  `fecha_entrada` datetime DEFAULT NULL COMMENT 'Fecha de entrada del lote',
  `fecha_stock` datetime DEFAULT NULL COMMENT 'Fecha de enrada al stock',
  `fecha_proceso` datetime DEFAULT NULL COMMENT 'Fecha de entrada al proceso',
  `fecha_salida` datetime DEFAULT NULL COMMENT 'Fecha de salida del proceso',
  `fecha_estimada` datetime DEFAULT NULL COMMENT 'Fecha estimada del proceso (stock + proceso + setup)',
  `tiempo_estimado` bigint(12) DEFAULT '0' COMMENT 'Tiempo estimado en segundos',
  `tiempo_total` bigint(12) DEFAULT '0' COMMENT 'Tiempo total del lote en el proceso',
  `tiempo_espera` bigint(12) DEFAULT '0' COMMENT 'Tiempo del lote en la situación de espera',
  `tiempo_stock` bigint(12) DEFAULT '0' COMMENT 'Tiempo del lote en la situación de stock',
  `tiempo_proceso` bigint(12) DEFAULT '0' COMMENT 'Tiempo del lote en la situación de proceso',
  `alarma_so` char(1) DEFAULT 'N' COMMENT 'Alarmada por Salto de operación?',
  `alarma_so_rep` datetime DEFAULT NULL COMMENT 'Fecha de alarma por salto de operación',
  `inspecciones` int(4) DEFAULT '0' COMMENT 'Inspecciones en el proceso',
  `rechazos` int(4) DEFAULT '0' COMMENT 'Rechazos en el proceso',
  `reversado` char(1) DEFAULT NULL COMMENT 'El proceso fue reversado',
  `reversos` int(4) DEFAULT '0' COMMENT 'reversos del proceso',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`lote`,`proceso`),
  KEY `NewIndex2` (`lote`,`ruta_secuencia`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Histórico de lotes' AUTO_INCREMENT=215 ;

--
-- Volcado de datos para la tabla `lotes_historia`
--

INSERT INTO `lotes_historia` (`id`, `lote`, `ruta`, `ruta_detalle`, `ruta_detalle_anterior`, `ruta_secuencia`, `ruta_secuencia_antes`, `proceso`, `proceso_anterior`, `equipo`, `fecha_entrada`, `fecha_stock`, `fecha_proceso`, `fecha_salida`, `fecha_estimada`, `tiempo_estimado`, `tiempo_total`, `tiempo_espera`, `tiempo_stock`, `tiempo_proceso`, `alarma_so`, `alarma_so_rep`, `inspecciones`, `rechazos`, `reversado`, `reversos`) VALUES
(204, 154, 9, 360, 0, 1, 0, 17, 0, 1, '2019-09-05 10:30:14', NULL, '2019-09-05 11:02:15', '2019-09-05 11:03:15', NULL, 0, 1981, 1921, 0, 60, 'N', NULL, 0, 0, NULL, 0),
(205, 155, 12, 220, 0, 1, 0, 17, 0, 0, '2019-09-05 10:31:52', '2019-09-05 11:37:44', NULL, NULL, NULL, 0, 0, 3952, 0, 0, 'N', NULL, 0, 0, NULL, 0),
(206, 156, 9, 360, 0, 1, 0, 17, 0, 0, '2019-09-05 10:31:59', '2019-09-05 11:37:44', NULL, NULL, NULL, 0, 0, 3945, 0, 0, 'N', NULL, 0, 0, NULL, 0),
(207, 157, 9, 360, 0, 1, 0, 17, 0, 0, '2019-09-05 10:32:07', '2019-09-05 11:37:44', NULL, NULL, NULL, 0, 0, 3937, 0, 0, 'N', NULL, 0, 0, NULL, 0),
(208, 158, 9, 360, 0, 1, 0, 17, 0, 0, '2019-09-05 10:32:28', '2019-09-05 11:37:44', NULL, NULL, NULL, 0, 0, 3916, 0, 0, 'N', NULL, 0, 0, NULL, 0),
(209, 159, 9, 360, 0, 1, 0, 17, 0, 2, '2019-09-05 10:32:39', NULL, '2019-09-05 11:22:03', '2019-09-05 11:30:37', NULL, 0, 3478, 2964, 0, 514, 'N', NULL, 0, 0, NULL, 0),
(210, 160, 9, 360, 0, 1, 0, 17, 0, 0, '2019-09-05 10:33:07', '2019-09-05 11:37:44', NULL, NULL, NULL, 0, 0, 3877, 0, 0, 'N', NULL, 0, 0, NULL, 0),
(211, 154, 9, 361, 360, 2, 1, 13, 17, 5, '2019-09-05 11:03:15', NULL, '2019-09-05 11:05:11', '2019-09-05 11:05:33', NULL, 0, 138, 116, 0, 22, 'N', NULL, 0, 0, NULL, 0),
(212, 154, 9, 365, 361, 6, 2, 4, 13, 14, '2019-09-05 11:05:33', NULL, '2019-09-05 11:20:30', '2019-09-05 11:20:48', NULL, 0, 915, 897, 0, 18, 'S', NULL, 0, 0, NULL, 0),
(213, 154, 9, 370, 365, 11, 6, 20, 4, 0, '2019-09-05 11:20:48', NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 'S', NULL, 0, 0, NULL, 0),
(214, 159, 9, 370, 360, 11, 1, 20, 17, 0, '2019-09-05 11:30:37', NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 'S', NULL, 0, 0, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE IF NOT EXISTS `mensajes` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `alerta` bigint(11) DEFAULT NULL COMMENT 'ID de la alerta',
  `tipo` int(2) DEFAULT '0' COMMENT '0=Inicio, 1-5=Escalación1, 9=Repetición, 11-15=Repetición de escalamiento',
  `canal` int(1) DEFAULT NULL COMMENT 'Canal de envío',
  `prioridad` int(1) DEFAULT NULL COMMENT 'Prioridad del mensaje',
  `destino` varchar(100) DEFAULT NULL COMMENT 'Destino',
  `mensaje` varchar(600) DEFAULT NULL COMMENT 'Mensase a enviar',
  `estatus` char(1) DEFAULT 'A' COMMENT 'Estatus del mensaje',
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha del mensaje',
  `lista` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`tipo`,`estatus`),
  KEY `NewIndex2` (`id`,`alerta`,`canal`),
  KEY `NewIndex3` (`canal`,`prioridad`,`destino`,`estatus`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=67099 ;

--
-- Volcado de datos para la tabla `mensajes`
--

INSERT INTO `mensajes` (`id`, `alerta`, `tipo`, `canal`, `prioridad`, `destino`, `mensaje`, `estatus`, `fecha`, `lista`) VALUES
(66995, 6143, 0, 3, 0, 'elvismontezuma@hotmail.com', 'SALTO DE OPERACION\r\n\r\nDatos del lote\r\nNúmero: 86548610\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del salto de operación\r\nDesde la operación: Lavadora Dürr 1/2. Secuencia: 2\r\nHasta la operación: PVD. Secuencia: 11', 'Z', '2019-09-02 17:20:14', 1),
(66996, 6143, 0, 4, 0, 'D1', 'SALTO. LOTE  86548610. REF  70039540', 'Z', '2019-09-02 17:20:14', 1),
(66997, 6144, 0, 3, 0, 'elvismontezuma@hotmail.com', 'SALTO DE OPERACION\r\n\r\nDatos del lote\r\nNúmero: 86548629\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del salto de operación\r\nDesde la operación: Oval Coiling. Secuencia: 1\r\nHasta la operación: PVD. Secuencia: 11', 'Z', '2019-09-02 17:27:20', 1),
(66998, 6144, 0, 4, 0, 'D1', 'SALTO. LOTE  86548629. REF  70039540', 'Z', '2019-09-02 17:27:20', 1),
(66999, 6145, 0, 3, 0, 'elvismontezuma@hotmail.com', 'TIEMPO DE ENTREGA EXCEDIDO\r\nCarga: 002\r\nEquipo: PVD2\r\nProceso: PVD\r\nFecha promesa: lun, 02-sep-2019 15:00\r\nDemora (H:MM:SS): -1:-01:-14', 'Z', '2019-09-02 19:59:45', 1),
(67000, 6145, 0, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'TIEMPO DE ENTREGA EXCEDIDO\r\nCarga: 002\r\nEquipo: PVD2\r\nProceso: PVD\r\nFecha promesa: lun, 02-sep-2019 15:00\r\nDemora (H:MM:SS): -1:-01:-14', 'Z', '2019-09-02 19:59:45', 1),
(67001, 6145, 0, 4, 0, 'D1', 'PLAN/EXCEDIDO CARGA # 002', 'Z', '2019-09-02 19:59:45', 1),
(67002, 6146, 0, 3, 0, 'elvismontezuma@hotmail.com', 'TIEMPO DE PROCESO EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86551364\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\nEquipo asociado: OC3\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 13:20:12\r\nFecha estimada de salida: 02/09/2019 18:18:37\r\nDemora (H:MM:SS): 0:00:16\r\n\r\nActivación de la alarma: 02/09/2019 18:18:52 (incluye una holgura de 15 segundos)', 'Z', '2019-09-02 23:18:53', 1),
(67003, 6146, 0, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'TIEMPO DE PROCESO EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86551364\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\nEquipo asociado: OC3\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 13:20:12\r\nFecha estimada de salida: 02/09/2019 18:18:37\r\nDemora (H:MM:SS): 0:00:16\r\n\r\nActivación de la alarma: 02/09/2019 18:18:52 (incluye una holgura de 15 segundos)', 'Z', '2019-09-02 23:18:53', 1),
(67004, 6146, 0, 4, 0, 'D1', 'PROC/EXCED L-86551364', 'Z', '2019-09-02 23:18:53', 1),
(67005, 6147, 0, 3, 0, 'elvismontezuma@hotmail.com', 'SALTO DE OPERACION\r\n\r\nDatos del lote\r\nNúmero: 86546473\r\nReferencia del artículo: 70052840\r\nDescripción del artículo: 103.25x1.20 1ra Ranura\r\n\r\nDatos del salto de operación\r\nDesde la operación: Rectificado + chaflan del gap. Secuencia: 4\r\nHasta la operación: Lavadora Dürr 1/2. Secuencia: 2', 'Z', '2019-09-03 14:54:30', 1),
(67006, 6147, 0, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'SALTO DE OPERACION\r\n\r\nDatos del lote\r\nNúmero: 86546473\r\nReferencia del artículo: 70052840\r\nDescripción del artículo: 103.25x1.20 1ra Ranura\r\n\r\nDatos del salto de operación\r\nDesde la operación: Rectificado + chaflan del gap. Secuencia: 4\r\nHasta la operación: Lavadora Dürr 1/2. Secuencia: 2', 'Z', '2019-09-03 14:54:30', 1),
(67007, 6147, 0, 4, 0, 'D1', 'SALTO. LOTE  86546473. REF  70052840', 'Z', '2019-09-03 14:54:30', 1),
(67008, 6148, 0, 3, 0, 'elvismontezuma@hotmail.com', 'SALTO DE OPERACION\r\n\r\nDatos del lote\r\nNúmero: 86546473\r\nReferencia del artículo: 70052840\r\nDescripción del artículo: 103.25x1.20 1ra Ranura\r\n\r\nDatos del salto de operación\r\nDesde la operación: Lavadora Dürr 1/2. Secuencia: 2\r\nHasta la operación: Cepillado del gap. Secuencia: 6', 'Z', '2019-09-03 14:57:32', 1),
(67009, 6148, 0, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'SALTO DE OPERACION\r\n\r\nDatos del lote\r\nNúmero: 86546473\r\nReferencia del artículo: 70052840\r\nDescripción del artículo: 103.25x1.20 1ra Ranura\r\n\r\nDatos del salto de operación\r\nDesde la operación: Lavadora Dürr 1/2. Secuencia: 2\r\nHasta la operación: Cepillado del gap. Secuencia: 6', 'Z', '2019-09-03 14:57:32', 1),
(67010, 6148, 0, 4, 0, 'D1', 'SALTO. LOTE  86546473. REF  70052840', 'Z', '2019-09-03 14:57:32', 1),
(67011, 6149, 0, 3, 0, 'elvismontezuma@hotmail.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:04:54', 1),
(67012, 6149, 0, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:04:54', 1),
(67013, 6149, 0, 4, 0, 'D1', 'STOCK/EXCED L-70039540', 'Z', '2019-09-03 15:04:54', 1),
(67014, 6150, 0, 3, 0, 'elvismontezuma@hotmail.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:05:01', 1),
(67015, 6150, 0, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:05:01', 1),
(67016, 6150, 0, 4, 0, 'D1', 'STOCK/EXCED L-86546441', 'Z', '2019-09-03 15:05:01', 1),
(67017, 6149, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 1 tiempo transcurrido: 0:03:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:07:54', 1),
(67018, 6149, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 1 tiempo transcurrido: 0:03:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:07:54', 1),
(67019, 6149, 9, 4, 0, 'D1', 'STOCK/EXCED L-70039540 *R1 0:03:00', 'Z', '2019-09-03 15:07:54', 1),
(67020, 6150, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 1 tiempo transcurrido: 0:03:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:08:01', 1),
(67021, 6150, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 1 tiempo transcurrido: 0:03:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:08:01', 1),
(67022, 6150, 9, 4, 0, 'D1', 'STOCK/EXCED L-86546441 *R1 0:03:00', 'Z', '2019-09-03 15:08:01', 1),
(67023, 6149, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 2 tiempo transcurrido: 0:06:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:10:54', 1),
(67024, 6149, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 2 tiempo transcurrido: 0:06:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:10:54', 1),
(67025, 6149, 9, 4, 0, 'D1', 'STOCK/EXCED L-70039540 *R2 0:06:00', 'Z', '2019-09-03 15:10:54', 1),
(67026, 6150, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 2 tiempo transcurrido: 0:06:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:11:01', 1),
(67027, 6150, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 2 tiempo transcurrido: 0:06:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:11:01', 1),
(67028, 6150, 9, 4, 0, 'D1', 'STOCK/EXCED L-86546441 *R2 0:06:00', 'Z', '2019-09-03 15:11:01', 1),
(67029, 6149, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 3 tiempo transcurrido: 0:09:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:13:54', 1),
(67030, 6149, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 3 tiempo transcurrido: 0:09:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:13:54', 1),
(67031, 6149, 9, 4, 0, 'D1', 'STOCK/EXCED L-70039540 *R3 0:09:00', 'Z', '2019-09-03 15:13:54', 1),
(67032, 6150, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 3 tiempo transcurrido: 0:09:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:14:01', 1),
(67033, 6150, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 3 tiempo transcurrido: 0:09:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:14:01', 1),
(67034, 6150, 9, 4, 0, 'D1', 'STOCK/EXCED L-86546441 *R3 0:09:00', 'Z', '2019-09-03 15:14:01', 1),
(67035, 6149, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 4 tiempo transcurrido: 0:12:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:16:54', 1),
(67036, 6149, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 4 tiempo transcurrido: 0:12:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:16:54', 1),
(67037, 6149, 9, 4, 0, 'D1', 'STOCK/EXCED L-70039540 *R4 0:12:00', 'Z', '2019-09-03 15:16:54', 1),
(67038, 6150, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 4 tiempo transcurrido: 0:12:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:17:01', 1),
(67039, 6150, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 4 tiempo transcurrido: 0:12:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:17:01', 1),
(67040, 6150, 9, 4, 0, 'D1', 'STOCK/EXCED L-86546441 *R4 0:12:00', 'Z', '2019-09-03 15:17:01', 1),
(67041, 6149, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 5 tiempo transcurrido: 0:15:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:19:54', 1),
(67042, 6149, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 5 tiempo transcurrido: 0:15:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:19:54', 1),
(67043, 6149, 9, 4, 0, 'D1', 'STOCK/EXCED L-70039540 *R5 0:15:00', 'Z', '2019-09-03 15:19:54', 1),
(67044, 6150, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 5 tiempo transcurrido: 0:15:01\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:20:02', 1),
(67045, 6150, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 5 tiempo transcurrido: 0:15:01\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:20:02', 1),
(67046, 6150, 9, 4, 0, 'D1', 'STOCK/EXCED L-86546441 *R5 0:15:01', 'Z', '2019-09-03 15:20:02', 1),
(67047, 6149, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 6 tiempo transcurrido: 0:18:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:22:54', 1),
(67048, 6149, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 6 tiempo transcurrido: 0:18:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:22:54', 1),
(67049, 6149, 9, 4, 0, 'D1', 'STOCK/EXCED L-70039540 *R6 0:18:00', 'Z', '2019-09-03 15:22:54', 1),
(67050, 6150, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 6 tiempo transcurrido: 0:18:01\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:23:02', 1),
(67051, 6150, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 6 tiempo transcurrido: 0:18:01\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:23:02', 1),
(67052, 6150, 9, 4, 0, 'D1', 'STOCK/EXCED L-86546441 *R6 0:18:01', 'Z', '2019-09-03 15:23:02', 1),
(67053, 6149, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 7 tiempo transcurrido: 0:21:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:25:54', 1),
(67054, 6149, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 7 tiempo transcurrido: 0:21:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:25:54', 1),
(67055, 6149, 9, 4, 0, 'D1', 'STOCK/EXCED L-70039540 *R7 0:21:00', 'Z', '2019-09-03 15:25:54', 1),
(67056, 6150, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 7 tiempo transcurrido: 0:21:01\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:26:02', 1),
(67057, 6150, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 7 tiempo transcurrido: 0:21:01\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:26:02', 1),
(67058, 6150, 9, 4, 0, 'D1', 'STOCK/EXCED L-86546441 *R7 0:21:01', 'Z', '2019-09-03 15:26:02', 1),
(67059, 6149, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 8 tiempo transcurrido: 0:24:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:28:54', 1),
(67060, 6149, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 8 tiempo transcurrido: 0:24:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:28:54', 1),
(67061, 6149, 9, 4, 0, 'D1', 'STOCK/EXCED L-70039540 *R8 0:24:00', 'Z', '2019-09-03 15:28:54', 1),
(67062, 6150, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 8 tiempo transcurrido: 0:24:01\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:29:02', 1),
(67063, 6150, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 8 tiempo transcurrido: 0:24:01\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:29:02', 1),
(67064, 6150, 9, 4, 0, 'D1', 'STOCK/EXCED L-86546441 *R8 0:24:01', 'Z', '2019-09-03 15:29:02', 1),
(67065, 6149, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 9 tiempo transcurrido: 0:27:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:31:54', 1),
(67066, 6149, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 9 tiempo transcurrido: 0:27:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:31:54', 1),
(67067, 6149, 9, 4, 0, 'D1', 'STOCK/EXCED L-70039540 *R9 0:27:00', 'Z', '2019-09-03 15:31:54', 1),
(67068, 6150, 9, 3, 0, 'elvismontezuma@hotmail.com', 'REPETICION 9 tiempo transcurrido: 0:27:01\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:32:02', 1),
(67069, 6150, 9, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'REPETICION 9 tiempo transcurrido: 0:27:01\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:32:02', 1),
(67070, 6150, 9, 4, 0, 'D1', 'STOCK/EXCED L-86546441 *R9 0:27:01', 'Z', '2019-09-03 15:32:02', 1),
(67071, 6149, 11, 3, 0, 'elvismontezuma@hotmail.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos) *E1 0:30:00', 'Z', '2019-09-03 15:34:54', 1),
(67072, 6149, 11, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos) *E1 0:30:00', 'Z', '2019-09-03 15:34:54', 1),
(67073, 6149, 11, 4, 0, 'D1', 'STOCK/EXCED L-70039540 *E1 0:30:00', 'Z', '2019-09-03 15:34:54', 1),
(67074, 6149, 1, 3, 0, 'elvismontezuma@hotmail.com', 'PRIMER ESCALAMIENTO en 0:30:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:34:54', 12),
(67075, 6150, 11, 3, 0, 'elvismontezuma@hotmail.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos) *E1 0:30:00', 'Z', '2019-09-03 15:35:01', 1),
(67076, 6150, 11, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos) *E1 0:30:00', 'Z', '2019-09-03 15:35:01', 1),
(67077, 6150, 11, 4, 0, 'D1', 'STOCK/EXCED L-86546441 *E1 0:30:00', 'Z', '2019-09-03 15:35:01', 1),
(67078, 6150, 1, 3, 0, 'elvismontezuma@hotmail.com', 'PRIMER ESCALAMIENTO en 0:30:00\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos)', 'Z', '2019-09-03 15:35:01', 12),
(67079, 6149, 1, 3, 0, 'eder.marquez@tenneco.com', 'PRIMER ESCALAMIENTO en 47:21:11\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos) *R1', 'Z', '2019-09-05 14:26:05', 12),
(67080, 6150, 1, 3, 0, 'eder.marquez@tenneco.com', 'PRIMER ESCALAMIENTO en 47:21:04\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos) *R1', 'Z', '2019-09-05 14:26:05', 12),
(67081, 6149, 13, 3, 0, 'elvismontezuma@hotmail.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos) *E3 47:51:11', 'Z', '2019-09-05 14:56:05', 1),
(67082, 6149, 13, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos) *E3 47:51:11', 'Z', '2019-09-05 14:56:05', 1),
(67083, 6149, 13, 3, 0, 'elvismontezuma@hotmail.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos) *E3 47:51:11', 'Z', '2019-09-05 14:56:05', 12),
(67084, 6149, 13, 3, 0, 'eder.marquez@tenneco.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos) *E3 47:51:11', 'Z', '2019-09-05 14:56:05', 12),
(67085, 6149, 13, 4, 0, 'D1', 'STOCK/EXCED L-70039540 *E3 47:51:11', 'Z', '2019-09-05 14:56:05', 1),
(67086, 6150, 13, 3, 0, 'elvismontezuma@hotmail.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos) *E3 47:51:04', 'Z', '2019-09-05 14:56:05', 1),
(67087, 6150, 13, 3, 0, 'luisenrique.escuderosilva@tenneco.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos) *E3 47:51:04', 'Z', '2019-09-05 14:56:05', 1),
(67088, 6150, 13, 3, 0, 'elvismontezuma@hotmail.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos) *E3 47:51:04', 'Z', '2019-09-05 14:56:05', 12),
(67089, 6150, 13, 3, 0, 'eder.marquez@tenneco.com', 'TIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos) *E3 47:51:04', 'Z', '2019-09-05 14:56:05', 12),
(67090, 6150, 13, 4, 0, 'D1', 'STOCK/EXCED L-86546441 *E3 47:51:04', 'Z', '2019-09-05 14:56:05', 1),
(67091, 6149, 1, 3, 0, 'eder.marquez@tenneco.com', 'PRIMER ESCALAMIENTO en 47:51:11\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos) *R2', 'Z', '2019-09-05 14:56:05', 12),
(67092, 6150, 1, 3, 0, 'eder.marquez@tenneco.com', 'PRIMER ESCALAMIENTO en 47:51:04\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos) *R2', 'Z', '2019-09-05 14:56:05', 12),
(67093, 6149, 1, 3, 0, 'eder.marquez@tenneco.com', 'PRIMER ESCALAMIENTO en 48:21:11\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos) *R3', 'Z', '2019-09-05 15:26:05', 12),
(67094, 6150, 1, 3, 0, 'eder.marquez@tenneco.com', 'PRIMER ESCALAMIENTO en 48:21:04\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos) *R3', 'Z', '2019-09-05 15:26:05', 12),
(67095, 6149, 1, 3, 0, 'eder.marquez@tenneco.com', 'PRIMER ESCALAMIENTO en 48:51:11\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos) *R4', 'Z', '2019-09-05 15:56:05', 12),
(67096, 6150, 1, 3, 0, 'eder.marquez@tenneco.com', 'PRIMER ESCALAMIENTO en 48:51:04\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos) *R4', 'Z', '2019-09-05 15:56:05', 12),
(67097, 6149, 1, 3, 0, 'eder.marquez@tenneco.com', 'PRIMER ESCALAMIENTO en 49:21:11\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 70039540\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:38\r\nFecha estimada de salida: 03/09/2019 10:04:39\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:04:54 (incluye una holgura de 15 segundos) *R5', 'Z', '2019-09-05 16:26:05', 12);
INSERT INTO `mensajes` (`id`, `alerta`, `tipo`, `canal`, `prioridad`, `destino`, `mensaje`, `estatus`, `fecha`, `lista`) VALUES
(67098, 6150, 1, 3, 0, 'eder.marquez@tenneco.com', 'PRIMER ESCALAMIENTO en 49:21:04\r\nTIEMPO DE STOCK EXCEDIDO\r\n\r\nDatos del lote\r\nNúmero: 86546441\r\nReferencia del artículo: 70039540\r\nDescripción del artículo: 96.009x1.20 1ra Ranura\r\n\r\nDatos del proceso\r\nNombre: Oval Coiling\r\nOperación de la ruta asociada: Oval Coiling\r\nSecuencia de la operación en la ruta: 1\r\n\r\nDatos de la demora\r\nFecha de entrada en stock: 02/09/2019 10:04:45\r\nFecha estimada de salida: 03/09/2019 10:04:46\r\nDemora (H:MM:SS): 0:00:15\r\n\r\nActivación de la alarma: 03/09/2019 10:05:01 (incluye una holgura de 15 segundos) *R5', 'Z', '2019-09-05 16:26:05', 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos`
--

CREATE TABLE IF NOT EXISTS `movimientos` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `desde` datetime DEFAULT NULL COMMENT 'Fecha de inicio del corte',
  `hasta` datetime DEFAULT NULL COMMENT 'Fecha de fin del corte',
  `sensor` bigint(11) DEFAULT NULL COMMENT 'ID del sensor',
  `equipo` bigint(11) DEFAULT NULL COMMENT 'ID de la máquina',
  `turno` bigint(11) DEFAULT NULL COMMENT 'ID del turno',
  `tripulacon` bigint(11) DEFAULT NULL COMMENT 'ID tripulación',
  `orden` bigint(11) DEFAULT NULL COMMENT 'ID de la O/P',
  `material` bigint(11) DEFAULT NULL COMMENT 'ID del material',
  `calendario` bigint(11) DEFAULT NULL COMMENT 'ID del calendario',
  `fecha_reporte` date DEFAULT NULL COMMENT 'Fecha calendario',
  `tiempo_corte` bigint(11) DEFAULT NULL COMMENT 'Tiempo del corte (segundos)',
  `piezas_buenas` decimal(17,7) DEFAULT NULL COMMENT 'Cantidad de piezas buenas',
  `piezas_malas` decimal(17,7) DEFAULT NULL COMMENT 'Cantidad de piezas malas',
  `disp_teorica` decimal(11,0) DEFAULT NULL COMMENT 'Disponibilidad teórica (segundos)',
  `disp_real` decimal(11,0) DEFAULT NULL COMMENT 'Disponibilidad real (segundos)',
  `rate_teorico` decimal(17,7) DEFAULT NULL COMMENT 'Rate teórico',
  `rate_real` decimal(17,7) DEFAULT NULL COMMENT 'Rate real',
  `oee` decimal(10,5) DEFAULT NULL COMMENT 'OEE del corte',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha servidor en que se creó el registro',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Movimientos' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden`
--

CREATE TABLE IF NOT EXISTS `orden` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `prioridad` int(6) DEFAULT NULL COMMENT 'Prioridad de la OP',
  `urgente` char(1) DEFAULT NULL COMMENT 'Orden urgente?',
  `planta` bigint(20) DEFAULT NULL COMMENT 'Número de la planta',
  `parte` bigint(20) DEFAULT NULL COMMENT 'Número de parte asociado',
  `proveedor` bigint(20) DEFAULT NULL COMMENT 'Número de proveedor',
  `numero` varchar(50) DEFAULT NULL COMMENT 'Número de la OP',
  `descripción` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción de la OP',
  `notas` varchar(300) DEFAULT NULL COMMENT 'Notas varias',
  `modelo` bigint(20) DEFAULT NULL COMMENT 'Modelo de la OP',
  `maquina` bigint(20) DEFAULT NULL COMMENT 'Máquina',
  `cliente` bigint(20) DEFAULT NULL COMMENT 'Número del cliente',
  `plan` decimal(25,8) DEFAULT NULL COMMENT 'Cantidad planeada',
  `entregado` decimal(25,8) DEFAULT NULL COMMENT 'Cantidad entregada',
  `acumulado` decimal(25,8) DEFAULT NULL COMMENT 'Cantidad que viene acumulada',
  `liberada` datetime DEFAULT NULL COMMENT 'Fecha de liberación',
  `cierre` datetime DEFAULT NULL COMMENT 'Fecha de cierre',
  `primera` datetime DEFAULT NULL COMMENT 'Fecha de la primera lectura',
  `ultima` datetime DEFAULT NULL COMMENT 'Fecha de la última lectura',
  `rate` decimal(25,8) DEFAULT NULL COMMENT 'Rate por hora',
  `tiempociclo` bigint(10) DEFAULT NULL COMMENT 'Tiempo ciclo en segundos',
  `parosplaneados` int(4) DEFAULT NULL COMMENT 'Total paros planeados',
  `parosnoplaneados` int(4) DEFAULT NULL COMMENT 'Total paros no planeados',
  `segundosplaneados` int(8) DEFAULT NULL COMMENT 'Segundos paros planeados',
  `segundosnoplaneados` int(8) DEFAULT NULL COMMENT 'Segundos paros no planeados',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` timestamp NULL DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` varchar(50) DEFAULT NULL COMMENT 'Creado por',
  `modificado` varchar(50) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Ordenes de producció/proceso' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordenes`
--

CREATE TABLE IF NOT EXISTS `ordenes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `referencia` varchar(50) DEFAULT NULL COMMENT 'Referencia de la orden de producción/proceso',
  `maquina` bigint(20) DEFAULT NULL COMMENT 'ID de la máquina',
  `parte` bigint(20) DEFAULT NULL COMMENT 'ID del número de parte',
  `plan` bigint(20) DEFAULT '0' COMMENT 'Cantidad planeada',
  `avance` bigint(20) DEFAULT '0' COMMENT 'Cantidad producida',
  `inicio` datetime DEFAULT NULL COMMENT 'Fecha de inicio',
  `fin` datetime DEFAULT NULL COMMENT 'Fecha de fin',
  `cierre` date DEFAULT NULL COMMENT 'Fecha de cierre',
  `iniciaen` bigint(10) DEFAULT '0',
  `tiempo` bigint(10) DEFAULT NULL COMMENT 'Tiemo total de la orden en el sistema',
  `estado` int(2) DEFAULT NULL COMMENT 'Estado de la orden de producción/proceso',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(20) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(20) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='tabla de ordenes' AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordenes_original`
--

CREATE TABLE IF NOT EXISTS `ordenes_original` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la OP',
  `secuencia` int(6) DEFAULT NULL COMMENT 'Secuencia de la OP',
  `planta` bigint(11) DEFAULT NULL COMMENT 'Número de la planta',
  `proveedor` bigint(11) DEFAULT NULL COMMENT 'Número de proveedor',
  `numero` varchar(30) DEFAULT NULL COMMENT 'Número de la OP',
  `descripción` varchar(100) DEFAULT NULL COMMENT 'Nombre/Descripción de la OP',
  `modelo` bigint(11) DEFAULT NULL COMMENT 'Modelo de la OP',
  `maquina` varchar(100) DEFAULT NULL COMMENT 'Máquina',
  `cliente` bigint(11) DEFAULT NULL COMMENT 'Número del cliente',
  `plan` decimal(15,7) DEFAULT NULL COMMENT 'Cantidad planeada',
  `entregado` decimal(15,7) DEFAULT NULL COMMENT 'Cantidad entregada',
  `acumulado` decimal(15,7) DEFAULT NULL COMMENT 'Cantidad que viene acumulada',
  `liberada` datetime DEFAULT NULL COMMENT 'Fecha de liberación',
  `cierre` datetime DEFAULT NULL COMMENT 'Fecha de cierre',
  `primera` datetime DEFAULT NULL COMMENT 'Fecha de la primera lectura',
  `ultima` datetime DEFAULT NULL COMMENT 'Fecha de la última lectura',
  `rate` decimal(15,7) DEFAULT NULL COMMENT 'Rate por hora',
  `tiempociclo` bigint(10) DEFAULT NULL COMMENT 'Tiempo ciclo en segundos',
  `parosplaneados` int(4) DEFAULT NULL COMMENT 'Total paros planeados',
  `parosnoplaneados` int(4) DEFAULT NULL COMMENT 'Total paros no planeados',
  `segundosplaneados` int(8) DEFAULT NULL COMMENT 'Segundos paros planeados',
  `segundosnoplaneados` int(8) DEFAULT NULL COMMENT 'Segundos paros no planeados',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` timestamp NULL DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` varchar(50) DEFAULT NULL COMMENT 'Creado por',
  `modificado` varchar(50) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Ordenes de producción' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paros`
--

CREATE TABLE IF NOT EXISTS `paros` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `paro` bigint(11) DEFAULT NULL COMMENT 'ID del paro',
  `automatico` char(1) DEFAULT NULL COMMENT 'El paro fue automático',
  `equipo` bigint(11) DEFAULT NULL COMMENT 'ID del equipo',
  `turno` bigint(11) DEFAULT NULL COMMENT 'ID del turno',
  `tripulacion` bigint(11) DEFAULT NULL COMMENT 'ID de la tripulación',
  `orden` bigint(11) DEFAULT NULL COMMENT 'ID de la orden de producción',
  `material` bigint(11) DEFAULT NULL COMMENT 'ID del material',
  `inicia` datetime DEFAULT NULL COMMENT 'Fecha de inicio',
  `finaliza` datetime DEFAULT NULL COMMENT 'Fecha de fin',
  `tiempo_plan` bigint(11) DEFAULT NULL COMMENT 'Tiempo total en segundos (plan)',
  `tiempo_real` bigint(11) DEFAULT NULL COMMENT 'Tiempo total en segundos (real)',
  `adelantado` char(1) DEFAULT NULL COMMENT 'El paro se adelantó',
  `terminado_antes` char(1) DEFAULT NULL COMMENT 'El paro se canceló',
  `terminado_por` bigint(11) DEFAULT NULL COMMENT 'Usuario que terminó el paro',
  `terminado_causa` bigint(11) DEFAULT NULL COMMENT 'Causa de la cancelación',
  `terminado_fecha` datetime DEFAULT NULL COMMENT 'Fecha de la cancelación',
  `genero_otro` char(2) DEFAULT NULL COMMENT 'Generó otro paro (N/P)',
  `comentarios` varchar(1000) DEFAULT NULL COMMENT 'Comentarios del sistema',
  `atendido` char(1) DEFAULT NULL COMMENT 'El paro fue atendido?',
  `clasificado_por` bigint(11) DEFAULT NULL COMMENT 'Usuario que clasificó el paro',
  `clasificado_fecha` datetime DEFAULT NULL COMMENT 'Fecha de la clasificación',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Paros sucedidos' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prioridades`
--

CREATE TABLE IF NOT EXISTS `prioridades` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `fecha` datetime DEFAULT NULL COMMENT 'Fecha y hora de programación',
  `parte` bigint(20) DEFAULT NULL COMMENT 'Número de parte',
  `orden` int(3) DEFAULT NULL COMMENT 'Prioridad',
  `proceso` bigint(20) DEFAULT NULL COMMENT 'ID del proceso',
  `notas` varchar(300) DEFAULT NULL COMMENT 'Notas varias',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`parte`,`fecha`,`estatus`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Volcado de datos para la tabla `prioridades`
--

INSERT INTO `prioridades` (`id`, `fecha`, `parte`, `orden`, `proceso`, `notas`, `estatus`, `creacion`, `modificacion`, `creado`, `modificado`) VALUES
(12, '2019-09-03 09:00:00', 9, 1, 14, 'Pasar 6 lotes', 'A', '2019-09-02 12:35:08', '2019-09-02 12:35:08', 1, 1),
(13, '2019-09-03 09:00:00', 9, 2, 20, '', 'A', '2019-09-02 12:36:16', '2019-09-02 12:36:16', 1, 1),
(14, '2019-09-05 13:00:00', 9, 1, 17, 'pasar 5 lotes', 'A', '2019-09-02 13:31:47', '2019-09-05 11:35:29', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proceso`
--

CREATE TABLE IF NOT EXISTS `proceso` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `planta` bigint(20) DEFAULT NULL COMMENT 'ID de la planta',
  `linea` bigint(20) DEFAULT NULL COMMENT 'ID de la línea',
  `equipo` bigint(20) DEFAULT NULL COMMENT 'ID del equipo',
  `ruta` bigint(20) DEFAULT NULL COMMENT 'ID de la ruta',
  `operacion` bigint(20) DEFAULT NULL COMMENT 'ID de la operacion',
  `orden` varchar(50) DEFAULT NULL COMMENT 'ID de la O/P',
  `parte` varchar(100) DEFAULT NULL COMMENT 'Número de parte',
  `existencia` decimal(25,6) DEFAULT NULL COMMENT 'Cantidad en Stock',
  `desde` datetime DEFAULT NULL COMMENT 'Fecha y hora de entrada',
  `estatus` int(2) DEFAULT NULL COMMENT 'Estatus del stock',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Detalle de existencias en proceso' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `programacion`
--

CREATE TABLE IF NOT EXISTS `programacion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `carga` bigint(20) DEFAULT NULL COMMENT 'ID de la carga',
  `parte` bigint(20) DEFAULT '0' COMMENT 'ID del número de parte',
  `cantidad` bigint(12) DEFAULT '0' COMMENT 'Cantidad',
  `estatus` char(1) DEFAULT 'A' COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Progranación de la producción' AUTO_INCREMENT=29 ;

--
-- Volcado de datos para la tabla `programacion`
--

INSERT INTO `programacion` (`id`, `carga`, `parte`, `cantidad`, `estatus`, `creacion`, `modificacion`, `creado`, `modificado`) VALUES
(26, 23, 12, 4, 'A', '2019-09-05 08:50:28', '2019-09-05 08:50:28', 1, 1),
(23, 22, 12, 4, 'A', '2019-09-04 11:47:11', '2019-09-04 11:47:11', 1, 1),
(22, 22, 9, 4, 'A', '2019-09-02 12:28:43', '2019-09-02 12:28:43', 1, 1),
(27, 24, 9, 3, 'A', '2019-09-05 08:51:23', '2019-09-05 10:34:23', 1, 1),
(28, 24, 12, 2, 'A', '2019-09-05 10:34:32', '2019-09-05 10:34:32', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pu_graficos`
--

CREATE TABLE IF NOT EXISTS `pu_graficos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `usuario` bigint(11) DEFAULT NULL COMMENT 'ID del usuario',
  `grafico` int(4) DEFAULT NULL COMMENT 'Número del gráfico',
  `titulo` varchar(100) DEFAULT NULL COMMENT 'Título del gráfico',
  `titulo_fuente` int(2) DEFAULT NULL COMMENT 'Fuente del título',
  `sub_titulo` varchar(100) DEFAULT NULL COMMENT 'Subtítulo del gráfico',
  `subtitulo_fuente` int(2) DEFAULT NULL COMMENT 'Fuente del subtítulo',
  `texto_x` varchar(100) DEFAULT NULL COMMENT 'Texto eje X',
  `texto_x_fuente` int(2) DEFAULT NULL COMMENT 'Fuente del eje X',
  `texto_y` varchar(100) DEFAULT '0' COMMENT 'Texto eje Y',
  `texto_y_fuente` int(2) DEFAULT NULL COMMENT 'Fuente del eje Y',
  `texto_z` varchar(50) DEFAULT '0' COMMENT 'Texto eje Z',
  `texto_z_fuente` int(2) DEFAULT NULL COMMENT 'Fuente del eje Z',
  `etiqueta_fuente` int(2) DEFAULT NULL COMMENT 'Fuente de la etiqueta',
  `etiqueta_leyenda` int(2) DEFAULT NULL COMMENT 'Fuente de la leyenda',
  `ancho` int(6) DEFAULT NULL COMMENT 'Ancho de la pantalla',
  `alto` int(6) DEFAULT '0' COMMENT 'Alto de la pantalla',
  `margen_arriba` int(4) DEFAULT NULL COMMENT 'Margen arriba',
  `margen_abajo` int(4) DEFAULT NULL COMMENT 'Margen abajo',
  `margen_izquierda` int(4) DEFAULT NULL COMMENT 'Margen izquierda',
  `margen_derecha` int(4) DEFAULT NULL COMMENT 'Margen derecha',
  `maximo_barras` int(2) DEFAULT '0' COMMENT 'Máximo de barras',
  `maximo_barraspct` int(3) DEFAULT '0' COMMENT 'PCT de máximo de barras',
  `agrupar` char(1) DEFAULT NULL COMMENT 'Agrupar el resto',
  `agrupar_alfinal` char(1) DEFAULT NULL COMMENT 'Agrupar al final',
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de actualización',
  `periodo_tipo` int(2) DEFAULT NULL COMMENT 'Tipo de período (0: segundos, 1: minutos, 2: horas, 3: días, 4: semanas, 5: meses, 6: años, 10: DTD, 11: WTD, 12: MTD, 13: YTD)',
  `periodo_atras` bigint(8) DEFAULT NULL COMMENT 'Tiempo a recorrer hacía atrás',
  `mostrar_tabla` char(1) DEFAULT NULL COMMENT 'Mostrar tabla',
  `orden` char(1) DEFAULT NULL COMMENT 'Orden de la gráfica',
  `color_fondo_barras` varchar(20) DEFAULT NULL COMMENT 'Color de fondo de las barras',
  `color_letras` varchar(20) DEFAULT NULL COMMENT 'Color de las letras',
  `color_fondo` varchar(20) DEFAULT NULL COMMENT 'Color del fondo',
  `color_leyenda` varchar(20) DEFAULT NULL COMMENT 'Color del fondo de la leyenda',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`grafico`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Preferencias de usuario (Gráficos)' AUTO_INCREMENT=63 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `regcab_lista`
--

CREATE TABLE IF NOT EXISTS `regcab_lista` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `lista` bigint(11) DEFAULT NULL COMMENT 'ID de la lista',
  `clase` bigint(11) DEFAULT NULL COMMENT 'ID de la clase',
  `area` bigint(11) DEFAULT NULL COMMENT 'ID del área',
  `equipo` bigint(11) DEFAULT NULL COMMENT 'ID del equio',
  `programado` datetime DEFAULT NULL COMMENT 'Fecha y hora en que debe iniciar',
  `iniciada` datetime DEFAULT NULL COMMENT 'Fecha y hora de inicio',
  `final` datetime DEFAULT NULL COMMENT 'Fecha y hora de finalización',
  `limite` bigint(10) DEFAULT '0' COMMENT 'Límite para llenar reporte',
  `total` bigint(10) DEFAULT '0' COMMENT 'Total tiempo para el llenado reporte',
  `variables` int(4) DEFAULT '0' COMMENT 'Total variables medidas',
  `llenas` int(4) DEFAULT '0' COMMENT 'Total variables llenas',
  `prioridad` int(2) DEFAULT NULL COMMENT 'Prioridad del registro',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `abierto` bigint(11) DEFAULT NULL COMMENT 'Fecha de creación',
  `cerrado` bigint(11) DEFAULT NULL COMMENT 'Fecha de modificación',
  `autorizado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Histórico de listas' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `regdet_lista`
--

CREATE TABLE IF NOT EXISTS `regdet_lista` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `lista` bigint(11) NOT NULL COMMENT 'ID de la lista',
  `variable` bigint(11) NOT NULL COMMENT 'ID de la variable',
  `orden` int(4) DEFAULT NULL COMMENT 'Orden en la lista',
  `valor` char(1) DEFAULT NULL COMMENT 'Tomar los datos de origen',
  `requerido` char(1) DEFAULT NULL COMMENT 'Campo requerido',
  `notas` varchar(500) DEFAULT NULL COMMENT 'Notas de la variable',
  `tabla` char(1) DEFAULT NULL COMMENT 'Tomar valor de una tabla',
  `idtabla` bigint(11) DEFAULT NULL COMMENT 'ID de la tabla',
  `unidad` bigint(11) DEFAULT NULL COMMENT 'ID de la unidad de medida',
  `permitido_min` decimal(30,10) DEFAULT NULL COMMENT 'Valor mínimo',
  `permitido_max` decimal(30,10) DEFAULT NULL COMMENT 'Valor máximo',
  `alarma_min` decimal(30,10) DEFAULT NULL COMMENT 'Valor mínimo para generar alarma',
  `alarma_max` decimal(30,10) DEFAULT NULL COMMENT 'Valor máximo para generar alarma',
  `alarma_supervision` char(1) DEFAULT NULL COMMENT 'Requiere supervisión',
  `alarma_regla` char(1) DEFAULT NULL COMMENT 'Requiere regla',
  `color` varchar(20) DEFAULT NULL COMMENT 'Color de fondo',
  `resaltada` char(1) DEFAULT NULL COMMENT 'Resaltar variable',
  `mostrar_rango` char(1) DEFAULT NULL COMMENT 'Mostrar rango en pantalla',
  `confirmar_respuesta` char(1) DEFAULT NULL COMMENT 'Confirmar la respuesta',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha en que se agregó',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha en que se modificó',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Usuario que agregó',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Usuario que modificó',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`lista`,`variable`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `relaciondefectos`
--

CREATE TABLE IF NOT EXISTS `relaciondefectos` (
  `defecto` bigint(11) NOT NULL COMMENT 'ID del defecto',
  `grupo` bigint(11) NOT NULL COMMENT 'ID del grupo',
  `equipo` bigint(11) NOT NULL COMMENT 'ID del equipo',
  PRIMARY KEY (`defecto`,`grupo`,`equipo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Relación defectos verss equipos';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `relacionparos`
--

CREATE TABLE IF NOT EXISTS `relacionparos` (
  `paro` bigint(11) NOT NULL COMMENT 'ID del paro',
  `grupo` bigint(11) NOT NULL COMMENT 'ID del grupo',
  `equipo` bigint(11) NOT NULL COMMENT 'ID del equipo',
  PRIMARY KEY (`paro`,`grupo`,`equipo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Relacion paros versus equips';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `relacion_partes_rutas`
--

CREATE TABLE IF NOT EXISTS `relacion_partes_rutas` (
  `parte` bigint(20) DEFAULT NULL COMMENT 'ID del número de parte',
  `ruta` bigint(20) DEFAULT NULL COMMENT 'ID de la ruta',
  `defecto` char(1) DEFAULT NULL COMMENT 'Ruta por defecto',
  KEY `NewIndex1` (`parte`,`ruta`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Relación entre números de parte y rutas';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `relacion_usuarios_operaciones`
--

CREATE TABLE IF NOT EXISTS `relacion_usuarios_operaciones` (
  `usuario` bigint(20) DEFAULT NULL COMMENT 'ID del número de parte',
  `proceso` bigint(20) DEFAULT NULL COMMENT 'ID de la ruta',
  KEY `NewIndex1` (`usuario`,`proceso`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Relación entre usuarios y operaciones';

--
-- Volcado de datos para la tabla `relacion_usuarios_operaciones`
--

INSERT INTO `relacion_usuarios_operaciones` (`usuario`, `proceso`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(1, 18),
(1, 19),
(1, 20),
(1, 21),
(1, 22),
(1, 23),
(1, 24),
(1, 25),
(1, 26),
(1, 27),
(1, 28),
(1, 29),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(2, 13),
(2, 14),
(2, 15),
(2, 16),
(2, 17),
(2, 18),
(2, 19),
(2, 20),
(2, 21),
(2, 22),
(2, 23),
(2, 24),
(2, 25),
(2, 26),
(2, 27),
(2, 28),
(2, 29),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(3, 6),
(3, 7),
(3, 8),
(3, 9),
(3, 10),
(3, 11),
(3, 12),
(3, 13),
(3, 14),
(3, 15),
(3, 16),
(3, 17),
(3, 18),
(3, 19),
(3, 20),
(3, 21),
(3, 22),
(3, 23),
(3, 24),
(3, 25),
(3, 26),
(3, 27),
(3, 28),
(3, 29),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(4, 6),
(4, 7),
(4, 8),
(4, 9),
(4, 10),
(4, 11),
(4, 12),
(4, 13),
(4, 14),
(4, 15),
(4, 16),
(4, 17),
(4, 18),
(4, 19),
(4, 20),
(4, 21),
(4, 22),
(4, 23),
(4, 24),
(4, 25),
(4, 26),
(4, 27),
(4, 28),
(4, 29);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secenciadosparos`
--

CREATE TABLE IF NOT EXISTS `secenciadosparos` (
  `padre` bigint(11) NOT NULL COMMENT 'ID del paro padre',
  `hijo` bigint(11) NOT NULL COMMENT 'ID del paro hijo',
  `secuencia` int(6) NOT NULL COMMENT 'Secuencia del paro hijo en la lista',
  `tiempo_plan` bigint(11) DEFAULT NULL COMMENT 'Tiempo del paro (en segundos)',
  PRIMARY KEY (`padre`,`hijo`,`secuencia`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Secuencia de paros continuados';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sentencias`
--

CREATE TABLE IF NOT EXISTS `sentencias` (
  `version` varchar(30) DEFAULT NULL COMMENT 'ID de la licencia',
  `orden` int(4) DEFAULT NULL COMMENT 'Orden de la ejecución',
  `sentencia` varchar(1000) DEFAULT NULL COMMENT 'Sentencia a aplicar',
  `estatus` char(1) DEFAULT '0' COMMENT 'Estatus de la licencia (0=Por aplicar, 1=Aplicado, 9=Error)'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Log de versiones';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `set_equipos`
--

CREATE TABLE IF NOT EXISTS `set_equipos` (
  `equipo` bigint(11) DEFAULT NULL COMMENT 'ID del equipo',
  `sensor` bigint(11) DEFAULT NULL COMMENT 'ID del sensor',
  `factor` decimal(20,10) DEFAULT NULL COMMENT 'Factor de conversión de la cantidad',
  `ip` varchar(100) DEFAULT NULL COMMENT 'Dirección IP',
  `nombrered` varchar(100) DEFAULT NULL COMMENT 'Nombre en la red',
  `clave` varchar(100) DEFAULT NULL COMMENT 'Contraseña en la red',
  `produccion` char(1) DEFAULT NULL COMMENT 'Es el sensor para contar la producción',
  `inicial` char(1) DEFAULT NULL COMMENT 'Es el sensor donde inicia el WIP',
  `wip` decimal(17,7) DEFAULT NULL COMMENT 'Cantidad total de WIP',
  `estimar_scrap` char(1) DEFAULT NULL COMMENT 'Estimar el scrap basado en el WIP',
  `estimar_retrabajos` char(1) DEFAULT NULL COMMENT 'Estimar piezas retrabajadas',
  `activarparo` bigint(11) DEFAULT NULL COMMENT 'Activar paro desde (segundos)',
  `activardefecto` decimal(17,7) DEFAULT NULL COMMENT 'Activar defectos automáticos desde',
  `mmcall_paro` char(1) DEFAULT NULL COMMENT 'Generar llamada a MMCall por paro',
  `mmcall_bajorate` char(1) DEFAULT NULL COMMENT 'Generar llamada a MMCall por bajo rate',
  `mmcall_altorate` char(1) DEFAULT NULL COMMENT 'Generar llamada a MMCall por alto rate',
  `bajo_rate_tipo` int(2) DEFAULT NULL COMMENT 'Tipo como se calcula el bajo rate',
  `bajo_rate_monto` decimal(17,7) DEFAULT NULL COMMENT 'Valor para generar llamada de bajo rate',
  `bajo_rate_clasificar` char(1) DEFAULT NULL COMMENT 'Solicitar clasificación de bajo rate',
  `alto_rate_tipo` int(2) DEFAULT NULL COMMENT 'Tipo como se calcula el alto rate',
  `alto_rate_monto` decimal(17,7) DEFAULT NULL COMMENT 'Valor para generar llamada de alto rate',
  `alto_rate_clasificar` char(1) DEFAULT NULL COMMENT 'Solicitar clasificación de alto rate',
  `tope_productividad` decimal(10,5) DEFAULT NULL COMMENT 'Topar el % de productividad',
  `tope_ftq` decimal(10,5) DEFAULT NULL COMMENT 'Topar el % de FTQ',
  `tope_disponibilidad` decimal(10,0) DEFAULT NULL COMMENT 'Topar el % de disponibilidad'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Configuracion de equipos';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tablas`
--

CREATE TABLE IF NOT EXISTS `tablas` (
  `id` int(6) NOT NULL COMMENT 'ID de la tabla',
  `nombre` varchar(50) DEFAULT NULL COMMENT 'Nombre de la tabla',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Catálogo de tablas';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `traduccion`
--

CREATE TABLE IF NOT EXISTS `traduccion` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `literal` varchar(50) DEFAULT NULL COMMENT 'Literal a buscar',
  `idioma` varchar(5) DEFAULT NULL COMMENT 'Idioma',
  `traduccion` varchar(100) DEFAULT NULL COMMENT 'Traducción',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`literal`,`idioma`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Tabla de traducción' AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `traduccion`
--

INSERT INTO `traduccion` (`id`, `literal`, `idioma`, `traduccion`) VALUES
(1, '*E1', NULL, 'ESCALAMIENTO UNO'),
(2, '*R1', NULL, 'REPETICION UNO'),
(3, 'EST', NULL, 'ESTACIÓN'),
(4, 'min', NULL, 'MINUTOS'),
(5, 'hr', NULL, 'HORAS'),
(6, 'seg', NULL, 'SEGUNDOS'),
(7, 'EST', NULL, 'ESTACION'),
(8, 'KJA3G11 ', NULL, 'SERVICIOS AL CONSUMIDOR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vw_alarmas`
--

CREATE TABLE IF NOT EXISTS `vw_alarmas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `falla` bigint(20) DEFAULT NULL COMMENT 'ID de la falla VW',
  `codigo` varchar(50) DEFAULT NULL COMMENT 'Codigo de la falla VW',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Descripción de la falla VW',
  `nave` varchar(50) DEFAULT NULL COMMENT 'ID de la nave',
  `area` varchar(50) DEFAULT NULL COMMENT 'Estación según gráfica',
  `estacion` varchar(50) DEFAULT NULL COMMENT 'ID del equipo VW',
  `prioridad` varchar(1) DEFAULT NULL COMMENT 'Prioridad',
  `inicio` datetime DEFAULT NULL COMMENT 'Acumular número de fallas',
  `fin` datetime DEFAULT NULL COMMENT 'Segundos a contar para acumular',
  `tiempo` bigint(8) DEFAULT '0' COMMENT 'Tiempo en segundos',
  `responsable` varchar(50) DEFAULT NULL COMMENT 'Responsable',
  `tecnologia` varchar(50) DEFAULT NULL COMMENT 'Tecnología',
  `alerta` bigint(11) DEFAULT NULL COMMENT 'Alerta asociada',
  `reporte` bigint(20) DEFAULT '0' COMMENT 'Reporte',
  `accion` int(2) DEFAULT NULL COMMENT 'Acción efectuada: 0=Acumuló, 1=Notificó luego de acumular, 2=Notificó sin acumulación, 3=Ya estaba activa la alerta ',
  `fecha_ts` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha directa de MySQL',
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`falla`,`inicio`),
  KEY `NewIndex2` (`inicio`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Tabla local de fallas para estadísticas' AUTO_INCREMENT=34384 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vw_alertas`
--

CREATE TABLE IF NOT EXISTS `vw_alertas` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `referencia` varchar(50) DEFAULT NULL COMMENT 'Referencia',
  `nombre` varchar(60) DEFAULT NULL COMMENT 'Nombre/Descripción del registro',
  `solapar` char(1) DEFAULT NULL COMMENT 'Solapar alertas',
  `notas` varchar(100) DEFAULT NULL COMMENT 'Notas varias',
  `acumular` char(1) DEFAULT NULL COMMENT 'Acumular fallas antes de enviar',
  `acumular_veces` bigint(6) DEFAULT '0' COMMENT 'Número de veces a acumular',
  `acumular_tiempo` bigint(8) DEFAULT '0' COMMENT 'Tiempo de acumulación',
  `acumular_inicializar` char(1) DEFAULT NULL COMMENT 'Inicializa el contador una vez alcanzada la frecuencia',
  `acumular_tipo_mensaje` char(1) DEFAULT NULL COMMENT 'Tipo de mensaje para repeticiones',
  `acumular_mensaje` varchar(200) DEFAULT NULL COMMENT 'Mensaje de acumulación',
  `log` char(1) DEFAULT NULL COMMENT 'Se generará LOG',
  `sms` char(1) DEFAULT NULL COMMENT 'Se enviará SMS',
  `correo` char(1) DEFAULT NULL COMMENT 'Se enviará correo',
  `llamada` char(1) DEFAULT NULL COMMENT 'Se hará llamada',
  `mmcall` char(1) DEFAULT NULL COMMENT 'Se enviará llamada a MMCall',
  `lista` bigint(11) DEFAULT NULL COMMENT 'Lista de  distribución',
  `escalar1` char(1) DEFAULT NULL COMMENT 'Escalar 1ro',
  `tiempo1` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (1)',
  `lista1` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (1)',
  `log1` char(1) DEFAULT NULL COMMENT 'Generar LOG (1)',
  `sms1` char(1) DEFAULT NULL COMMENT 'Enviar SMS (1)',
  `correo1` char(1) DEFAULT NULL COMMENT 'Enviar correo (1)',
  `llamada1` char(1) DEFAULT NULL COMMENT 'Generar Llamada (1)',
  `mmcall1` char(1) DEFAULT NULL COMMENT 'Área de MMCall (1)',
  `repetir1` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (1)',
  `escalar2` char(1) DEFAULT NULL COMMENT 'Escalar 2do',
  `tiempo2` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (2)',
  `lista2` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (2)',
  `log2` char(1) DEFAULT NULL COMMENT 'Generar LOG (2)',
  `sms2` char(1) DEFAULT NULL COMMENT 'Enviar SMS (2)',
  `correo2` char(1) DEFAULT NULL COMMENT 'Enviar correo (2)',
  `llamada2` char(1) DEFAULT NULL COMMENT 'Generar Llamada (2)',
  `mmcall2` char(1) DEFAULT NULL COMMENT 'Área de MMCall (2)',
  `repetir2` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (2)',
  `escalar3` char(1) DEFAULT NULL COMMENT 'Escalar 3ro',
  `tiempo3` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (3)',
  `lista3` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (3)',
  `log3` char(1) DEFAULT NULL COMMENT 'Generar LOG (3)',
  `sms3` char(1) DEFAULT NULL COMMENT 'Enviar SMS (3)',
  `correo3` char(1) DEFAULT NULL COMMENT 'Enviar correo (3)',
  `llamada3` char(1) DEFAULT NULL COMMENT 'Generar Llamada (3)',
  `mmcall3` char(1) DEFAULT NULL COMMENT 'Área de MMCall (3)',
  `repetir3` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (3)',
  `escalar4` char(1) DEFAULT NULL COMMENT 'Escalar 4to',
  `tiempo4` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (4)',
  `lista4` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (4)',
  `log4` char(1) DEFAULT NULL COMMENT 'Generar LOG (4)',
  `sms4` char(1) DEFAULT NULL COMMENT 'Enviar SMS (4)',
  `correo4` char(1) DEFAULT NULL COMMENT 'Enviar correo (4)',
  `llamada4` char(1) DEFAULT NULL COMMENT 'Generar Llamada (4)',
  `mmcall4` char(1) DEFAULT NULL COMMENT 'Área de MMCall (4)',
  `repetir4` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (4)',
  `escalar5` char(1) DEFAULT NULL COMMENT 'Escalar 5to',
  `tiempo5` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (5)',
  `lista5` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (5)',
  `log5` char(1) DEFAULT NULL COMMENT 'Generar LOG (5)',
  `sms5` char(1) DEFAULT NULL COMMENT 'Enviar SMS (5)',
  `correo5` char(1) DEFAULT NULL COMMENT 'Enviar correo (5)',
  `llamada5` char(1) DEFAULT NULL COMMENT 'Generar Llamada (5)',
  `mmcall5` char(1) DEFAULT NULL COMMENT 'Área de MMCall (5)',
  `repetir5` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (5)',
  `repetir` char(1) DEFAULT NULL COMMENT 'Repetir llamada',
  `repetir_tiempo` bigint(8) DEFAULT '0' COMMENT 'Repetir llamada (segundos)',
  `repetir_log` char(1) DEFAULT NULL COMMENT 'Generar log en la repetición',
  `repetir_sms` char(1) DEFAULT NULL COMMENT 'Enviar SMS en la repetición',
  `repetir_correo` char(1) DEFAULT NULL COMMENT 'Enviar correo en la repetición',
  `repetir_llamada` char(1) DEFAULT NULL COMMENT 'Generar llamada en la repetición',
  `repetir_mmcall` char(1) DEFAULT NULL COMMENT 'Área de MMCall en la repetición',
  `estadistica` char(1) DEFAULT NULL COMMENT 'Generar estadística',
  `escape_veces` int(2) DEFAULT '3' COMMENT 'Número de veces que se repetirá una llamada',
  `escape_accion` char(1) DEFAULT NULL COMMENT 'Acción de Escape',
  `escape_mensaje` varchar(200) DEFAULT NULL COMMENT 'Mensaje a enviar si se agotan las llamadas',
  `escape_lista` bigint(11) DEFAULT NULL COMMENT 'Lista de distribución',
  `informar_resolucion` char(1) DEFAULT NULL COMMENT 'Infoermar resolución',
  `estatus` char(1) DEFAULT NULL COMMENT 'Estatus del registro',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación',
  `modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación',
  `creado` bigint(11) DEFAULT NULL COMMENT 'Creado por',
  `modificado` bigint(11) DEFAULT NULL COMMENT 'Modificado por',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Catálogo de alertas' AUTO_INCREMENT=51 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vw_alerta_escalamientos`
--

CREATE TABLE IF NOT EXISTS `vw_alerta_escalamientos` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `alerta` bigint(11) NOT NULL DEFAULT '0' COMMENT 'ID de la alerta',
  `nivel` int(1) DEFAULT '0' COMMENT 'Nivel de escalamiento: 0-6',
  `tipo` int(2) DEFAULT '0' COMMENT 'Tipo de repositorio (0: Llamada, 10: SMS, 20: Llamada y SMS, 30: Correo to, 31: Correo copy to, 32: Correo blind copy, 40: Área de MMCall)',
  `cadena` varchar(200) DEFAULT NULL COMMENT 'Repositorio',
  `estatus` char(1) DEFAULT 'A' COMMENT 'Estatus del registro',
  PRIMARY KEY (`id`,`alerta`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='VW: Escalamientos asociados a una alerta' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vw_alerta_fallas`
--

CREATE TABLE IF NOT EXISTS `vw_alerta_fallas` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `alerta` bigint(11) NOT NULL DEFAULT '0' COMMENT 'ID de la alerta',
  `orden` int(4) DEFAULT NULL COMMENT 'Orden de la falla en la lista',
  `comparacion` int(2) DEFAULT NULL COMMENT 'Tipo de coincidencia',
  `prefijo` varchar(50) DEFAULT NULL COMMENT 'Repositorio',
  `estacion` varchar(50) DEFAULT NULL COMMENT 'Equipo asociado: *=Cualquiera',
  `estatus` char(1) DEFAULT 'A' COMMENT 'Estatus del registro',
  PRIMARY KEY (`id`,`alerta`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='VW: Fallas asociadas a una alerta' AUTO_INCREMENT=79 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vw_configuracion`
--

CREATE TABLE IF NOT EXISTS `vw_configuracion` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `tiempo` bigint(8) DEFAULT NULL COMMENT 'Tiempo de revisión',
  `correo_cuenta` varchar(100) DEFAULT NULL COMMENT 'Perfil de correo',
  `correo_puerto` varchar(100) DEFAULT NULL COMMENT 'Puerto',
  `correo_ssl` char(1) DEFAULT NULL COMMENT 'Seguridad SSL',
  `correo_clave` varchar(100) DEFAULT NULL COMMENT 'Contraseña',
  `correo_host` varchar(100) DEFAULT NULL COMMENT 'Host',
  `flag_agregar` char(1) DEFAULT NULL COMMENT 'Flag de que se agregó una falla',
  `ejecutando_desde` datetime DEFAULT NULL COMMENT 'Ejecutando desde',
  `ultima_falla` bigint(20) DEFAULT NULL COMMENT 'Último ID de falla revisado',
  `ultima_revision` datetime DEFAULT NULL COMMENT 'Fecha de la última revisión',
  `revisar_cada` bigint(8) DEFAULT '0' COMMENT 'Revisar cada n segundos',
  `utilizar_arduino` char(1) DEFAULT NULL COMMENT 'Usar arduino?',
  `puerto_comm1` varchar(10) DEFAULT NULL COMMENT 'Puerto comm (1)',
  `puerto_comm1_par` varchar(100) DEFAULT NULL COMMENT 'Parámetros Puerto comm (1)',
  `puerto_comm2` varchar(10) DEFAULT NULL COMMENT 'Puerto comm (2)',
  `puerto_comm2_par` varchar(100) DEFAULT NULL COMMENT 'Parámetros Puerto comm (2)',
  `puerto_comm3` varchar(10) DEFAULT NULL COMMENT 'Puerto comm (3)',
  `puerto_comm3_par` varchar(100) DEFAULT NULL COMMENT 'Parámetros Puerto comm (3)',
  `puerto_comm4` varchar(10) NOT NULL COMMENT 'Puerto comm (4)',
  `puerto_comm4_par` varchar(100) DEFAULT NULL COMMENT 'Parámetros Puerto comm (4)',
  `puerto_comm5` varchar(10) DEFAULT NULL COMMENT 'Puerto comm (5)',
  `puerto_comm5_par` varchar(100) DEFAULT NULL COMMENT 'Parámetros Puerto comm (5)',
  `puerto_comm6` varchar(10) DEFAULT NULL COMMENT 'Puerto comm (6)',
  `puerto_comm6_par` varchar(100) DEFAULT NULL COMMENT 'Parámetros Puerto comm (6)',
  `ruta_sms` varchar(500) DEFAULT NULL COMMENT 'Ruta para los SMS',
  `ruta_audios` varchar(500) DEFAULT NULL COMMENT 'Ruta para las llamadas',
  `optimizar_llamada` char(1) DEFAULT NULL COMMENT 'Optimiza las llamadas',
  `optimizar_sms` char(1) DEFAULT NULL COMMENT 'Optimiza los SMS',
  `optimizar_correo` char(1) DEFAULT NULL COMMENT 'Optimiza los correos',
  `optimizar_mmcall` char(1) DEFAULT NULL COMMENT 'Optimiza las llamadas a MMCall',
  `mantener_prioridad` char(1) DEFAULT NULL COMMENT 'Mantener prioridad en la optimización',
  `voz_predeterminada` varchar(255) DEFAULT NULL COMMENT 'Voz predeterminada',
  `escape_mmcall` char(1) DEFAULT NULL COMMENT 'Escape para MMCall',
  `escape_mmcall_mensaje` varchar(200) DEFAULT NULL COMMENT 'Mensaje a enviar MMCall',
  `escape_mmcall_lista` bigint(11) DEFAULT NULL COMMENT 'Lista de distribución (requesters ocupados)',
  `escape_mmcall_cancelar` char(1) DEFAULT NULL COMMENT 'Cancelar el llamado a MMCall',
  `escape_llamadas` int(1) DEFAULT NULL COMMENT 'Número de veces a llamar',
  `escape_accion` char(1) DEFAULT NULL COMMENT 'Acción a tomar',
  `escape_lista` bigint(11) DEFAULT NULL COMMENT 'Lista de distribución',
  `escape_mensaje` varchar(200) DEFAULT NULL COMMENT 'Mensaje a enviar',
  `escape_mensaje_propio` char(1) DEFAULT NULL COMMENT 'Enviar mensaje al propio móvil',
  `veces_reproducir` int(1) DEFAULT '1' COMMENT 'Número de veces que se repeduce un audio',
  `gestion_log` char(6) DEFAULT NULL COMMENT 'Año y mes de la última gestión',
  `gestion_meses` int(4) DEFAULT NULL COMMENT 'Número de meses en línea',
  `correo_titulo_falla` char(1) DEFAULT NULL COMMENT 'Mantener el título de la falla',
  `correo_titulo` varchar(100) DEFAULT NULL COMMENT 'Título opcional del correo',
  `correo_cuerpo` varchar(200) DEFAULT NULL COMMENT 'Cuerpo del correo',
  `correo_firma` varchar(100) DEFAULT NULL COMMENT 'Firma del correo',
  `timeout_llamadas` int(4) DEFAULT NULL COMMENT 'Time Out para llamadas',
  `timeout_sms` int(4) DEFAULT NULL COMMENT 'Time Out para SMS',
  `traducir` char(1) DEFAULT NULL COMMENT 'Traducir mensajes de voz',
  `tiempo_corte` bigint(8) DEFAULT '0' COMMENT 'Tiempo del corte en minutos',
  `ultimo_corte` datetime DEFAULT NULL COMMENT 'Fecha y hora del último corte',
  `bajo_hasta` int(3) DEFAULT NULL,
  `bajo_color` varchar(20) DEFAULT NULL,
  `bajo_etiqueta` varchar(30) DEFAULT NULL,
  `medio_hasta` int(3) DEFAULT NULL,
  `medio_color` varchar(20) DEFAULT NULL,
  `medio_etiqueta` varchar(30) DEFAULT NULL,
  `alto_color` varchar(20) DEFAULT NULL,
  `alto_etiqueta` varchar(30) DEFAULT NULL,
  `noatendio_color` varchar(20) DEFAULT NULL,
  `noatendio_etiqueta` varchar(30) DEFAULT NULL,
  `escaladas_color` varchar(20) DEFAULT NULL,
  `escaladas_etiqueta` varchar(30) DEFAULT NULL,
  `flag_monitor` char(1) DEFAULT 'N' COMMENT 'Flag para leer desde el monitor',
  `ruta_archivos_enviar` varchar(500) DEFAULT NULL COMMENT 'Ruta de los archivos a enviar por correo',
  `server_mmcall` varchar(100) DEFAULT NULL COMMENT 'Server para MMCall',
  `cad_consolidado` varchar(20) DEFAULT NULL COMMENT 'Cadena de la consolidado',
  `ruta_imagenes` varchar(500) DEFAULT NULL COMMENT 'Ruta de imágenes',
  `tiempo_imagen` int(4) DEFAULT NULL COMMENT 'Tiempo entre imagenes',
  `graficas_seleccion` varchar(100) DEFAULT NULL COMMENT 'Gráficas a reportar',
  `graficas_duracion` varchar(100) DEFAULT NULL,
  `timeout_fallas` int(4) DEFAULT '0' COMMENT 'Timeout para crear alerta',
  PRIMARY KEY (`id`,`puerto_comm4`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 MIN_ROWS=1 MAX_ROWS=1 COMMENT='VW: Configuración de la aplicación' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vw_control`
--

CREATE TABLE IF NOT EXISTS `vw_control` (
  `fecha` varchar(10) NOT NULL COMMENT 'Fecha  y hora del envío',
  `mensajes` int(8) DEFAULT NULL COMMENT 'Mensajes enviados',
  PRIMARY KEY (`fecha`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Control de mensajes enviados';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vw_estadistica`
--

CREATE TABLE IF NOT EXISTS `vw_estadistica` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `falla` varchar(50) DEFAULT NULL COMMENT 'ID de la falla VW',
  `equipo` varchar(50) DEFAULT NULL COMMENT 'ID del equipo VW',
  `descripcion` varchar(400) DEFAULT NULL COMMENT 'Descripción de la falla',
  `inicio` datetime DEFAULT NULL COMMENT 'Fecha y hora de inicio',
  `fin` datetime DEFAULT NULL COMMENT 'Fecha y hora de finalización',
  `tiempo` bigint(8) DEFAULT NULL COMMENT 'Tiempo total de falla',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vw_fallascronos`
--

CREATE TABLE IF NOT EXISTS `vw_fallascronos` (
  `idk` int(11) NOT NULL COMMENT 'Id de la falla en la tabla fallascronos',
  `nave` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ID de la Nave',
  `estacion` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ID de la estación',
  `codigo` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Código dela falla',
  `fecha` datetime DEFAULT NULL COMMENT 'Fecha en que se generó la falla',
  `falla` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Descripción de la falla (se amplia a 100chars)',
  `resp` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Responsable (no lo uso)',
  `estado` int(2) DEFAULT '0' COMMENT 'Estado de la falla (lo uso para control)',
  `tecnologia` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tecnología asociad',
  `prioridad` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Prioridad de la falla (nuevo)',
  `ts` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha en que se registró la falla en esta tabla',
  `descripcion` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Descripción completa de la falla',
  `eliminada` char(1) COLLATE utf8_unicode_ci DEFAULT 'N' COMMENT 'Falla eliminada?',
  `cierre` datetime DEFAULT NULL COMMENT 'Cierre de la falla',
  PRIMARY KEY (`idk`),
  KEY `NewIndex1` (`idk`,`estado`,`eliminada`),
  KEY `NewIndex2` (`idk`,`estado`),
  KEY `NewIndex3` (`eliminada`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Replica de la tabla de VW';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vw_log`
--

CREATE TABLE IF NOT EXISTS `vw_log` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora del registro',
  `aplicacion` int(6) DEFAULT NULL COMMENT 'ID de la aplicación',
  `tipo` int(1) DEFAULT '0' COMMENT 'Tipo de mensaje',
  `tiempo` bigint(8) DEFAULT NULL COMMENT 'Segundos en espera',
  `reporte` bigint(11) DEFAULT NULL COMMENT 'Número de reporte',
  `intentados` bigint(8) DEFAULT NULL COMMENT 'Alertas intentadas',
  `enviados` bigint(8) DEFAULT NULL COMMENT 'Alertas enviadas con exito',
  `texto` varchar(250) DEFAULT NULL COMMENT 'Mensaje descriptivo (hasta 250 caracteres)',
  `visto` char(1) DEFAULT 'N' COMMENT 'Ya se vió en el visor?',
  `visto_pc` char(1) DEFAULT 'N' COMMENT 'Ya se vió en el log del PC?',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`fecha`),
  KEY `NewIndex2` (`aplicacion`,`visto`,`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='log de la aplicacion' AUTO_INCREMENT=215533 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vw_mensajes`
--

CREATE TABLE IF NOT EXISTS `vw_mensajes` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `alerta` bigint(11) DEFAULT NULL COMMENT 'ID de la alerta',
  `tipo` int(2) DEFAULT '0' COMMENT '0=Inicio, 1-5=Escalación1, 9=Repetición, 11-15=Repetición de escalamiento',
  `canal` int(1) DEFAULT NULL COMMENT 'Canal de envío',
  `prioridad` int(1) DEFAULT NULL COMMENT 'Prioridad del mensaje',
  `destino` varchar(100) DEFAULT NULL COMMENT 'Destino',
  `mensaje` varchar(250) DEFAULT NULL COMMENT 'Mensase a enviar',
  `estatus` char(1) DEFAULT 'A' COMMENT 'Estatus del mensaje',
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha del mensaje',
  `lista` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`tipo`,`estatus`),
  KEY `NewIndex2` (`id`,`alerta`,`canal`),
  KEY `NewIndex3` (`canal`,`prioridad`,`destino`,`estatus`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='VW: Histórico de mensajes a enviar' AUTO_INCREMENT=66753 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vw_reportes`
--

CREATE TABLE IF NOT EXISTS `vw_reportes` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `alerta` bigint(11) DEFAULT NULL COMMENT 'Alerta padre',
  `log` char(1) DEFAULT NULL COMMENT 'Se generará LOG',
  `sms` char(1) DEFAULT NULL COMMENT 'Se enviará SMS',
  `correo` char(1) DEFAULT NULL COMMENT 'Se enviará correo',
  `llamada` char(1) DEFAULT NULL COMMENT 'Se hará llamada',
  `mmcall` char(1) DEFAULT NULL COMMENT 'Se enviará llamada a MMCall',
  `lista` bigint(11) DEFAULT NULL COMMENT 'Lista de  distribución',
  `escalar1` char(1) DEFAULT NULL COMMENT 'Escalar 1ro',
  `tiempo1` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (1)',
  `lista1` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (1)',
  `log1` char(1) DEFAULT NULL COMMENT 'Generar LOG (1)',
  `sms1` char(1) DEFAULT NULL COMMENT 'Enviar SMS (1)',
  `correo1` char(1) DEFAULT NULL COMMENT 'Enviar correo (1)',
  `llamada1` char(1) DEFAULT NULL COMMENT 'Generar Llamada (1)',
  `mmcall1` char(1) DEFAULT NULL COMMENT 'Área de MMCall (1)',
  `repetir1` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (1)',
  `escalar2` char(1) DEFAULT NULL COMMENT 'Escalar 2do',
  `tiempo2` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (2)',
  `lista2` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (2)',
  `log2` char(1) DEFAULT NULL COMMENT 'Generar LOG (2)',
  `sms2` char(1) DEFAULT NULL COMMENT 'Enviar SMS (2)',
  `correo2` char(1) DEFAULT NULL COMMENT 'Enviar correo (2)',
  `llamada2` char(1) DEFAULT NULL COMMENT 'Generar Llamada (2)',
  `mmcall2` char(1) DEFAULT NULL COMMENT 'Área de MMCall (2)',
  `repetir2` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (2)',
  `escalar3` char(1) DEFAULT NULL COMMENT 'Escalar 3ro',
  `tiempo3` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (3)',
  `lista3` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (3)',
  `log3` char(1) DEFAULT NULL COMMENT 'Generar LOG (3)',
  `sms3` char(1) DEFAULT NULL COMMENT 'Enviar SMS (3)',
  `correo3` char(1) DEFAULT NULL COMMENT 'Enviar correo (3)',
  `llamada3` char(1) DEFAULT NULL COMMENT 'Generar Llamada (3)',
  `mmcall3` char(1) DEFAULT NULL COMMENT 'Área de MMCall (3)',
  `repetir3` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (3)',
  `escalar4` char(1) DEFAULT NULL COMMENT 'Escalar 4to',
  `tiempo4` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (4)',
  `lista4` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (4)',
  `log4` char(1) DEFAULT NULL COMMENT 'Generar LOG (4)',
  `sms4` char(1) DEFAULT NULL COMMENT 'Enviar SMS (4)',
  `correo4` char(1) DEFAULT NULL COMMENT 'Enviar correo (4)',
  `llamada4` char(1) DEFAULT NULL COMMENT 'Generar Llamada (4)',
  `mmcall4` char(1) DEFAULT NULL COMMENT 'Área de MMCall (4)',
  `repetir4` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (4)',
  `escalar5` char(1) DEFAULT NULL COMMENT 'Escalar 5to',
  `tiempo5` bigint(8) DEFAULT '0' COMMENT 'Tiempo de escalación (5)',
  `lista5` bigint(11) DEFAULT '0' COMMENT 'Lista de distribución (5)',
  `log5` char(1) DEFAULT NULL COMMENT 'Generar LOG (5)',
  `sms5` char(1) DEFAULT NULL COMMENT 'Enviar SMS (5)',
  `correo5` char(1) DEFAULT NULL COMMENT 'Enviar correo (5)',
  `llamada5` char(1) DEFAULT NULL COMMENT 'Generar Llamada (5)',
  `mmcall5` char(1) DEFAULT NULL COMMENT 'Área de MMCall (5)',
  `repetir5` char(1) DEFAULT NULL COMMENT 'Repetir el escalamiento (5)',
  `repetir` char(1) DEFAULT NULL COMMENT 'Repetir llamada',
  `repetir_tiempo` bigint(8) DEFAULT '0' COMMENT 'Repetir llamada (segundos)',
  `repetir_log` char(1) DEFAULT NULL COMMENT 'Generar log en la repetición',
  `repetir_sms` char(1) DEFAULT NULL COMMENT 'Enviar SMS en la repetición',
  `repetir_correo` char(1) DEFAULT NULL COMMENT 'Enviar correo en la repetición',
  `repetir_llamada` char(1) DEFAULT NULL COMMENT 'Generar llamada en la repetición',
  `repetir_mmcall` char(1) DEFAULT NULL COMMENT 'Área de MMCall en la repetición',
  `activada` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de activación',
  `repetida` datetime DEFAULT NULL COMMENT 'Fecha de última repetición',
  `escalada1` datetime DEFAULT NULL COMMENT 'Fecha de escalamiento (1)',
  `escalada2` datetime DEFAULT NULL COMMENT 'Fecha de escalamiento (2)',
  `escalada3` datetime DEFAULT NULL COMMENT 'Fecha de escalamiento (3)',
  `escalada4` datetime DEFAULT NULL COMMENT 'Fecha de escalamiento (4)',
  `escalada5` datetime DEFAULT NULL COMMENT 'Fecha de escalamiento (5)',
  `atendida` datetime DEFAULT NULL COMMENT 'Fecha de cierre',
  `tiempo` int(8) DEFAULT '0' COMMENT 'Tiempo total en segundos',
  `escalamientos` int(1) DEFAULT '0' COMMENT 'Nivel de escalamiento',
  `estado` int(2) DEFAULT '0' COMMENT 'Estado de la alerta (0=Escuchando, 1=Activada, 2=Escalada N1, 3=Escalada N2, 4=Escalada N3, 5=Escalada N4, 6=Escalada N5)   ',
  `repeticiones` int(4) DEFAULT '0' COMMENT 'Número de repeticiones',
  `es1` int(4) DEFAULT '0' COMMENT 'Número de escaadas en nivel 1',
  `es2` int(4) DEFAULT '0' COMMENT 'Número de escaadas en nivel 2',
  `es3` int(4) DEFAULT '0' COMMENT 'Número de escaadas en nivel 3',
  `es4` int(4) DEFAULT '0' COMMENT 'Número de escaadas en nivel 4',
  `es5` int(4) DEFAULT '0' COMMENT 'Número de escaadas en nivel 5',
  `informar_resolucion` char(1) DEFAULT NULL COMMENT 'Informar de la resolución',
  `informado` char(1) DEFAULT 'N' COMMENT 'Informado de la resolución',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`alerta`),
  KEY `NewIndex2` (`estado`,`informar_resolucion`,`informado`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6151 ;

--
-- Volcado de datos para la tabla `vw_reportes`
--

INSERT INTO `vw_reportes` (`id`, `alerta`, `log`, `sms`, `correo`, `llamada`, `mmcall`, `lista`, `escalar1`, `tiempo1`, `lista1`, `log1`, `sms1`, `correo1`, `llamada1`, `mmcall1`, `repetir1`, `escalar2`, `tiempo2`, `lista2`, `log2`, `sms2`, `correo2`, `llamada2`, `mmcall2`, `repetir2`, `escalar3`, `tiempo3`, `lista3`, `log3`, `sms3`, `correo3`, `llamada3`, `mmcall3`, `repetir3`, `escalar4`, `tiempo4`, `lista4`, `log4`, `sms4`, `correo4`, `llamada4`, `mmcall4`, `repetir4`, `escalar5`, `tiempo5`, `lista5`, `log5`, `sms5`, `correo5`, `llamada5`, `mmcall5`, `repetir5`, `repetir`, `repetir_tiempo`, `repetir_log`, `repetir_sms`, `repetir_correo`, `repetir_llamada`, `repetir_mmcall`, `activada`, `repetida`, `escalada1`, `escalada2`, `escalada3`, `escalada4`, `escalada5`, `atendida`, `tiempo`, `escalamientos`, `estado`, `repeticiones`, `es1`, `es2`, `es3`, `es4`, `es5`, `informar_resolucion`, `informado`) VALUES
(6143, 59, NULL, 'N', 'S', 'N', 'S', 1, 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 'N', 0, NULL, NULL, NULL, NULL, NULL, '2019-09-02 12:20:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'S', 'N'),
(6144, 59, NULL, 'N', 'S', 'N', 'S', 1, 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 'N', 0, NULL, NULL, NULL, NULL, NULL, '2019-09-02 12:27:20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'S', 'N'),
(6145, 57, NULL, 'N', 'S', 'N', 'S', 1, 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 'N', 0, NULL, NULL, NULL, NULL, NULL, '2019-09-02 14:59:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'S', 'N'),
(6146, 58, NULL, 'N', 'S', 'N', 'S', 1, 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 'N', 0, NULL, NULL, NULL, NULL, NULL, '2019-09-02 18:18:52', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'S', 'N'),
(6147, 59, NULL, 'N', 'S', 'N', 'S', 1, 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 'N', 0, NULL, NULL, NULL, NULL, NULL, '2019-09-03 09:54:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'S', 'N'),
(6148, 59, NULL, 'N', 'S', 'N', 'S', 1, 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', 'N', 0, 0, NULL, 'N', 'S', 'N', 'N', 'N', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 'N', 0, NULL, NULL, NULL, NULL, NULL, '2019-09-03 09:57:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'S', 'N'),
(6149, 56, NULL, 'N', 'S', 'N', 'S', 1, 'T', 1800, 12, NULL, 'N', 'S', 'N', 'N', 'S', 'S', 1800, 15, NULL, 'N', 'S', 'N', 'N', 'S', 'T', 1800, 15, NULL, 'N', 'S', 'N', 'N', 'S', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 'S', 180, NULL, NULL, NULL, NULL, NULL, '2019-09-03 10:04:54', '2019-09-03 10:31:54', '2019-09-05 11:26:05', '2019-09-05 11:26:05', '2019-09-05 11:26:05', NULL, NULL, NULL, 0, 1, 4, 9, 5, 4, 3, 0, 0, 'S', 'N'),
(6150, 56, NULL, 'N', 'S', 'N', 'S', 1, 'T', 1800, 12, NULL, 'N', 'S', 'N', 'N', 'S', 'S', 1800, 15, NULL, 'N', 'S', 'N', 'N', 'S', 'T', 1800, 15, NULL, 'N', 'S', 'N', 'N', 'S', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 'S', 180, NULL, NULL, NULL, NULL, NULL, '2019-09-03 10:05:01', '2019-09-03 10:32:02', '2019-09-05 11:26:05', '2019-09-05 11:26:05', '2019-09-05 11:26:05', NULL, NULL, NULL, 0, 1, 4, 9, 5, 4, 3, 0, 0, 'S', 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vw_requester_mmcall`
--

CREATE TABLE IF NOT EXISTS `vw_requester_mmcall` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `secuencia` int(4) DEFAULT NULL COMMENT 'Secuencia del registro',
  `area` bigint(11) DEFAULT NULL COMMENT 'ID del área',
  `requester` varchar(100) DEFAULT NULL COMMENT 'ID del requester (MMCall)',
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`area`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Secuencia de llamadas para MMCall' AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vw_resumen`
--

CREATE TABLE IF NOT EXISTS `vw_resumen` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `desde` datetime DEFAULT NULL COMMENT 'Fecha desde',
  `hasta` datetime DEFAULT NULL COMMENT 'Fecha hasta',
  `nave` varchar(20) DEFAULT NULL COMMENT 'Nave',
  `estacion` varchar(50) DEFAULT NULL COMMENT 'Estacion',
  `responsable` varchar(50) DEFAULT NULL COMMENT 'Responsable',
  `tecnologia` varchar(50) DEFAULT NULL COMMENT 'Tecnologia',
  `codigo` varchar(50) DEFAULT NULL COMMENT 'Falla',
  `fallas_generadas` bigint(8) DEFAULT '0' COMMENT 'Fallas generadas en el período',
  `fallas_cerradas` bigint(8) DEFAULT '0' COMMENT 'Fallas cerradas en el período',
  `fallas_escaladas` bigint(8) DEFAULT '0' COMMENT 'FAllas cerradas escaladas',
  `fallas_entiempo` bigint(8) DEFAULT '0' COMMENT 'Fallas cerradas sin escalar',
  `fallas_total` bigint(8) DEFAULT '0' COMMENT 'Fallas abiertas (escaladas y no escaladas)',
  `creado` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`desde`),
  KEY `NewIndex2` (`responsable`,`tecnologia`,`codigo`),
  KEY `NewIndex3` (`responsable`),
  KEY `NewIndex4` (`tecnologia`),
  KEY `NewIndex5` (`codigo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Resumen de fallas y reportes' AUTO_INCREMENT=661928 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
