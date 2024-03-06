-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 06/03/2024 às 14:03
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `concessionariadb`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `cliente_id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`cliente_id`, `nome`, `endereco`, `email`, `telefone`) VALUES
(1, 'João da Silva', 'Rua das Flores, 123', 'joao@email.com', '123456789');

-- --------------------------------------------------------

--
-- Estrutura para tabela `fabricante`
--

CREATE TABLE `fabricante` (
  `fabricante_id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `pais_origem` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `fabricante`
--

INSERT INTO `fabricante` (`fabricante_id`, `nome`, `pais_origem`) VALUES
(1, 'Toyota', 'Japão'),
(2, 'Ford', 'Estados Unidos'),
(3, 'Volkswagen', 'Alemanha');

-- --------------------------------------------------------

--
-- Estrutura para tabela `itempedido`
--

CREATE TABLE `itempedido` (
  `item_id` int(11) NOT NULL,
  `pedido_id` int(11) DEFAULT NULL,
  `modelo_id` int(11) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `preco_unitario` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `itempedido`
--

INSERT INTO `itempedido` (`item_id`, `pedido_id`, `modelo_id`, `quantidade`, `preco_unitario`) VALUES
(1, 1, 1, 2, 30000.00),
(2, 1, 2, 1, 50000.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `modelo`
--

CREATE TABLE `modelo` (
  `modelo_id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `ano_fabricacao` int(11) DEFAULT NULL,
  `fabricante_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `modelo`
--

INSERT INTO `modelo` (`modelo_id`, `nome`, `ano_fabricacao`, `fabricante_id`) VALUES
(1, 'Corolla', 2022, 1),
(2, 'Mustang', 2021, 2),
(3, 'Golf', 2023, 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido`
--

CREATE TABLE `pedido` (
  `pedido_id` int(11) NOT NULL,
  `data_pedido` date DEFAULT NULL,
  `cliente_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pedido`
--

INSERT INTO `pedido` (`pedido_id`, `data_pedido`, `cliente_id`) VALUES
(1, '2024-03-06', 1);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_modelofabricante`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_modelofabricante` (
`modelo_id` int(11)
,`modelo_nome` varchar(50)
,`ano_fabricacao` int(11)
,`fabricante_nome` varchar(50)
,`pais_origem` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_pedidoinfo`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_pedidoinfo` (
`pedido_id` int(11)
,`data_pedido` date
,`cliente_nome` varchar(50)
,`cliente_email` varchar(50)
,`modelo_id` int(11)
,`quantidade` int(11)
,`preco_unitario` decimal(10,2)
,`total_item` decimal(20,2)
);

-- --------------------------------------------------------

--
-- Estrutura para view `vw_modelofabricante`
--
DROP TABLE IF EXISTS `vw_modelofabricante`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_modelofabricante`  AS SELECT `m`.`modelo_id` AS `modelo_id`, `m`.`nome` AS `modelo_nome`, `m`.`ano_fabricacao` AS `ano_fabricacao`, `f`.`nome` AS `fabricante_nome`, `f`.`pais_origem` AS `pais_origem` FROM (`modelo` `m` join `fabricante` `f` on(`m`.`fabricante_id` = `f`.`fabricante_id`)) ;

-- --------------------------------------------------------

--
-- Estrutura para view `vw_pedidoinfo`
--
DROP TABLE IF EXISTS `vw_pedidoinfo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_pedidoinfo`  AS SELECT `p`.`pedido_id` AS `pedido_id`, `p`.`data_pedido` AS `data_pedido`, `c`.`nome` AS `cliente_nome`, `c`.`email` AS `cliente_email`, `ip`.`modelo_id` AS `modelo_id`, `ip`.`quantidade` AS `quantidade`, `ip`.`preco_unitario` AS `preco_unitario`, `ip`.`quantidade`* `ip`.`preco_unitario` AS `total_item` FROM ((`pedido` `p` join `cliente` `c` on(`p`.`cliente_id` = `c`.`cliente_id`)) join `itempedido` `ip` on(`p`.`pedido_id` = `ip`.`pedido_id`)) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cliente_id`);

--
-- Índices de tabela `fabricante`
--
ALTER TABLE `fabricante`
  ADD PRIMARY KEY (`fabricante_id`);

--
-- Índices de tabela `itempedido`
--
ALTER TABLE `itempedido`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `modelo_id` (`modelo_id`);

--
-- Índices de tabela `modelo`
--
ALTER TABLE `modelo`
  ADD PRIMARY KEY (`modelo_id`),
  ADD KEY `fabricante_id` (`fabricante_id`);

--
-- Índices de tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`pedido_id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `cliente_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `fabricante`
--
ALTER TABLE `fabricante`
  MODIFY `fabricante_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `itempedido`
--
ALTER TABLE `itempedido`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `modelo`
--
ALTER TABLE `modelo`
  MODIFY `modelo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `pedido`
--
ALTER TABLE `pedido`
  MODIFY `pedido_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `itempedido`
--
ALTER TABLE `itempedido`
  ADD CONSTRAINT `itempedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`pedido_id`),
  ADD CONSTRAINT `itempedido_ibfk_2` FOREIGN KEY (`modelo_id`) REFERENCES `modelo` (`modelo_id`);

--
-- Restrições para tabelas `modelo`
--
ALTER TABLE `modelo`
  ADD CONSTRAINT `modelo_ibfk_1` FOREIGN KEY (`fabricante_id`) REFERENCES `fabricante` (`fabricante_id`);

--
-- Restrições para tabelas `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`cliente_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
