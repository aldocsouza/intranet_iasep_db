-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema intranet_iasep
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema intranet_iasep
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `intranet_iasep` DEFAULT CHARACTER SET utf8 ;
USE `intranet_iasep` ;

-- -----------------------------------------------------
-- Table `intranet_iasep`.`seg_perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`seg_perfil` (
  `cod_perfil` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  `admin` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`cod_perfil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_tipo_vinculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_tipo_vinculo` (
  `cod_tipo_vinculo` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NOT NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo_vinculo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_regime_juridico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_regime_juridico` (
  `cod_regime_juridico` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NOT NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_regime_juridico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_srv_tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_srv_tipo` (
  `cod_tipo` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_tipo` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(150) NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_municipio_lotacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_municipio_lotacao` (
  `cod_municipio` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_municipio` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(150) NULL,
  `situacao` TINYINT NOT NULL,
  PRIMARY KEY (`cod_municipio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_servidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_servidor` (
  `cod_servidor` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `num_matricula` VARCHAR(10) NOT NULL,
  `num_vinculo` VARCHAR(2) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `email` VARCHAR(155) NOT NULL,
  `sexo` VARCHAR(1) NOT NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  `cod_tipo_vinculo` BIGINT NULL,
  `cod_regime_juridico` BIGINT NULL,
  `cod_srv_tipo` BIGINT NOT NULL,
  `cod_municipio_lotacao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_servidor`),
  INDEX `fk_servidor_tipo_vinculo1_idx` (`cod_tipo_vinculo` ASC) VISIBLE,
  INDEX `fk_rh_servidor_rh_regime_juridico1_idx` (`cod_regime_juridico` ASC) VISIBLE,
  INDEX `fk_rh_servidor_rh_tipo_funcionario1_idx` (`cod_srv_tipo` ASC) VISIBLE,
  INDEX `fk_rh_servidor_rh_municipio_lotacao1_idx` (`cod_municipio_lotacao` ASC) VISIBLE,
  CONSTRAINT `fk_servidor_tipo_vinculo1`
    FOREIGN KEY (`cod_tipo_vinculo`)
    REFERENCES `intranet_iasep`.`rh_tipo_vinculo` (`cod_tipo_vinculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rh_servidor_rh_regime_juridico1`
    FOREIGN KEY (`cod_regime_juridico`)
    REFERENCES `intranet_iasep`.`rh_regime_juridico` (`cod_regime_juridico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rh_servidor_rh_tipo_funcionario1`
    FOREIGN KEY (`cod_srv_tipo`)
    REFERENCES `intranet_iasep`.`rh_srv_tipo` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rh_servidor_rh_municipio_lotacao1`
    FOREIGN KEY (`cod_municipio_lotacao`)
    REFERENCES `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`seg_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`seg_usuario` (
  `cod_usuario` BIGINT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(100) NOT NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  `cod_perfil` BIGINT NOT NULL,
  `cod_servidor` BIGINT NULL,
  PRIMARY KEY (`cod_usuario`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE,
  INDEX `fk_usuario_perfil_idx` (`cod_perfil` ASC) VISIBLE,
  INDEX `fk_seg_usuario_rh_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_perfil`
    FOREIGN KEY (`cod_perfil`)
    REFERENCES `intranet_iasep`.`seg_perfil` (`cod_perfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seg_usuario_rh_servidor1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`seg_funcionalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`seg_funcionalidade` (
  `cod_funcionalidade` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  `cod_funcionalidade_pai` BIGINT NULL,
  PRIMARY KEY (`cod_funcionalidade`),
  INDEX `fk_seg_funcionalidade_seg_funcionalidade1_idx` (`cod_funcionalidade_pai` ASC) VISIBLE,
  CONSTRAINT `fk_seg_funcionalidade_seg_funcionalidade1`
    FOREIGN KEY (`cod_funcionalidade_pai`)
    REFERENCES `intranet_iasep`.`seg_funcionalidade` (`cod_funcionalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`seg_perfil_funcionalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`seg_perfil_funcionalidade` (
  `cod_perfil` BIGINT NOT NULL,
  `cod_funcionalidade` BIGINT NOT NULL,
  `leitura` TINYINT NOT NULL DEFAULT 0,
  `escrita` TINYINT NOT NULL DEFAULT 0,
  `excluir` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`cod_perfil`, `cod_funcionalidade`),
  INDEX `fk_perfil_has_funcionalidade_funcionalidade1_idx` (`cod_funcionalidade` ASC) VISIBLE,
  INDEX `fk_perfil_has_funcionalidade_perfil1_idx` (`cod_perfil` ASC) VISIBLE,
  CONSTRAINT `fk_perfil_has_funcionalidade_perfil1`
    FOREIGN KEY (`cod_perfil`)
    REFERENCES `intranet_iasep`.`seg_perfil` (`cod_perfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_perfil_has_funcionalidade_funcionalidade1`
    FOREIGN KEY (`cod_funcionalidade`)
    REFERENCES `intranet_iasep`.`seg_funcionalidade` (`cod_funcionalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_tipo_documento_pessoal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_tipo_documento_pessoal` (
  `cod_tipo` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(155) NOT NULL,
  `descricao` VARCHAR(255) NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`cad_srv_endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`cad_srv_endereco` (
  `cod_endereco` BIGINT NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(155) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(155) NULL,
  `bairro` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  `cod_servidor` BIGINT NOT NULL,
  PRIMARY KEY (`cod_endereco`),
  INDEX `fk_endereco_tipo_documentos_pessoais1_idx` (`cod_servidor` ASC) VISIBLE,
  CONSTRAINT `fk_endereco_tipo_documentos_pessoais1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_lotacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_lotacao` (
  `cod_lotacao` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(155) NOT NULL,
  `sigla` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  `lotacao_sigirh` VARCHAR(100) NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  `cod_municipio` BIGINT NOT NULL,
  `cod_lotacao_pai` BIGINT NULL,
  `cod_servidor_titular` BIGINT NULL,
  PRIMARY KEY (`cod_lotacao`),
  INDEX `fk_rh_lotacao_rh_lotacao1_idx` (`cod_lotacao_pai` ASC) VISIBLE,
  INDEX `fk_rh_lotacao_rh_servidor1_idx` (`cod_servidor_titular` ASC) VISIBLE,
  INDEX `fk_rh_lotacao_rh_municipio_lotacao1_idx` (`cod_municipio` ASC) VISIBLE,
  CONSTRAINT `fk_rh_lotacao_rh_lotacao1`
    FOREIGN KEY (`cod_lotacao_pai`)
    REFERENCES `intranet_iasep`.`rh_lotacao` (`cod_lotacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rh_lotacao_rh_servidor1`
    FOREIGN KEY (`cod_servidor_titular`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rh_lotacao_rh_municipio_lotacao1`
    FOREIGN KEY (`cod_municipio`)
    REFERENCES `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`cad_srv_lotacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`cad_srv_lotacao` (
  `cod_srv_lotacao` BIGINT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE NOT NULL,
  `data_final` DATE NULL,
  `lotacao_atual` TINYINT NOT NULL DEFAULT 1,
  `cod_lotacao` BIGINT NOT NULL,
  `cod_servidor` BIGINT NOT NULL,
  PRIMARY KEY (`cod_srv_lotacao`),
  INDEX `fk_lotacao_setor1_idx` (`cod_lotacao` ASC) VISIBLE,
  INDEX `fk_cad_serv_lotacao_rh_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  CONSTRAINT `fk_lotacao_setor1`
    FOREIGN KEY (`cod_lotacao`)
    REFERENCES `intranet_iasep`.`rh_lotacao` (`cod_lotacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cad_serv_lotacao_rh_servidor1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_justificativa_movimentacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_justificativa_movimentacao` (
  `cod_justificativa` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_justificativa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`upload_lotacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`upload_lotacao` (
  `cod_documento` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NOT NULL DEFAULT 0,
  `cod_lotacao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_documento`),
  INDEX `fk_documento_lotacao_lotacao1_idx` (`cod_lotacao` ASC) VISIBLE,
  CONSTRAINT `fk_documento_lotacao_lotacao1`
    FOREIGN KEY (`cod_lotacao`)
    REFERENCES `intranet_iasep`.`cad_srv_lotacao` (`cod_srv_lotacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_escolaridade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_escolaridade` (
  `cod_escolaridade` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_escolaridade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`cad_srv_formacao_academica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`cad_srv_formacao_academica` (
  `cod_formacao` BIGINT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE NOT NULL,
  `data_conclusao` DATE NOT NULL,
  `nome_curso` VARCHAR(155) NOT NULL,
  `nome_instituicao` VARCHAR(155) NOT NULL,
  `cod_escolaridade` BIGINT NOT NULL,
  `cod_servidor` BIGINT NOT NULL,
  PRIMARY KEY (`cod_formacao`),
  INDEX `fk_formacao_academica_nivel_instrucao1_idx` (`cod_escolaridade` ASC) VISIBLE,
  INDEX `fk_formacao_academica_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  CONSTRAINT `fk_formacao_academica_nivel_instrucao1`
    FOREIGN KEY (`cod_escolaridade`)
    REFERENCES `intranet_iasep`.`rh_escolaridade` (`cod_escolaridade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_formacao_academica_servidor1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_tipo_documento_formacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_tipo_documento_formacao` (
  `cod_tipo` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`upload_formacao_academica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`upload_formacao_academica` (
  `cod_documento` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NOT NULL DEFAULT 0,
  `cod_formacao` BIGINT NOT NULL,
  `cod_tipo_documento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_documento`),
  INDEX `fk_documento_formacao_academica_formacao_academica1_idx` (`cod_formacao` ASC) VISIBLE,
  INDEX `fk_upload_formacao_academica_rh_tipo_documento_formacao1_idx` (`cod_tipo_documento` ASC) VISIBLE,
  CONSTRAINT `fk_documento_formacao_academica_formacao_academica1`
    FOREIGN KEY (`cod_formacao`)
    REFERENCES `intranet_iasep`.`cad_srv_formacao_academica` (`cod_formacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_upload_formacao_academica_rh_tipo_documento_formacao1`
    FOREIGN KEY (`cod_tipo_documento`)
    REFERENCES `intranet_iasep`.`rh_tipo_documento_formacao` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`cad_srv_formacao_complementar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`cad_srv_formacao_complementar` (
  `cod_formacao` BIGINT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE NOT NULL,
  `data_conclusao` DATE NOT NULL,
  `nome_curso` VARCHAR(155) NOT NULL,
  `nome_instituicao` VARCHAR(155) NOT NULL,
  `carga_horaria` VARCHAR(10) NOT NULL,
  `cod_servidor` BIGINT NOT NULL,
  PRIMARY KEY (`cod_formacao`),
  INDEX `fk_formacao_complementar_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  CONSTRAINT `fk_formacao_complementar_servidor1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`upload_formacao_complementar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`upload_formacao_complementar` (
  `cod_documento` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NOT NULL DEFAULT 0,
  `cod_formacao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_documento`),
  INDEX `fk_documento_formacao_complementar_formacao_complementar1_idx` (`cod_formacao` ASC) VISIBLE,
  CONSTRAINT `fk_documento_formacao_complementar_formacao_complementar1`
    FOREIGN KEY (`cod_formacao`)
    REFERENCES `intranet_iasep`.`cad_srv_formacao_complementar` (`cod_formacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_tipo_afastamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_tipo_afastamento` (
  `cod_tipo` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(155) NOT NULL,
  `descricao` VARCHAR(255) NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`cad_srv_afastamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`cad_srv_afastamento` (
  `cod_afastamento` BIGINT NOT NULL AUTO_INCREMENT,
  `numero_processo` VARCHAR(45) NULL,
  `descricao` VARCHAR(100) NULL,
  `data_inicio` DATE NOT NULL,
  `data_final` DATE NULL,
  `cod_servidor` BIGINT NOT NULL,
  `cod_tipo_afastamento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_afastamento`),
  INDEX `fk_afastamento_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  INDEX `fk_afastamento_tipo_afastamento1_idx` (`cod_tipo_afastamento` ASC) VISIBLE,
  CONSTRAINT `fk_afastamento_servidor1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_afastamento_tipo_afastamento1`
    FOREIGN KEY (`cod_tipo_afastamento`)
    REFERENCES `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`upload_afastamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`upload_afastamento` (
  `cod_documento` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NOT NULL DEFAULT 0,
  `cod_afastamento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_documento`),
  INDEX `fk_documento_afastamento_afastamento1_idx` (`cod_afastamento` ASC) VISIBLE,
  CONSTRAINT `fk_documento_afastamento_afastamento1`
    FOREIGN KEY (`cod_afastamento`)
    REFERENCES `intranet_iasep`.`cad_srv_afastamento` (`cod_afastamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_tipo_comissao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_tipo_comissao` (
  `cod_tipo` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_funcao_comissao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_funcao_comissao` (
  `cod_funcao` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  PRIMARY KEY (`cod_funcao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`cad_srv_comissao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`cad_srv_comissao` (
  `cod_comissao` BIGINT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE NOT NULL,
  `data_final` DATE NULL,
  `descricao` VARCHAR(155) NULL,
  `cod_tipo_comissao` BIGINT NOT NULL,
  `cod_servidor` BIGINT NOT NULL,
  `cod_funcao_comissao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_comissao`),
  INDEX `fk_comissao_tipo_comissao1_idx` (`cod_tipo_comissao` ASC) VISIBLE,
  INDEX `fk_comissao_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  INDEX `fk_cad_srv_comissao_funcao_comissao1_idx` (`cod_funcao_comissao` ASC) VISIBLE,
  CONSTRAINT `fk_comissao_tipo_comissao1`
    FOREIGN KEY (`cod_tipo_comissao`)
    REFERENCES `intranet_iasep`.`rh_tipo_comissao` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comissao_servidor1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cad_srv_comissao_funcao_comissao1`
    FOREIGN KEY (`cod_funcao_comissao`)
    REFERENCES `intranet_iasep`.`rh_funcao_comissao` (`cod_funcao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`upload_comissao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`upload_comissao` (
  `cod_documento` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NOT NULL DEFAULT 0,
  `cod_comissao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_documento`),
  INDEX `fk_documento_comissao_comissao1_idx` (`cod_comissao` ASC) VISIBLE,
  CONSTRAINT `fk_documento_comissao_comissao1`
    FOREIGN KEY (`cod_comissao`)
    REFERENCES `intranet_iasep`.`cad_srv_comissao` (`cod_comissao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`ff_folha_frequencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`ff_folha_frequencia` (
  `cod_folha` BIGINT NOT NULL AUTO_INCREMENT,
  `mes` VARCHAR(2) NOT NULL,
  `ano` VARCHAR(4) NOT NULL,
  `descricao` VARCHAR(255) NULL,
  `ativo` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_folha`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`ff_situacao_folha_frequencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`ff_situacao_folha_frequencia` (
  `cod_situacao` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(155) NOT NULL,
  `ativo` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_situacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`ff_servidor_folha_frequencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`ff_servidor_folha_frequencia` (
  `cod_servidor_folha` BIGINT NOT NULL AUTO_INCREMENT,
  `data_assinatura` TIMESTAMP NULL,
  `homologado_por` BIGINT NULL,
  `data_homologacao` TIMESTAMP NULL,
  `observacao` VARCHAR(255) NULL,
  `situacao` BIGINT NOT NULL,
  `cod_folha` BIGINT NOT NULL,
  `cod_servidor` BIGINT NOT NULL,
  PRIMARY KEY (`cod_servidor_folha`),
  INDEX `fk_rh_servidor_has_rh_folha_frequencia_rh_folha_frequencia1_idx` (`cod_folha` ASC) VISIBLE,
  INDEX `fk_rh_servidor_has_rh_folha_frequencia_rh_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  INDEX `fk_ff_servidor_folha_frequencia_ff_situacao_folha_frequenci_idx` (`situacao` ASC) VISIBLE,
  CONSTRAINT `fk_rh_servidor_has_rh_folha_frequencia_rh_servidor1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rh_servidor_has_rh_folha_frequencia_rh_folha_frequencia1`
    FOREIGN KEY (`cod_folha`)
    REFERENCES `intranet_iasep`.`ff_folha_frequencia` (`cod_folha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ff_servidor_folha_frequencia_ff_situacao_folha_frequencia1`
    FOREIGN KEY (`situacao`)
    REFERENCES `intranet_iasep`.`ff_situacao_folha_frequencia` (`cod_situacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`upload_folha_frequencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`upload_folha_frequencia` (
  `cod_documento` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NOT NULL DEFAULT 0,
  `cod_frequencia` BIGINT NOT NULL,
  `cod_servidor_folha` BIGINT NOT NULL,
  PRIMARY KEY (`cod_documento`),
  INDEX `fk_upload_folha_frequencia_ff_servidor_folha_frequencia1_idx` (`cod_servidor_folha` ASC) VISIBLE,
  CONSTRAINT `fk_upload_folha_frequencia_ff_servidor_folha_frequencia1`
    FOREIGN KEY (`cod_servidor_folha`)
    REFERENCES `intranet_iasep`.`ff_servidor_folha_frequencia` (`cod_servidor_folha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_tipo_declaracao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_tipo_declaracao` (
  `cod_tipo` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`cad_srv_declaracao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`cad_srv_declaracao` (
  `cod_declaracao` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(155) NULL,
  `cod_tipo_declaracao` BIGINT NOT NULL,
  `cod_servidor` BIGINT NOT NULL,
  PRIMARY KEY (`cod_declaracao`),
  INDEX `fk_declaracao_tipo_declaracao1_idx` (`cod_tipo_declaracao` ASC) VISIBLE,
  INDEX `fk_declaracao_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  CONSTRAINT `fk_declaracao_tipo_declaracao1`
    FOREIGN KEY (`cod_tipo_declaracao`)
    REFERENCES `intranet_iasep`.`rh_tipo_declaracao` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_declaracao_servidor1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`upload_declaracao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`upload_declaracao` (
  `cod_documento` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NOT NULL DEFAULT 0,
  `cod_declaracao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_documento`),
  INDEX `fk_documento_declaracao_declaracao1_idx` (`cod_declaracao` ASC) VISIBLE,
  CONSTRAINT `fk_documento_declaracao_declaracao1`
    FOREIGN KEY (`cod_declaracao`)
    REFERENCES `intranet_iasep`.`cad_srv_declaracao` (`cod_declaracao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_tipo_licenca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_tipo_licenca` (
  `cod_tipo` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(255) NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`cad_srv_licenca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`cad_srv_licenca` (
  `cod_licenca` BIGINT NOT NULL AUTO_INCREMENT,
  `numero_processo` VARCHAR(45) NULL,
  `data_inicio` DATE NULL,
  `data_fim` DATE NULL,
  `numero_portaria` VARCHAR(45) NULL,
  `data_portaria` DATE NULL,
  `data_inicio_aquisitivo` DATE NULL,
  `data_fim_aquisitivo` DATE NULL,
  `cod_tipo_licenca` BIGINT NOT NULL,
  `cod_servidor` BIGINT NOT NULL,
  PRIMARY KEY (`cod_licenca`),
  INDEX `fk_licenca_tipo_licenca1_idx` (`cod_tipo_licenca` ASC) VISIBLE,
  INDEX `fk_licenca_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  CONSTRAINT `fk_licenca_tipo_licenca1`
    FOREIGN KEY (`cod_tipo_licenca`)
    REFERENCES `intranet_iasep`.`rh_tipo_licenca` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_licenca_servidor1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`upload_licenca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`upload_licenca` (
  `cod_documento` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NOT NULL DEFAULT 0,
  `cod_licenca` BIGINT NOT NULL,
  PRIMARY KEY (`cod_documento`),
  INDEX `fk_documento_declaracao_copy1_licenca1_idx` (`cod_licenca` ASC) VISIBLE,
  CONSTRAINT `fk_documento_declaracao_copy1_licenca1`
    FOREIGN KEY (`cod_licenca`)
    REFERENCES `intranet_iasep`.`cad_srv_licenca` (`cod_licenca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_tipo_documento_funcional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_tipo_documento_funcional` (
  `cod_tipo` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`cad_documento_funcional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`cad_documento_funcional` (
  `cod_documento` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  `cod_servidor` BIGINT NOT NULL,
  `cod_tipo_documento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_documento`),
  INDEX `fk_documento_funcional_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  INDEX `fk_documento_funcional_tipo_documento_funcional1_idx` (`cod_tipo_documento` ASC) VISIBLE,
  CONSTRAINT `fk_documento_funcional_servidor1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documento_funcional_tipo_documento_funcional1`
    FOREIGN KEY (`cod_tipo_documento`)
    REFERENCES `intranet_iasep`.`rh_tipo_documento_funcional` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_cargo_funcao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_cargo_funcao` (
  `cod_cargo_funcao` BIGINT NOT NULL AUTO_INCREMENT,
  `cod_cargo_sigirh` VARCHAR(20) NOT NULL,
  `nome_cargo_funcao` VARCHAR(100) NOT NULL,
  `funcao` TINYINT NOT NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  `cod_escolaridade` BIGINT NOT NULL,
  PRIMARY KEY (`cod_cargo_funcao`),
  INDEX `fk_rh_cargo_funcao_rh_escolaridade1_idx` (`cod_escolaridade` ASC) VISIBLE,
  CONSTRAINT `fk_rh_cargo_funcao_rh_escolaridade1`
    FOREIGN KEY (`cod_escolaridade`)
    REFERENCES `intranet_iasep`.`rh_escolaridade` (`cod_escolaridade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`cad_srv_cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`cad_srv_cargo` (
  `cod_servidor_cargo` BIGINT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE NULL,
  `data_final` DATE NULL,
  `cargo_atual` TINYINT NOT NULL DEFAULT 1,
  `cod_servidor` BIGINT NOT NULL,
  `cod_cargo_funcao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_servidor_cargo`),
  INDEX `fk_cargo_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  INDEX `fk_cargo_lista_cargo1_idx` (`cod_cargo_funcao` ASC) VISIBLE,
  CONSTRAINT `fk_cargo_servidor1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cargo_lista_cargo1`
    FOREIGN KEY (`cod_cargo_funcao`)
    REFERENCES `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`upload_documento_funcional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`upload_documento_funcional` (
  `cod_documento` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NOT NULL DEFAULT 0,
  `cod_cad_documento` BIGINT NULL,
  `cod_cargo` BIGINT NULL,
  PRIMARY KEY (`cod_documento`),
  INDEX `fk_upload_documento_funcional_documento_funcional1_idx` (`cod_cad_documento` ASC) VISIBLE,
  INDEX `fk_upload_documento_funcional_cargo1_idx` (`cod_cargo` ASC) VISIBLE,
  CONSTRAINT `fk_upload_documento_funcional_documento_funcional1`
    FOREIGN KEY (`cod_cad_documento`)
    REFERENCES `intranet_iasep`.`cad_documento_funcional` (`cod_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_upload_documento_funcional_cargo1`
    FOREIGN KEY (`cod_cargo`)
    REFERENCES `intranet_iasep`.`cad_srv_cargo` (`cod_servidor_cargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_usuario` (
  `cod_hst` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `login` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(100) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `num_matricula` VARCHAR(10) NOT NULL,
  `num_vinculo` VARCHAR(2) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `email` VARCHAR(155) NOT NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  `cod_perfil` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`cod_hst`),
  INDEX `fk_historico_usuario_usuario1_idx` (`cod_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_historico_usuario_usuario1`
    FOREIGN KEY (`cod_usuario`)
    REFERENCES `intranet_iasep`.`seg_usuario` (`cod_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_perfil` (
  `cod_hst` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `situacao` TINYINT NOT NULL,
  `admin` TINYINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_perfil` BIGINT NOT NULL,
  PRIMARY KEY (`cod_hst`),
  INDEX `fk_historico_perfil_perfil1_idx` (`cod_perfil` ASC) VISIBLE,
  CONSTRAINT `fk_historico_perfil_perfil1`
    FOREIGN KEY (`cod_perfil`)
    REFERENCES `intranet_iasep`.`seg_perfil` (`cod_perfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_perfil_funcionalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_perfil_funcionalidade` (
  `cod_hst` BIGINT NOT NULL AUTO_INCREMENT,
  `leitura` TINYINT NOT NULL,
  `escrita` TINYINT NOT NULL,
  `excluir` TINYINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_perfil` BIGINT NOT NULL,
  `cod_funcionalidade` BIGINT NOT NULL,
  PRIMARY KEY (`cod_hst`),
  INDEX `fk_historico_perfil_funcionalidade_perfil_funcionalidade1_idx` (`cod_perfil` ASC, `cod_funcionalidade` ASC) VISIBLE,
  CONSTRAINT `fk_historico_perfil_funcionalidade_perfil_funcionalidade1`
    FOREIGN KEY (`cod_perfil` , `cod_funcionalidade`)
    REFERENCES `intranet_iasep`.`seg_perfil_funcionalidade` (`cod_perfil` , `cod_funcionalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_servidor_cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_servidor_cargo` (
  `cod_historico` BIGINT NOT NULL,
  `data_inicio` DATE NULL,
  `data_final` DATE NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_lista_cargo` BIGINT NOT NULL,
  `cod_cargo` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_cargo_cargo1_idx` (`cod_cargo` ASC) VISIBLE,
  CONSTRAINT `fk_historico_cargo_cargo1`
    FOREIGN KEY (`cod_cargo`)
    REFERENCES `intranet_iasep`.`cad_srv_cargo` (`cod_servidor_cargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_servidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_servidor` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL,
  `num_matricula` VARCHAR(10) NULL,
  `num_vinculo` VARCHAR(2) NULL,
  `cpf` VARCHAR(11) NULL,
  `rg` VARCHAR(10) NULL,
  `titulo_eleitor` VARCHAR(12) NULL,
  `data_nascimento` DATE NULL,
  `telefone` VARCHAR(11) NULL,
  `email` VARCHAR(155) NULL,
  `situacao` TINYINT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_servidor` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_servidor_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  CONSTRAINT `fk_historico_servidor_servidor1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`historico_endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`historico_endereco` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `rua` VARCHAR(255) NULL,
  `numero` VARCHAR(45) NULL,
  `logradouro` VARCHAR(100) NULL,
  `bairro` VARCHAR(100) NULL,
  `cidade` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  `cep` VARCHAR(8) NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_endereco` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_endereco_endereco1_idx` (`cod_endereco` ASC) VISIBLE,
  CONSTRAINT `fk_historico_endereco_endereco1`
    FOREIGN KEY (`cod_endereco`)
    REFERENCES `intranet_iasep`.`cad_srv_endereco` (`cod_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`historico_tipo_documento_funcional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`historico_tipo_documento_funcional` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  `situacao` TINYINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_tipo_documento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_tipo_documento_funcional_tipo_documento_funcio_idx` (`cod_tipo_documento` ASC) VISIBLE,
  CONSTRAINT `fk_historico_tipo_documento_funcional_tipo_documento_funcional1`
    FOREIGN KEY (`cod_tipo_documento`)
    REFERENCES `intranet_iasep`.`rh_tipo_documento_funcional` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_documento_funcional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_documento_funcional` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_tipo_documento` BIGINT NOT NULL,
  `cod_documento_funcional` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_documento_funcional_copy1_documento_funcional1_idx` (`cod_documento_funcional` ASC) VISIBLE,
  CONSTRAINT `fk_documento_funcional_copy1_documento_funcional1`
    FOREIGN KEY (`cod_documento_funcional`)
    REFERENCES `intranet_iasep`.`cad_documento_funcional` (`cod_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_srv_comissao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_srv_comissao` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE NOT NULL,
  `data_final` DATE NULL,
  `cod_tipo_comissao` BIGINT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_comissao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_comissao_comissao1_idx` (`cod_comissao` ASC) VISIBLE,
  CONSTRAINT `fk_historico_comissao_comissao1`
    FOREIGN KEY (`cod_comissao`)
    REFERENCES `intranet_iasep`.`cad_srv_comissao` (`cod_comissao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_tipo_comissao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_tipo_comissao` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  `situacao` TINYINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_tipo` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_tipo_comissao_tipo_comissao1_idx` (`cod_tipo` ASC) VISIBLE,
  CONSTRAINT `fk_historico_tipo_comissao_tipo_comissao1`
    FOREIGN KEY (`cod_tipo`)
    REFERENCES `intranet_iasep`.`rh_tipo_comissao` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_funcao_comissao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_funcao_comissao` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  `cod_tipo_comissao` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_funcao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_funcao_comissao_funcao_comissao1_idx` (`cod_funcao` ASC) VISIBLE,
  CONSTRAINT `fk_historico_funcao_comissao_funcao_comissao1`
    FOREIGN KEY (`cod_funcao`)
    REFERENCES `intranet_iasep`.`rh_funcao_comissao` (`cod_funcao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_srv_afastamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_srv_afastamento` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `numero_processo` VARCHAR(45) NULL,
  `descricao` VARCHAR(100) NULL,
  `data_inicio` DATE NOT NULL,
  `data_final` DATE NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_tipo` BIGINT NOT NULL,
  `cod_afastamento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_afastamento_afastamento1_idx` (`cod_afastamento` ASC) VISIBLE,
  CONSTRAINT `fk_historico_afastamento_afastamento1`
    FOREIGN KEY (`cod_afastamento`)
    REFERENCES `intranet_iasep`.`cad_srv_afastamento` (`cod_afastamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_tipo_afastamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_tipo_afastamento` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  `situacao` TINYINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_tipo` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_tipo_afastamento_tipo_afastamento1_idx` (`cod_tipo` ASC) VISIBLE,
  CONSTRAINT `fk_historico_tipo_afastamento_tipo_afastamento1`
    FOREIGN KEY (`cod_tipo`)
    REFERENCES `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_licenca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_licenca` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `numero_processo` VARCHAR(45) NULL,
  `data_inicio` DATE NULL,
  `data_fim` DATE NULL,
  `numero_portaria` VARCHAR(45) NULL,
  `data_portaria` DATE NULL,
  `data_inicio_aquisitivo` DATE NULL,
  `data_fim_aquisitivo` DATE NULL,
  `cod_tipo_licenca` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_licenca` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_licenca_licenca1_idx` (`cod_licenca` ASC) VISIBLE,
  CONSTRAINT `fk_historico_licenca_licenca1`
    FOREIGN KEY (`cod_licenca`)
    REFERENCES `intranet_iasep`.`cad_srv_licenca` (`cod_licenca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_tipo_licenca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_tipo_licenca` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  `situacao` TINYINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_tipo` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_tipo_licenca_tipo_licenca1_idx` (`cod_tipo` ASC) VISIBLE,
  CONSTRAINT `fk_historico_tipo_licenca_tipo_licenca1`
    FOREIGN KEY (`cod_tipo`)
    REFERENCES `intranet_iasep`.`rh_tipo_licenca` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_srv_declaracao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_srv_declaracao` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(155) NULL,
  `cod_tipo_declaracao` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_declaracao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_declaracao_declaracao1_idx` (`cod_declaracao` ASC) VISIBLE,
  CONSTRAINT `fk_historico_declaracao_declaracao1`
    FOREIGN KEY (`cod_declaracao`)
    REFERENCES `intranet_iasep`.`cad_srv_declaracao` (`cod_declaracao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_tipo_declaracao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_tipo_declaracao` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_tipo` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_tipo_declaracao_tipo_declaracao1_idx` (`cod_tipo` ASC) VISIBLE,
  CONSTRAINT `fk_historico_tipo_declaracao_tipo_declaracao1`
    FOREIGN KEY (`cod_tipo`)
    REFERENCES `intranet_iasep`.`rh_tipo_declaracao` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_formacao_complementar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_formacao_complementar` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE NULL,
  `data_final` DATE NULL,
  `nome_curso` VARCHAR(155) NULL,
  `nome_instituicao` VARCHAR(155) NULL,
  `carga_horaria` VARCHAR(10) NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_formacao_complementar` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_formacao_complementar_formacao_complementar1_idx` (`cod_formacao_complementar` ASC) VISIBLE,
  CONSTRAINT `fk_historico_formacao_complementar_formacao_complementar1`
    FOREIGN KEY (`cod_formacao_complementar`)
    REFERENCES `intranet_iasep`.`cad_srv_formacao_complementar` (`cod_formacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_formacao_academica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_formacao_academica` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE NOT NULL,
  `data_final` DATE NOT NULL,
  `nome_curso` VARCHAR(155) NOT NULL,
  `nome_instituicao` VARCHAR(155) NOT NULL,
  `cod_escolaridade` BIGINT NOT NULL,
  `cod_tipo_documento` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_formacao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_formacao_academica_formacao_academica1_idx` (`cod_formacao` ASC) VISIBLE,
  CONSTRAINT `fk_historico_formacao_academica_formacao_academica1`
    FOREIGN KEY (`cod_formacao`)
    REFERENCES `intranet_iasep`.`cad_srv_formacao_academica` (`cod_formacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_escolaridade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_escolaridade` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `situacao` TINYINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_nivel` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_nivel_instrucao_nivel_instrucao1_idx` (`cod_nivel` ASC) VISIBLE,
  CONSTRAINT `fk_historico_nivel_instrucao_nivel_instrucao1`
    FOREIGN KEY (`cod_nivel`)
    REFERENCES `intranet_iasep`.`rh_escolaridade` (`cod_escolaridade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_lotacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_lotacao` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(155) NOT NULL,
  `sigla` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  `lotacao_sigirh` INT NOT NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_lotacao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_lotacao_rh_lotacao1_idx` (`cod_lotacao` ASC) VISIBLE,
  CONSTRAINT `fk_hist_lotacao_rh_lotacao1`
    FOREIGN KEY (`cod_lotacao`)
    REFERENCES `intranet_iasep`.`rh_lotacao` (`cod_lotacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_funcionalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_funcionalidade` (
  `cod_hst` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(155) NOT NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_funcionalidade` BIGINT NOT NULL,
  PRIMARY KEY (`cod_hst`),
  INDEX `fk_historico_funcionalidade_funcionalidade1_idx` (`cod_funcionalidade` ASC) VISIBLE,
  CONSTRAINT `fk_historico_funcionalidade_funcionalidade1`
    FOREIGN KEY (`cod_funcionalidade`)
    REFERENCES `intranet_iasep`.`seg_funcionalidade` (`cod_funcionalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_tipo_vinculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_tipo_vinculo` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NOT NULL,
  `situacao` TINYINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_tipo_vinculo` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_historico_tipo_vinculo_tipo_vinculo1_idx` (`cod_tipo_vinculo` ASC) VISIBLE,
  CONSTRAINT `fk_historico_tipo_vinculo_tipo_vinculo1`
    FOREIGN KEY (`cod_tipo_vinculo`)
    REFERENCES `intranet_iasep`.`rh_tipo_vinculo` (`cod_tipo_vinculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_cargo_funcao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_cargo_funcao` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(155) NOT NULL,
  `cod_cargo_sigirh` INT NOT NULL,
  `cod_escolaridade` BIGINT NOT NULL,
  `funcao` TINYINT NOT NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_cargo_funcao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_cargo_funcao_rh_cargo_funcao1_idx` (`cod_cargo_funcao` ASC) VISIBLE,
  CONSTRAINT `fk_hist_cargo_funcao_rh_cargo_funcao1`
    FOREIGN KEY (`cod_cargo_funcao`)
    REFERENCES `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`cad_srv_funcao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`cad_srv_funcao` (
  `cod_servidor_funcao` BIGINT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE NULL,
  `data_final` DATE NULL,
  `funcao_atual` TINYINT NOT NULL DEFAULT 1,
  `cod_servidor` BIGINT NOT NULL,
  `cod_lotacao` BIGINT NOT NULL,
  `cod_cargo_funcao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_servidor_funcao`),
  INDEX `fk_cargo_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  INDEX `fk_cad_servidor_funcao_cad_servidor_lotacao1_idx` (`cod_lotacao` ASC) VISIBLE,
  INDEX `fk_cad_srv_funcao_rh_cargo_funcao1_idx` (`cod_cargo_funcao` ASC) VISIBLE,
  CONSTRAINT `fk_cargo_servidor10`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cad_servidor_funcao_cad_servidor_lotacao1`
    FOREIGN KEY (`cod_lotacao`)
    REFERENCES `intranet_iasep`.`cad_srv_lotacao` (`cod_srv_lotacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cad_srv_funcao_rh_cargo_funcao1`
    FOREIGN KEY (`cod_cargo_funcao`)
    REFERENCES `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_lotacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_lotacao` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(155) NOT NULL,
  `sigla` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(155) NULL,
  `lotacao_sigirh` INT NOT NULL,
  `situacao` TINYINT NOT NULL DEFAULT 1,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_lotacao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_lotacao_rh_lotacao1_idx` (`cod_lotacao` ASC) VISIBLE,
  CONSTRAINT `fk_hist_lotacao_rh_lotacao1`
    FOREIGN KEY (`cod_lotacao`)
    REFERENCES `intranet_iasep`.`rh_lotacao` (`cod_lotacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`cad_srv_complemento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`cad_srv_complemento` (
  `cod_complemento` BIGINT NOT NULL AUTO_INCREMENT,
  `nacionalidade` VARCHAR(100) NULL,
  `uf_nascimento` VARCHAR(10) NULL,
  `cidade_nascimento` VARCHAR(100) NULL,
  `nome_mae` VARCHAR(255) NULL,
  `nome_pai` VARCHAR(255) NULL,
  `estado_civil` VARCHAR(20) NULL,
  `titulo_eleitor` VARCHAR(12) NULL,
  `rg` VARCHAR(10) NULL,
  `tipo_rg` VARCHAR(20) NULL,
  `exp_rg` DATE NULL,
  `estado_rg` VARCHAR(20) NULL,
  `orgao_rg` VARCHAR(20) NULL,
  `num_cnh` INT NULL,
  `cat_cnh` VARCHAR(10) NULL,
  `validade_cnh` DATE NULL,
  `uf_cnh` VARCHAR(10) NULL,
  `grupo_sanguineo` VARCHAR(3) NULL,
  `cod_servidor` BIGINT NOT NULL,
  PRIMARY KEY (`cod_complemento`),
  INDEX `fk_cad_srv_complemento_rh_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  CONSTRAINT `fk_cad_srv_complemento_rh_servidor1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_srv_complemento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_srv_complemento` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nacionalidade` VARCHAR(100) NULL,
  `uf_nascimento` VARCHAR(10) NULL,
  `cidade_nascimento` VARCHAR(100) NULL,
  `nome_mae` VARCHAR(255) NULL,
  `nome_pai` VARCHAR(255) NULL,
  `estado_civil` VARCHAR(20) NULL,
  `tipo_rg` VARCHAR(20) NULL,
  `exp_rg` DATE NULL,
  `estado_rg` VARCHAR(20) NULL,
  `orgao_rg` VARCHAR(20) NULL,
  `num_cnh` INT NULL,
  `cat_cnh` VARCHAR(10) NULL,
  `validade_cnh` DATE NULL,
  `uf_cnh` VARCHAR(10) NULL,
  `grupo_sanguineo` VARCHAR(3) NULL,
  `data_exercicio` DATE NULL,
  `data_vacancia` DATE NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_complemento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_srv_complemento_cad_srv_complemento1_idx` (`cod_complemento` ASC) VISIBLE,
  CONSTRAINT `fk_hist_srv_complemento_cad_srv_complemento1`
    FOREIGN KEY (`cod_complemento`)
    REFERENCES `intranet_iasep`.`cad_srv_complemento` (`cod_complemento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_upload_afastamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_upload_afastamento` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NULL,
  `cod_afastamento` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_upload_documento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_upload_afastamento_upload_afastamento1_idx` (`cod_upload_documento` ASC) VISIBLE,
  CONSTRAINT `fk_hist_upload_afastamento_upload_afastamento1`
    FOREIGN KEY (`cod_upload_documento`)
    REFERENCES `intranet_iasep`.`upload_afastamento` (`cod_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_upload_comissao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_upload_comissao` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NULL,
  `cod_comissao` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_upload_documento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_upload_comissao_upload_comissao1_idx` (`cod_upload_documento` ASC) VISIBLE,
  CONSTRAINT `fk_hist_upload_comissao_upload_comissao1`
    FOREIGN KEY (`cod_upload_documento`)
    REFERENCES `intranet_iasep`.`upload_comissao` (`cod_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_upload_documento_funcional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_upload_documento_funcional` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NULL,
  `cod_documento` BIGINT NOT NULL,
  `cod_cargo` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_upload_documento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_upload_documento_funcional_upload_documento_funcion_idx` (`cod_upload_documento` ASC) VISIBLE,
  CONSTRAINT `fk_hist_upload_documento_funcional_upload_documento_funcional1`
    FOREIGN KEY (`cod_upload_documento`)
    REFERENCES `intranet_iasep`.`upload_documento_funcional` (`cod_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_upload_documento_pessoal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_upload_documento_pessoal` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NULL,
  `cod_servidor` BIGINT NOT NULL,
  `cod_tipo` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_upload_documento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_upload_licenca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_upload_licenca` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NULL,
  `cod_licenca` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_upload_documento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_upload_licenca_upload_licenca1_idx` (`cod_upload_documento` ASC) VISIBLE,
  CONSTRAINT `fk_hist_upload_licenca_upload_licenca1`
    FOREIGN KEY (`cod_upload_documento`)
    REFERENCES `intranet_iasep`.`upload_licenca` (`cod_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_upload_declaracao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_upload_declaracao` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NULL,
  `cod_declaracao` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_upload_documento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_upload_declaracao_upload_declaracao1_idx` (`cod_upload_documento` ASC) VISIBLE,
  CONSTRAINT `fk_hist_upload_declaracao_upload_declaracao1`
    FOREIGN KEY (`cod_upload_documento`)
    REFERENCES `intranet_iasep`.`upload_declaracao` (`cod_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_upload_folha_frequencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_upload_folha_frequencia` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NULL,
  `cod_frequencia` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_upload_documento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_upload_folha_frequencia_upload_folha_frequencia1_idx` (`cod_upload_documento` ASC) VISIBLE,
  CONSTRAINT `fk_hist_upload_folha_frequencia_upload_folha_frequencia1`
    FOREIGN KEY (`cod_upload_documento`)
    REFERENCES `intranet_iasep`.`upload_folha_frequencia` (`cod_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_upload_formacao_academica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_upload_formacao_academica` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NULL,
  `cod_formacao` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_upload_documento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_upload_formacao_academica_upload_formacao_academica_idx` (`cod_upload_documento` ASC) VISIBLE,
  CONSTRAINT `fk_hist_upload_formacao_academica_upload_formacao_academica1`
    FOREIGN KEY (`cod_upload_documento`)
    REFERENCES `intranet_iasep`.`upload_formacao_academica` (`cod_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_upload_formacao_complementar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_upload_formacao_complementar` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NULL,
  `cod_formacao` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_upload_documento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_upload_formacao_complementar_upload_formacao_comple_idx` (`cod_upload_documento` ASC) VISIBLE,
  CONSTRAINT `fk_hist_upload_formacao_complementar_upload_formacao_compleme1`
    FOREIGN KEY (`cod_upload_documento`)
    REFERENCES `intranet_iasep`.`upload_formacao_complementar` (`cod_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_upload_lotacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_upload_lotacao` (
  `cod_documento` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_original` VARCHAR(255) NULL,
  `nome_arquivo` VARCHAR(255) NULL,
  `caminho_arquivo` VARCHAR(255) NULL,
  `tipo_arquivo` VARCHAR(45) NULL,
  `tamanho_arquivo` BIGINT NULL,
  `data_envio` TIMESTAMP NULL,
  `excluido` TINYINT NULL,
  `cod_lotacao` BIGINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_upload_documento` BIGINT NOT NULL,
  PRIMARY KEY (`cod_documento`),
  INDEX `fk_hist_upload_lotacao_upload_lotacao1_idx` (`cod_upload_documento` ASC) VISIBLE,
  CONSTRAINT `fk_hist_upload_lotacao_upload_lotacao1`
    FOREIGN KEY (`cod_upload_documento`)
    REFERENCES `intranet_iasep`.`upload_lotacao` (`cod_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`ff_tipo_abrangencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`ff_tipo_abrangencia` (
  `cod_tipo` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  `ativo` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`ff_tipo_calendario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`ff_tipo_calendario` (
  `cod_tipo` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(155) NOT NULL,
  `ativo` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`ff_calendario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`ff_calendario` (
  `cod_calendario` BIGINT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `descricao` VARCHAR(255) NOT NULL,
  `ativo` TINYINT NOT NULL DEFAULT 1,
  `recorrente` TINYINT NOT NULL,
  `tipo_abrangencia` BIGINT NOT NULL,
  `tipo_calendario` BIGINT NOT NULL,
  PRIMARY KEY (`cod_calendario`),
  INDEX `fk_ff_calendario_tipo_abrangencia1_idx` (`tipo_abrangencia` ASC) VISIBLE,
  INDEX `fk_ff_calendario_tipo_calendario1_idx` (`tipo_calendario` ASC) VISIBLE,
  CONSTRAINT `fk_ff_calendario_tipo_abrangencia1`
    FOREIGN KEY (`tipo_abrangencia`)
    REFERENCES `intranet_iasep`.`ff_tipo_abrangencia` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ff_calendario_tipo_calendario1`
    FOREIGN KEY (`tipo_calendario`)
    REFERENCES `intranet_iasep`.`ff_tipo_calendario` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_folha_frequencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_folha_frequencia` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `mes` VARCHAR(10) NOT NULL,
  `ano` VARCHAR(4) NOT NULL,
  `descricao` VARCHAR(255) NULL,
  `situacao` TINYINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NULL,
  `data_alteracao` TIMESTAMP NULL,
  `cod_folha` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_folha_frequencia_rh_folha_frequencia1_idx` (`cod_folha` ASC) VISIBLE,
  CONSTRAINT `fk_hist_folha_frequencia_rh_folha_frequencia1`
    FOREIGN KEY (`cod_folha`)
    REFERENCES `intranet_iasep`.`ff_folha_frequencia` (`cod_folha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_emissao_folha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_emissao_folha` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `data_emissao` TIMESTAMP NULL,
  `cod_usuario_emissao` BIGINT NULL,
  `cod_folha` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_emissao_folha_rh_folha_frequencia1_idx` (`cod_folha` ASC) VISIBLE,
  CONSTRAINT `fk_hist_emissao_folha_rh_folha_frequencia1`
    FOREIGN KEY (`cod_folha`)
    REFERENCES `intranet_iasep`.`ff_folha_frequencia` (`cod_folha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hist_ff_ponto_facultativo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hist_ff_ponto_facultativo` (
  `cod_historico` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(155) NOT NULL,
  `data_facultativa` DATE NOT NULL,
  `situacao` TINYINT NOT NULL,
  `cod_usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_ff_ponto` BIGINT NOT NULL,
  PRIMARY KEY (`cod_historico`),
  INDEX `fk_hist_ff_ponto_facultativo_ff_ponto_facultativo1_idx` (`cod_ff_ponto` ASC) VISIBLE,
  CONSTRAINT `fk_hist_ff_ponto_facultativo_ff_ponto_facultativo1`
    FOREIGN KEY (`cod_ff_ponto`)
    REFERENCES `intranet_iasep`.`ff_calendario` (`cod_calendario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`seg_valor_parametro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`seg_valor_parametro` (
  `cod_valor` BIGINT NOT NULL,
  `nome_valor` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(150) NOT NULL,
  `situacao` TINYINT NOT NULL,
  `cod_parametro` BIGINT NOT NULL,
  PRIMARY KEY (`cod_valor`),
  INDEX `fk_seg_valor_parametro_seg_configuracao_parametro1_idx` (`cod_parametro` ASC) VISIBLE,
  CONSTRAINT `fk_seg_valor_parametro_seg_configuracao_parametro1`
    FOREIGN KEY (`cod_parametro`)
    REFERENCES `intranet_iasep`.`seg_configuracao_parametro` (`cod_parametro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`seg_configuracao_parametro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`seg_configuracao_parametro` (
  `cod_parametro` BIGINT NOT NULL,
  `nome_parametro` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(150) NOT NULL,
  `situacao` TINYINT NOT NULL,
  `ultima_atualizacao` TIMESTAMP NULL,
  `usuario_atualizacao` BIGINT NULL,
  `valor_selecionado` BIGINT NULL,
  `valor_padrao` BIGINT NOT NULL,
  `cod_parametro_pai` BIGINT NULL,
  PRIMARY KEY (`cod_parametro`),
  INDEX `fk_seg_configuracao_parametro_seg_valor_parametro1_idx` (`valor_selecionado` ASC) VISIBLE,
  INDEX `fk_seg_configuracao_parametro_seg_valor_parametro2_idx` (`valor_padrao` ASC) VISIBLE,
  INDEX `fk_seg_configuracao_parametro_seg_configuracao_parametro1_idx` (`cod_parametro_pai` ASC) VISIBLE,
  CONSTRAINT `fk_seg_configuracao_parametro_seg_valor_parametro1`
    FOREIGN KEY (`valor_selecionado`)
    REFERENCES `intranet_iasep`.`seg_valor_parametro` (`cod_valor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seg_configuracao_parametro_seg_valor_parametro2`
    FOREIGN KEY (`valor_padrao`)
    REFERENCES `intranet_iasep`.`seg_valor_parametro` (`cod_valor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seg_configuracao_parametro_seg_configuracao_parametro1`
    FOREIGN KEY (`cod_parametro_pai`)
    REFERENCES `intranet_iasep`.`seg_configuracao_parametro` (`cod_parametro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hst_seg_configuracao_parametro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hst_seg_configuracao_parametro` (
  `cod_hst` BIGINT NOT NULL,
  `nome_parametro` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(150) NOT NULL,
  `ativo` TINYINT NOT NULL,
  `ultima_atualizacao` TIMESTAMP NULL,
  `valor_alterado` BIGINT NULL,
  `valor_padrao` BIGINT NULL,
  `usuario_alteracao` BIGINT NOT NULL,
  `data_alteracao` TIMESTAMP NOT NULL,
  `cod_parametro` BIGINT NOT NULL,
  PRIMARY KEY (`cod_hst`),
  INDEX `fk_hst_seg_configuracao_parametro_seg_configuracao_parametr_idx` (`cod_parametro` ASC) VISIBLE,
  CONSTRAINT `fk_hst_seg_configuracao_parametro_seg_configuracao_parametro1`
    FOREIGN KEY (`cod_parametro`)
    REFERENCES `intranet_iasep`.`seg_configuracao_parametro` (`cod_parametro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`hst_seg_valor_parametro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`hst_seg_valor_parametro` (
  `cod_hst` BIGINT NOT NULL,
  `nome_valor` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(150) NOT NULL,
  `situacao` TINYINT NOT NULL,
  `cod_valor` BIGINT NOT NULL,
  PRIMARY KEY (`cod_hst`),
  INDEX `fk_seg_valor_parametro_copy1_seg_valor_parametro1_idx` (`cod_valor` ASC) VISIBLE,
  CONSTRAINT `fk_seg_valor_parametro_copy1_seg_valor_parametro1`
    FOREIGN KEY (`cod_valor`)
    REFERENCES `intranet_iasep`.`seg_valor_parametro` (`cod_valor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`ff_tipo_diaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`ff_tipo_diaria` (
  `cod_tipo` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(155) NOT NULL,
  `ativo` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`ff_situacao_diaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`ff_situacao_diaria` (
  `cod_tipo` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(155) NOT NULL,
  `ativo` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`ff_folha_frequencia_diaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`ff_folha_frequencia_diaria` (
  `cod_folha_diaria` BIGINT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `dia_semana` VARCHAR(45) NOT NULL,
  `observacao` VARCHAR(255) NULL,
  `quantidade_minutos_previstos` INT NULL,
  `quantidade_minutos_trabalhados` INT NULL,
  `horas_abono` INT NULL,
  `horas_compensadas` INT NULL,
  `cod_jornada` BIGINT NOT NULL,
  `cod_servidor_folha` BIGINT NOT NULL,
  `tipo_diaria` BIGINT NOT NULL,
  `situacao_diaria` BIGINT NOT NULL,
  PRIMARY KEY (`cod_folha_diaria`),
  INDEX `fk_ff_folha_frequencia_diaria_ff_servidor_folha_frequencia1_idx` (`cod_servidor_folha` ASC) VISIBLE,
  INDEX `fk_ff_folha_frequencia_diaria_ff_tipo_dia1_idx` (`tipo_diaria` ASC) VISIBLE,
  INDEX `fk_ff_folha_frequencia_diaria_ff_situacao_dia1_idx` (`situacao_diaria` ASC) VISIBLE,
  CONSTRAINT `fk_ff_folha_frequencia_diaria_ff_servidor_folha_frequencia1`
    FOREIGN KEY (`cod_servidor_folha`)
    REFERENCES `intranet_iasep`.`ff_servidor_folha_frequencia` (`cod_servidor_folha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ff_folha_frequencia_diaria_ff_tipo_dia1`
    FOREIGN KEY (`tipo_diaria`)
    REFERENCES `intranet_iasep`.`ff_tipo_diaria` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ff_folha_frequencia_diaria_ff_situacao_dia1`
    FOREIGN KEY (`situacao_diaria`)
    REFERENCES `intranet_iasep`.`ff_situacao_diaria` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`ff_tipo_registro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`ff_tipo_registro` (
  `cod_tipo` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(155) NOT NULL,
  `ativo` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`ff_origem_registro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`ff_origem_registro` (
  `cod_tipo` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(155) NOT NULL,
  `ativo` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`ff_registro_frequencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`ff_registro_frequencia` (
  `cod_registro` BIGINT NOT NULL AUTO_INCREMENT,
  `data_hora` TIMESTAMP NOT NULL,
  `dispositivo` VARCHAR(155) NULL,
  `ip_maquina` VARCHAR(155) NULL,
  `observacao` VARCHAR(255) NULL,
  `periodo` INT NOT NULL,
  `cod_folha_dia` BIGINT NOT NULL,
  `tipo_registro` BIGINT NOT NULL,
  `origem_registro` BIGINT NOT NULL,
  PRIMARY KEY (`cod_registro`),
  INDEX `fk_ff_marcao_ponto_ff_folha_frequencia_diaria1_idx` (`cod_folha_dia` ASC) VISIBLE,
  INDEX `fk_ff_marcao_ponto_ff_tipo_marcacao1_idx` (`tipo_registro` ASC) VISIBLE,
  INDEX `fk_ff_marcao_ponto_ff_origem_marcacao1_idx` (`origem_registro` ASC) VISIBLE,
  CONSTRAINT `fk_ff_marcao_ponto_ff_folha_frequencia_diaria1`
    FOREIGN KEY (`cod_folha_dia`)
    REFERENCES `intranet_iasep`.`ff_folha_frequencia_diaria` (`cod_folha_diaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ff_marcao_ponto_ff_tipo_marcacao1`
    FOREIGN KEY (`tipo_registro`)
    REFERENCES `intranet_iasep`.`ff_tipo_registro` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ff_marcao_ponto_ff_origem_marcacao1`
    FOREIGN KEY (`origem_registro`)
    REFERENCES `intranet_iasep`.`ff_origem_registro` (`cod_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_jornada_trabalho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_jornada_trabalho` (
  `cod_jornada` BIGINT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  `minutos_semanais` INT NOT NULL,
  `minutos_diarios_padrao` INT NOT NULL,
  `minutos_intervalo` INT NOT NULL,
  `ativo` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`cod_jornada`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`cad_srv_jornada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`cad_srv_jornada` (
  `cod_servidor_jornada` BIGINT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE NOT NULL,
  `data_final` DATE NULL,
  `cod_servidor` BIGINT NOT NULL,
  `cod_jornada` BIGINT NOT NULL,
  PRIMARY KEY (`cod_servidor_jornada`),
  INDEX `fk_rh_servidor_jornada_rh_servidor1_idx` (`cod_servidor` ASC) VISIBLE,
  INDEX `fk_rh_servidor_jornada_rh_jornada_trabalho1_idx` (`cod_jornada` ASC) VISIBLE,
  CONSTRAINT `fk_rh_servidor_jornada_rh_servidor1`
    FOREIGN KEY (`cod_servidor`)
    REFERENCES `intranet_iasep`.`rh_servidor` (`cod_servidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rh_servidor_jornada_rh_jornada_trabalho1`
    FOREIGN KEY (`cod_jornada`)
    REFERENCES `intranet_iasep`.`rh_jornada_trabalho` (`cod_jornada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_jornada_periodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_jornada_periodo` (
  `cod_periodo` BIGINT NOT NULL AUTO_INCREMENT,
  `ordem` VARCHAR(2) NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_final` TIME NOT NULL,
  `ativo` TINYINT NOT NULL DEFAULT 1,
  `cod_jornada` BIGINT NOT NULL,
  PRIMARY KEY (`cod_periodo`),
  INDEX `fk_rh_jornada_periodo_rh_jornada_trabalho1_idx` (`cod_jornada` ASC) VISIBLE,
  CONSTRAINT `fk_rh_jornada_periodo_rh_jornada_trabalho1`
    FOREIGN KEY (`cod_jornada`)
    REFERENCES `intranet_iasep`.`rh_jornada_trabalho` (`cod_jornada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`rh_diretoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`rh_diretoria` (
  `cod_diretoria` BIGINT NOT NULL AUTO_INCREMENT,
  `cod_servidor` BIGINT NOT NULL,
  `cod_cargo` BIGINT NOT NULL,
  `descricao_cargo` VARCHAR(100) NULL,
  PRIMARY KEY (`cod_diretoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`importacao_servidor_excel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`importacao_servidor_excel` (
  `cod_importacao` BIGINT NOT NULL AUTO_INCREMENT,
  `data_importacao` TIMESTAMP NOT NULL,
  `cod_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`cod_importacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`dados_importacao_servidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`dados_importacao_servidor` (
  `cod_dados_importacao` BIGINT NOT NULL AUTO_INCREMENT,
  `orgao` VARCHAR(150) NULL,
  `sigla` VARCHAR(150) NULL,
  `numfunc` VARCHAR(150) NULL,
  `numvinc` VARCHAR(150) NULL,
  `nome` VARCHAR(150) NULL,
  `dtnasc` VARCHAR(150) NULL,
  `cpf` VARCHAR(150) NULL,
  `pispasep` VARCHAR(150) NULL,
  `sexo` VARCHAR(150) NULL,
  `tel_fixo` VARCHAR(150) NULL,
  `tel_celular` VARCHAR(150) NOT NULL,
  `e_mail` VARCHAR(150) NULL,
  `regimejur` VARCHAR(150) NULL,
  `tipovinc` VARCHAR(150) NULL,
  `dtexerc` VARCHAR(150) NULL,
  `dtnom` VARCHAR(150) NULL,
  `orgao_cargo` VARCHAR(150) NULL,
  `siglaorgao_cargo` VARCHAR(150) NULL,
  `dtini_cargo` VARCHAR(150) NULL,
  `tipoevento_cargo` VARCHAR(150) NULL,
  `formaprov_cargo` VARCHAR(150) NULL,
  `cargo` VARCHAR(150) NULL,
  `nome_cargo` VARCHAR(150) NULL,
  `ref_cargo` VARCHAR(150) NULL,
  `jornada_cargo` VARCHAR(150) NULL,
  `tabvenc_cargo` VARCHAR(150) NULL,
  `vlr_cargo` VARCHAR(150) NULL,
  `agr_cargo` VARCHAR(150) NULL,
  `categoria_cargo` VARCHAR(150) NULL,
  `subcategoria_cargo` VARCHAR(150) NULL,
  `redistriuido` VARCHAR(150) NULL,
  `orgao_funcao` VARCHAR(150) NULL,
  `siglaorgao_funcao` VARCHAR(150) NULL,
  `dtini_funcao` VARCHAR(150) NULL,
  `dtfim_funcao` VARCHAR(150) NULL,
  `tipoevento_funcao` VARCHAR(150) NULL,
  `formaprov_funcao` VARCHAR(150) NULL,
  `funcao` VARCHAR(150) NULL,
  `nome_funcao` VARCHAR(150) NULL,
  `ref_funcao` VARCHAR(150) NULL,
  `jornada_funcao` VARCHAR(150) NULL,
  `tabvenc_funcao` VARCHAR(150) NULL,
  `vlr_base_funcao` VARCHAR(150) NULL,
  `vlr_rem_funcao` VARCHAR(150) NULL,
  `agr_funcao` VARCHAR(150) NULL,
  `categoria_funcao` VARCHAR(150) NULL,
  `subcategoria_funcao` VARCHAR(150) NULL,
  `funcao2` VARCHAR(150) NULL,
  `setor` VARCHAR(150) NULL,
  `nome_setor` VARCHAR(150) NULL,
  `cidade_setor` VARCHAR(150) NULL,
  `com_onus` VARCHAR(150) NULL,
  `tipoorg` VARCHAR(150) NULL,
  `orgao_cessao` VARCHAR(150) NULL,
  `tipo_cessao` VARCHAR(150) NULL,
  `tipo_onus` VARCHAR(150) NULL,
  `orgao_interno` VARCHAR(150) NULL,
  `sigla_interno` VARCHAR(150) NULL,
  `dtini_cessao` VARCHAR(150) NULL,
  `codfreq` VARCHAR(150) NULL,
  `nomelicenca` VARCHAR(150) NULL,
  `dtini_lic` VARCHAR(150) NULL,
  `dtfim_lic` VARCHAR(150) NULL,
  `cod_importacao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_dados_importacao`),
  INDEX `fk_dados_importacao_servidor_importacao_servidor_excel1_idx` (`cod_importacao` ASC) VISIBLE,
  CONSTRAINT `fk_dados_importacao_servidor_importacao_servidor_excel1`
    FOREIGN KEY (`cod_importacao`)
    REFERENCES `intranet_iasep`.`importacao_servidor_excel` (`cod_importacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`importacao_lotacao_excel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`importacao_lotacao_excel` (
  `cod_importacao` BIGINT NOT NULL AUTO_INCREMENT,
  `data_importacao` TIMESTAMP NOT NULL,
  `cod_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`cod_importacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`log_importacao_excel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`log_importacao_excel` (
  `cod_log` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_arquivo` VARCHAR(255) NOT NULL,
  `linha` VARCHAR(45) NOT NULL,
  `campo` VARCHAR(45) NOT NULL,
  `valor_informado` VARCHAR(255) NOT NULL,
  `tipo_erro` VARCHAR(100) NOT NULL,
  `mensagem` VARCHAR(255) NOT NULL,
  `data_registro` TIMESTAMP NOT NULL,
  `cod_importacao_srv` BIGINT NULL,
  `cod_importacao_lotacao` BIGINT NULL,
  PRIMARY KEY (`cod_log`),
  INDEX `fk_log_importacao_excel_importacao_servidor_excel1_idx` (`cod_importacao_srv` ASC) VISIBLE,
  INDEX `fk_log_importacao_srv_excel_importacao_lotacao_excel1_idx` (`cod_importacao_lotacao` ASC) VISIBLE,
  CONSTRAINT `fk_log_importacao_excel_importacao_servidor_excel1`
    FOREIGN KEY (`cod_importacao_srv`)
    REFERENCES `intranet_iasep`.`importacao_servidor_excel` (`cod_importacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_importacao_srv_excel_importacao_lotacao_excel1`
    FOREIGN KEY (`cod_importacao_lotacao`)
    REFERENCES `intranet_iasep`.`importacao_lotacao_excel` (`cod_importacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet_iasep`.`dados_importacao_lotacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet_iasep`.`dados_importacao_lotacao` (
  `cod_dados_importacao` BIGINT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(10) NULL,
  `lotacao_sigirh` VARCHAR(100) NULL,
  `sigla` VARCHAR(15) NULL,
  `descricao` VARCHAR(100) NULL,
  `responsavel` VARCHAR(155) NULL,
  `nivel` VARCHAR(2) NULL,
  `cod_importacao` BIGINT NOT NULL,
  PRIMARY KEY (`cod_dados_importacao`),
  INDEX `fk_dados_importacao_lotacao_importacao_lotacao_excel1_idx` (`cod_importacao` ASC) VISIBLE,
  CONSTRAINT `fk_dados_importacao_lotacao_importacao_lotacao_excel1`
    FOREIGN KEY (`cod_importacao`)
    REFERENCES `intranet_iasep`.`importacao_lotacao_excel` (`cod_importacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`seg_perfil`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`seg_perfil` (`cod_perfil`, `nome`, `situacao`, `admin`) VALUES (1, 'ADMINISTRADOR', 1, 1);
INSERT INTO `intranet_iasep`.`seg_perfil` (`cod_perfil`, `nome`, `situacao`, `admin`) VALUES (2, 'FUNCIONARIO', 1, 0);
INSERT INTO `intranet_iasep`.`seg_perfil` (`cod_perfil`, `nome`, `situacao`, `admin`) VALUES (3, 'RECURSOS HUMANOS', 1, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_tipo_vinculo`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_tipo_vinculo` (`cod_tipo_vinculo`, `descricao`, `situacao`) VALUES (1, 'A DISPOSICAO', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_vinculo` (`cod_tipo_vinculo`, `descricao`, `situacao`) VALUES (2, 'COMISSAO', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_vinculo` (`cod_tipo_vinculo`, `descricao`, `situacao`) VALUES (3, 'CONTR PRAZO INDETERM', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_vinculo` (`cod_tipo_vinculo`, `descricao`, `situacao`) VALUES (4, 'CONTRATO TEMPORARIO', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_vinculo` (`cod_tipo_vinculo`, `descricao`, `situacao`) VALUES (5, 'EFETIVO', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_vinculo` (`cod_tipo_vinculo`, `descricao`, `situacao`) VALUES (6, 'ESTAGIARIO CURRICUL', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_vinculo` (`cod_tipo_vinculo`, `descricao`, `situacao`) VALUES (7, 'ESTAVEL CONST FED', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_vinculo` (`cod_tipo_vinculo`, `descricao`, `situacao`) VALUES (8, 'NAO ESTAVEL', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_vinculo` (`cod_tipo_vinculo`, `descricao`, `situacao`) VALUES (9, 'REQUISICAO TECNICA', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_vinculo` (`cod_tipo_vinculo`, `descricao`, `situacao`) VALUES (10, 'CEDIDO EXECUT ESTAD', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_regime_juridico`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_regime_juridico` (`cod_regime_juridico`, `descricao`, `situacao`) VALUES (1, 'CLT', 1);
INSERT INTO `intranet_iasep`.`rh_regime_juridico` (`cod_regime_juridico`, `descricao`, `situacao`) VALUES (2, 'CONVENIO CEDENCIA', 1);
INSERT INTO `intranet_iasep`.`rh_regime_juridico` (`cod_regime_juridico`, `descricao`, `situacao`) VALUES (3, 'ESTAGIO', 1);
INSERT INTO `intranet_iasep`.`rh_regime_juridico` (`cod_regime_juridico`, `descricao`, `situacao`) VALUES (4, 'ESTATUTARIO', 1);
INSERT INTO `intranet_iasep`.`rh_regime_juridico` (`cod_regime_juridico`, `descricao`, `situacao`) VALUES (5, 'LC 07/91', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_srv_tipo`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_srv_tipo` (`cod_tipo`, `nome_tipo`, `descricao`, `situacao`) VALUES (1, 'NORMAL', '', 1);
INSERT INTO `intranet_iasep`.`rh_srv_tipo` (`cod_tipo`, `nome_tipo`, `descricao`, `situacao`) VALUES (2, 'PLANTAO', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_municipio_lotacao`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (1, 'BELEM', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (2, 'ANANINDEUA', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (3, 'ITAITUBA', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (4, 'BREVES', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (5, 'BRAGANCA', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (6, 'ABAETETUBA', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (7, 'BARCARENA', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (8, 'CASTANHAL', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (9, 'CAMETA', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (10, 'CAPANEMA', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (11, 'CAPITAO POCO', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (12, 'PARAGOMINAS', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (13, 'VIGIA', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (14, 'SANTA IZABEL DO PARA', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (15, 'SANTAREM', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (16, 'OBIDOS', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (17, 'ORIXIMINA', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (18, 'MONTE ALEGRE', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (19, 'MARABA', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (20, 'CONCEICAO DO ARAGUAIA', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (21, 'REDENCAO', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (22, 'TUCURUI', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (23, 'SOURE', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (24, 'ALTAMIRA', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_municipio_lotacao` (`cod_municipio`, `nome_municipio`, `descricao`, `situacao`) VALUES (25, 'ALENQUER', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_servidor`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_servidor` (`cod_servidor`, `nome`, `num_matricula`, `num_vinculo`, `cpf`, `data_nascimento`, `telefone`, `email`, `sexo`, `situacao`, `cod_tipo_vinculo`, `cod_regime_juridico`, `cod_srv_tipo`, `cod_municipio_lotacao`) VALUES (1, 'ALDO CONCEIÇÃO SOUZA', '5978466', '2', '03146850222', '2025-06-25', '91982884705', 'aldocnsouza@gmail.com', 'M', 1, 2, 4, 1, 1);
INSERT INTO `intranet_iasep`.`rh_servidor` (`cod_servidor`, `nome`, `num_matricula`, `num_vinculo`, `cpf`, `data_nascimento`, `telefone`, `email`, `sexo`, `situacao`, `cod_tipo_vinculo`, `cod_regime_juridico`, `cod_srv_tipo`, `cod_municipio_lotacao`) VALUES (2, 'BENEDITO RODRIGUES BITENCORT JUNIOR', '57213088', '2', '72397586215', '1984-01-27', '32228255', 'benedito@bitencourt.eng.br', 'M', 1, 5, 4, 1, 1);
INSERT INTO `intranet_iasep`.`rh_servidor` (`cod_servidor`, `nome`, `num_matricula`, `num_vinculo`, `cpf`, `data_nascimento`, `telefone`, `email`, `sexo`, `situacao`, `cod_tipo_vinculo`, `cod_regime_juridico`, `cod_srv_tipo`, `cod_municipio_lotacao`) VALUES (3, 'JOSYNELIA TAVARES RAIOL', '57197304', '2', '51317982215', '1980-04-23', '9132268848', 'josynelia@hotmail.com', 'F', 1, 5, 4, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`seg_usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`seg_usuario` (`cod_usuario`, `login`, `senha`, `situacao`, `cod_perfil`, `cod_servidor`) VALUES (1, '03146850222', '$2a$10$wpszTWotrIAOA2TUej0jsO2M3U/9VKkDe2lA.ZiEaddf8lJAydcne', 1, 1, 1);
INSERT INTO `intranet_iasep`.`seg_usuario` (`cod_usuario`, `login`, `senha`, `situacao`, `cod_perfil`, `cod_servidor`) VALUES (2, '72397586215', '$2a$10$Z2L4a1J6169tP4QhYMIK4uXMvckpPLqj.InB39.7n9BFPozE5AacK', 1, 1, 2);
INSERT INTO `intranet_iasep`.`seg_usuario` (`cod_usuario`, `login`, `senha`, `situacao`, `cod_perfil`, `cod_servidor`) VALUES (3, '51317982215', '$2a$10$p9OB5JOFLzMDJJEcxFWB3.Rdpm2wT.8b2lca77fCS990QfVilpDE2', 1, 2, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_tipo_documento_pessoal`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_tipo_documento_pessoal` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (1, 'Curriculum Vitae', 'Curriculum Vitae: Documento que resume a trajetória profissional, formação acadêmica, experiências e habilidades de uma pessoa.', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_documento_pessoal` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (2, 'CPF (Cadastro de Pessoas Físicas)', 'Número único e obrigatório para a identificação de cidadãos brasileiros em transações financeiras e administrativas.', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_documento_pessoal` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (3, 'Identidade (RG)', 'Documento nacional que comprova a identidade civil de uma pessoa, contendo foto, filiação e impressões digitais.', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_documento_pessoal` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (4, 'Registro de Nascimento ou Casamento', 'Documento que atesta o nascimento (para solteiros) ou o estado civil atual (para casados), emitido em cartório.', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_documento_pessoal` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (5, 'Comprovante de Residência', 'Documento que comprova o endereço atual do indivíduo, como contas de água, luz ou telefone.', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_documento_pessoal` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (6, 'Título de Eleitor', 'Documento que comprova que o cidadão está apto a votar, contendo a zona e a seção eleitoral.', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_documento_pessoal` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (7, 'Certidão de Quitação Eleitoral', 'Certificado que comprova a ausência de débitos ou pendências com a Justiça Eleitoral', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_documento_pessoal` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (8, 'Certificado de Reservista (Homens)', 'Documento que comprova que um cidadão do sexo masculino cumpriu com suas obrigações militares.', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_documento_pessoal` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (9, 'PIS/ PASEP e/ou Carteira Profissional', 'Documentos de identificação trabalhista. O PIS/PASEP é um número de registro social, enquanto a Carteira de Trabalho registra todo o histórico de empregos formais.', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_documento_pessoal` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (10, 'Comprovante de Escolaridade', 'Documento (como diploma ou certificado) que comprova o nível de instrução ou a conclusão de um curso.', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_documento_pessoal` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (11, 'Registro de Nascimentos dos Dependentes', ' Certidão de nascimento dos filhos ou de outros dependentes para fins legais e de benefícios.', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_documento_pessoal` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (12, 'Declaração de Vínculo na Esfera (Federal, Municipal e Outros)', 'Documento que informa se o indivíduo possui ou não outro cargo ou emprego público, em qualquer uma das esferas de governo.', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_lotacao`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_lotacao` (`cod_lotacao`, `nome`, `sigla`, `descricao`, `lotacao_sigirh`, `situacao`, `cod_municipio`, `cod_lotacao_pai`, `cod_servidor_titular`) VALUES (1, 'PRESIDENCIA', 'PRES', NULL, '001130300000000', 1, 1, NULL, NULL);
INSERT INTO `intranet_iasep`.`rh_lotacao` (`cod_lotacao`, `nome`, `sigla`, `descricao`, `lotacao_sigirh`, `situacao`, `cod_municipio`, `cod_lotacao_pai`, `cod_servidor_titular`) VALUES (2, 'NUCLEO DE TECNOLOGIA DA INFORMACAO', 'NUTI', NULL, '001130307000000', 1, 1, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`cad_srv_lotacao`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`cad_srv_lotacao` (`cod_srv_lotacao`, `data_inicio`, `data_final`, `lotacao_atual`, `cod_lotacao`, `cod_servidor`) VALUES (1, '2026-08-12', NULL, 1, 2, 2);
INSERT INTO `intranet_iasep`.`cad_srv_lotacao` (`cod_srv_lotacao`, `data_inicio`, `data_final`, `lotacao_atual`, `cod_lotacao`, `cod_servidor`) VALUES (2, '2026-08-12', NULL, 1, 2, 1);
INSERT INTO `intranet_iasep`.`cad_srv_lotacao` (`cod_srv_lotacao`, `data_inicio`, `data_final`, `lotacao_atual`, `cod_lotacao`, `cod_servidor`) VALUES (3, '2026-08-12', NULL, 1, 1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_escolaridade`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_escolaridade` (`cod_escolaridade`, `nome`, `situacao`) VALUES (1, 'FUNDAMENTAL', 1);
INSERT INTO `intranet_iasep`.`rh_escolaridade` (`cod_escolaridade`, `nome`, `situacao`) VALUES (3, 'MEDIO', 1);
INSERT INTO `intranet_iasep`.`rh_escolaridade` (`cod_escolaridade`, `nome`, `situacao`) VALUES (4, 'SUPERIOR', 1);
INSERT INTO `intranet_iasep`.`rh_escolaridade` (`cod_escolaridade`, `nome`, `situacao`) VALUES (5, 'POS-GRADUACAO', 1);
INSERT INTO `intranet_iasep`.`rh_escolaridade` (`cod_escolaridade`, `nome`, `situacao`) VALUES (6, 'MESTRADO', 1);
INSERT INTO `intranet_iasep`.`rh_escolaridade` (`cod_escolaridade`, `nome`, `situacao`) VALUES (7, 'DOUTORADO', 1);
INSERT INTO `intranet_iasep`.`rh_escolaridade` (`cod_escolaridade`, `nome`, `situacao`) VALUES (8, 'POS-DOUTORADO', 1);
INSERT INTO `intranet_iasep`.`rh_escolaridade` (`cod_escolaridade`, `nome`, `situacao`) VALUES (2, 'FUNDAMENTAL INCOMPLETO', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_tipo_documento_formacao`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_tipo_documento_formacao` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (1, 'Histórico Escolar', 'Frente e Verso', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_documento_formacao` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (2, 'Certificado ou Diploma', 'Frente e Verso', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_tipo_afastamento`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (1, 'Férias', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (2, 'Casamento', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (3, 'Falecimento', 'Falecimento do cônjuge, companheira ou companheiro, pai, mãe, filhos e irmãos', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (4, 'Serviços obrigatórios por lei', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (5, 'Desempenho de cargo ou emprego em outro órgão', 'Desempenho de cargo ou emprego em órgão da administração direta ou indireta de Municípios, Estados, Distrito Federal e União, quando colocado regularmente à disposição', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (6, 'Missão oficial de qualquer natureza', 'Missão oficial de qualquer natureza, ainda que sem vencimento, durante o tempo da autorização ou designação', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (7, 'Estudo em área de interesse do serviço público.', 'Estudo, em área do interesse do serviço público, durante o período da autorização', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (8, 'Processo administrativo, se declarado inocente', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (9, 'Desempenho de mandato eletivo', 'Desempenho de mandato eletivo, exceto para promoção por merecimento', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (10, 'Participação em congressos ou outros eventos', 'Participação em congressos ou outros eventos culturais, esportivos, técnicos, científicos ou sindicais, durante o período autorizado', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (11, 'Faltas abonadas', 'Faltas abonadas, no máximo de 3 (três) ao mês', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (12, 'Doação de sangue', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (13, 'Desempenho de mandato classista', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_tipo_afastamento` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (14, 'Folgas premiais', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`ff_situacao_folha_frequencia`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`ff_situacao_folha_frequencia` (`cod_situacao`, `descricao`, `ativo`) VALUES (1, 'EM_ABERTO', 1);
INSERT INTO `intranet_iasep`.`ff_situacao_folha_frequencia` (`cod_situacao`, `descricao`, `ativo`) VALUES (2, 'PREENCHIDA', 1);
INSERT INTO `intranet_iasep`.`ff_situacao_folha_frequencia` (`cod_situacao`, `descricao`, `ativo`) VALUES (3, 'ASSINADA', 1);
INSERT INTO `intranet_iasep`.`ff_situacao_folha_frequencia` (`cod_situacao`, `descricao`, `ativo`) VALUES (4, 'HOMOLOGADA', 1);
INSERT INTO `intranet_iasep`.`ff_situacao_folha_frequencia` (`cod_situacao`, `descricao`, `ativo`) VALUES (5, 'CANCELADA', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_tipo_declaracao`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_tipo_declaracao` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (1, 'OUTROS', 'Documento que contém uma declaração formal de caráter não especificado ou que não se encaixam em uma categoria específica.', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_tipo_licenca`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_tipo_licenca` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (1, 'Licença-saúde', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_tipo_licenca` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (2, 'Licença maternidade', 'Licença maternidade com a duração de cento e oitenta dias', 1);
INSERT INTO `intranet_iasep`.`rh_tipo_licenca` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (3, 'Licença-paternidade', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_tipo_licenca` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (4, 'Licença para tratamento de saúde', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_tipo_licenca` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (5, 'Licença por motivo de doença em pessoa da família', NULL, 1);
INSERT INTO `intranet_iasep`.`rh_tipo_licenca` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (6, 'Licença-prêmio', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_tipo_documento_funcional`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_tipo_documento_funcional` (`cod_tipo`, `nome`, `descricao`, `situacao`) VALUES (1, 'OUTROS', 'Documento funcional de caráter não especificado ou que não se encaixam em uma categoria específica.', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_cargo_funcao`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (1, '5175', 'SUPERVISOR ADMINISTRATIVO', 1, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (2, '5176', 'GERENTE REGIONAL', 1, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (3, '5174', 'GERENTE', 1, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (4, '6856', 'COORDENADOR DO NUCLEO', 1, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (5, '6858', 'COORDENADOR', 1, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (6, '6854', 'DIRETOR', 1, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (7, '6855', 'OUVIDOR', 1, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (8, '5158', 'PROCURADOR CHEFE', 1, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (9, '6857', 'COORDENADOR REGIONAL', 1, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (10, '5159', 'CHEFE DE GABINETE', 1, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (11, '6859', 'SECRETARIO', 1, 1, 2);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (12, '5165', 'ASSESSOR', 1, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (13, '5164', 'ASSESSOR', 1, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (14, '1598', 'PRESIDENTE', 1, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (15, '5157', 'VICE PRESIDENTE', 1, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (16, '6121', 'ESTAGIARIO NS - 20HS', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (17, '6122', 'ESTAGIARIO NS - 30HS', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (18, '6119', 'ESTAGIARIO NM - 20HS', 0, 1, 2);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (19, '6120', 'ESTAGIARIO NM - 30HS', 0, 1, 2);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (20, '6866', 'ASSISTENTE ADMINISTRATIVO', 0, 1, 2);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (21, '6863', 'MOTORISTA', 0, 1, 2);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (22, '6864', 'AUXILIAR DE SEVICOS GERAIS', 0, 1, 1);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (23, '6839', 'ASSISTENTE DE GESTAO B', 0, 1, 2);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (24, '5180', 'FUNÇÃO GRATIFICADA', 0, 1, 2);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (25, '6851', 'ASSISTENTE DE SAUDE B', 0, 1, 2);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (26, '6842', 'ASSISTENTE DE INFORMATICA B', 0, 1, 2);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (27, '6848', 'ANALISTA EM SAUDE B', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (28, '6841', 'ASSISTENTE DE INFORMATICA A', 0, 1, 2);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (29, '6838', 'ASSISTENTE DE GESTAO A', 0, 1, 2);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (30, '6847', 'ANALISTA EM SAUDE A', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (31, '6832', 'ANALISTA DE ADMINISTRACAO E FINANCAS A', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (32, '6868', 'TECNICO EM SAUDE', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (33, '6836', 'ANALISTA DE INFORMATICA B', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (34, '6861', 'AUXILIAR OPERACIONAL B', 0, 1, 1);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (35, '6869', 'TECNICO DE ADMINISTRACAO E FINANCAS', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (36, '6867', 'ASSISTENTE DE INFORMATICA', 0, 1, 2);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (37, '6870', 'TECNICO', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (38, '3779', 'TECNICO EM SAUDE', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (39, '6833', 'ANALISTA DE ADMINISTRACAO E FINANCAS B', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (40, '6865', 'AGENTE DE SAUDE', 0, 1, 2);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (41, '3744', 'TECNICO EM GESTAO PUBLICA', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (42, '6332', 'ANALISTA DE GESTAO PUBLICA B', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (43, '6338', 'ANALISTA DE INFORMATICA B', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (44, '6323', 'ASSISTENTE DE ADMINISTRACAO - ABAAAC/GBA', 0, 1, 2);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (45, '5090', 'TECNICO DE PLANEJAMENTO', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (46, '2', 'CONSULTOR JURIDICO DO ESTADO', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (47, '3778', 'TECNICO DE ADMINISTRACAO E FINANCAS', 0, 1, 3);
INSERT INTO `intranet_iasep`.`rh_cargo_funcao` (`cod_cargo_funcao`, `cod_cargo_sigirh`, `nome_cargo_funcao`, `funcao`, `situacao`, `cod_escolaridade`) VALUES (48, '0000', 'SEM CARGO OU FUNCAO', 0, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`cad_srv_cargo`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`cad_srv_cargo` (`cod_servidor_cargo`, `data_inicio`, `data_final`, `cargo_atual`, `cod_servidor`, `cod_cargo_funcao`) VALUES (1, '2026-08-12', NULL, 1, 1, 3);
INSERT INTO `intranet_iasep`.`cad_srv_cargo` (`cod_servidor_cargo`, `data_inicio`, `data_final`, `cargo_atual`, `cod_servidor`, `cod_cargo_funcao`) VALUES (2, '2026-08-12', NULL, 1, 2, 33);
INSERT INTO `intranet_iasep`.`cad_srv_cargo` (`cod_servidor_cargo`, `data_inicio`, `data_final`, `cargo_atual`, `cod_servidor`, `cod_cargo_funcao`) VALUES (3, '2026-08-12', NULL, 1, 3, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`cad_srv_funcao`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`cad_srv_funcao` (`cod_servidor_funcao`, `data_inicio`, `data_final`, `funcao_atual`, `cod_servidor`, `cod_lotacao`, `cod_cargo_funcao`) VALUES (1, '2026-08-12', NULL, 1, 1, 2, 3);
INSERT INTO `intranet_iasep`.`cad_srv_funcao` (`cod_servidor_funcao`, `data_inicio`, `data_final`, `funcao_atual`, `cod_servidor`, `cod_lotacao`, `cod_cargo_funcao`) VALUES (2, '2026-08-12', NULL, 1, 2, 2, 4);
INSERT INTO `intranet_iasep`.`cad_srv_funcao` (`cod_servidor_funcao`, `data_inicio`, `data_final`, `funcao_atual`, `cod_servidor`, `cod_lotacao`, `cod_cargo_funcao`) VALUES (3, '2026-08-12', NULL, 1, 3, 1, 14);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`ff_tipo_abrangencia`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`ff_tipo_abrangencia` (`cod_tipo`, `descricao`, `ativo`) VALUES (1, 'MUNICIPAL', 1);
INSERT INTO `intranet_iasep`.`ff_tipo_abrangencia` (`cod_tipo`, `descricao`, `ativo`) VALUES (2, 'ESTADUAL', 1);
INSERT INTO `intranet_iasep`.`ff_tipo_abrangencia` (`cod_tipo`, `descricao`, `ativo`) VALUES (3, 'NACIONAL', 1);
INSERT INTO `intranet_iasep`.`ff_tipo_abrangencia` (`cod_tipo`, `descricao`, `ativo`) VALUES (4, 'INTERNACIONAL', 1);
INSERT INTO `intranet_iasep`.`ff_tipo_abrangencia` (`cod_tipo`, `descricao`, `ativo`) VALUES (5, 'OUTROS', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`ff_tipo_calendario`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`ff_tipo_calendario` (`cod_tipo`, `descricao`, `ativo`) VALUES (1, 'FERIADO', 1);
INSERT INTO `intranet_iasep`.`ff_tipo_calendario` (`cod_tipo`, `descricao`, `ativo`) VALUES (2, 'FACULTATIVO', 1);
INSERT INTO `intranet_iasep`.`ff_tipo_calendario` (`cod_tipo`, `descricao`, `ativo`) VALUES (3, 'RECESSO', 1);
INSERT INTO `intranet_iasep`.`ff_tipo_calendario` (`cod_tipo`, `descricao`, `ativo`) VALUES (4, 'PONTO_ELETRONICO', 1);
INSERT INTO `intranet_iasep`.`ff_tipo_calendario` (`cod_tipo`, `descricao`, `ativo`) VALUES (5, 'OUTROS', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`ff_calendario`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`ff_calendario` (`cod_calendario`, `data`, `descricao`, `ativo`, `recorrente`, `tipo_abrangencia`, `tipo_calendario`) VALUES (1, '2026-06-29', 'JOGO DO BRASIL', 1, 1, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_jornada_trabalho`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_jornada_trabalho` (`cod_jornada`, `descricao`, `minutos_semanais`, `minutos_diarios_padrao`, `minutos_intervalo`, `ativo`) VALUES (1, 'Jornada Semanal 30h', 1800, 360, 15, 1);
INSERT INTO `intranet_iasep`.`rh_jornada_trabalho` (`cod_jornada`, `descricao`, `minutos_semanais`, `minutos_diarios_padrao`, `minutos_intervalo`, `ativo`) VALUES (2, 'Jornada Semanal 40h', 2400, 480, 60, 1);
INSERT INTO `intranet_iasep`.`rh_jornada_trabalho` (`cod_jornada`, `descricao`, `minutos_semanais`, `minutos_diarios_padrao`, `minutos_intervalo`, `ativo`) VALUES (3, 'Jornada Semanal 36h', 2160, 720, 60, 1);
INSERT INTO `intranet_iasep`.`rh_jornada_trabalho` (`cod_jornada`, `descricao`, `minutos_semanais`, `minutos_diarios_padrao`, `minutos_intervalo`, `ativo`) VALUES (4, 'Jornada Semanal 20h', 1200, 240, 0, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`cad_srv_jornada`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`cad_srv_jornada` (`cod_servidor_jornada`, `data_inicio`, `data_final`, `cod_servidor`, `cod_jornada`) VALUES (1, '2026-08-12', NULL, 1, 1);
INSERT INTO `intranet_iasep`.`cad_srv_jornada` (`cod_servidor_jornada`, `data_inicio`, `data_final`, `cod_servidor`, `cod_jornada`) VALUES (2, '2026-08-12', NULL, 2, 1);
INSERT INTO `intranet_iasep`.`cad_srv_jornada` (`cod_servidor_jornada`, `data_inicio`, `data_final`, `cod_servidor`, `cod_jornada`) VALUES (3, '2026-08-12', NULL, 3, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `intranet_iasep`.`rh_jornada_periodo`
-- -----------------------------------------------------
START TRANSACTION;
USE `intranet_iasep`;
INSERT INTO `intranet_iasep`.`rh_jornada_periodo` (`cod_periodo`, `ordem`, `hora_inicio`, `hora_final`, `ativo`, `cod_jornada`) VALUES (1, '1', '08:00:00', '12:00:00', 1, 1);
INSERT INTO `intranet_iasep`.`rh_jornada_periodo` (`cod_periodo`, `ordem`, `hora_inicio`, `hora_final`, `ativo`, `cod_jornada`) VALUES (2, '2', '12:15:00', '14:00:00', 1, 1);
INSERT INTO `intranet_iasep`.`rh_jornada_periodo` (`cod_periodo`, `ordem`, `hora_inicio`, `hora_final`, `ativo`, `cod_jornada`) VALUES (3, '1', '08:00:00', '12:00:00', 1, 2);
INSERT INTO `intranet_iasep`.`rh_jornada_periodo` (`cod_periodo`, `ordem`, `hora_inicio`, `hora_final`, `ativo`, `cod_jornada`) VALUES (4, '2', '13:00:00', '17:00:00', 1, 2);
INSERT INTO `intranet_iasep`.`rh_jornada_periodo` (`cod_periodo`, `ordem`, `hora_inicio`, `hora_final`, `ativo`, `cod_jornada`) VALUES (5, '1', '08:00:00', '12:00:00', 1, 3);
INSERT INTO `intranet_iasep`.`rh_jornada_periodo` (`cod_periodo`, `ordem`, `hora_inicio`, `hora_final`, `ativo`, `cod_jornada`) VALUES (6, '2', '13:00:00', '17:00:00', 1, 3);
INSERT INTO `intranet_iasep`.`rh_jornada_periodo` (`cod_periodo`, `ordem`, `hora_inicio`, `hora_final`, `ativo`, `cod_jornada`) VALUES (7, '3', '18:00:00', '20:00:00', 1, 3);
INSERT INTO `intranet_iasep`.`rh_jornada_periodo` (`cod_periodo`, `ordem`, `hora_inicio`, `hora_final`, `ativo`, `cod_jornada`) VALUES (8, '1', '08:00:00', '12:00:00', 1, 4);

COMMIT;

