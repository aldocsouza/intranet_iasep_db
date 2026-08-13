USE intranet_iasep;

/* INSERIR DADOS NA TABELA DE FUNCIONALIDADES */
INSERT INTO seg_funcionalidade (cod_funcionalidade, nome, descricao, situacao, cod_funcionalidade_pai)
VALUES
(1, 'PAINEL_ADMINISTRADOR', 'Módulo responsável por centralizar as funcionalidades administrativas do sistema.', 1, NULL);

INSERT INTO seg_funcionalidade (cod_funcionalidade, nome, descricao, situacao, cod_funcionalidade_pai)
VALUES
(2, 'USUARIOS', 'Permite consultar, cadastrar, atualizar, ativar e inativar usuários do sistema.', 1, 1);

INSERT INTO seg_funcionalidade (cod_funcionalidade, nome, descricao, situacao, cod_funcionalidade_pai)
VALUES
(3, 'PERFIS_PERMISSOES', 'Permite gerenciar os perfis de acesso e definir as permissões de navegação e operação de cada perfil.', 1, 1);

INSERT INTO seg_funcionalidade (cod_funcionalidade, nome, descricao, situacao, cod_funcionalidade_pai)
VALUES
(4, 'RH', 'Módulo responsável por concentrar as funcionalidades relacionadas à gestão de recursos humanos da instituição.', 1, 4);

INSERT INTO seg_funcionalidade (cod_funcionalidade, nome, descricao, situacao, cod_funcionalidade_pai)
VALUES
(5, 'SERVIDORES', 'Permite consultar, cadastrar, atualizar, ativar e inativar os servidores vinculados à instituição.', 1, 4);

INSERT INTO seg_funcionalidade (cod_funcionalidade, nome, descricao, situacao, cod_funcionalidade_pai)
VALUES
(6, 'LOTACOES', 'Permite gerenciar as lotações e setores da instituição, incluindo cadastro e atualização de suas informações.', 1, 4);

INSERT INTO seg_funcionalidade (cod_funcionalidade, nome, descricao, situacao, cod_funcionalidade_pai)
VALUES
(7, 'VINCULOS', 'Permite gerenciar os vínculos funcionais utilizados no cadastro dos servidores.', 1, 4);

INSERT INTO seg_funcionalidade (cod_funcionalidade, nome, descricao, situacao, cod_funcionalidade_pai)
VALUES
(8, 'REGIMES_JURIDICOS', 'Permite gerenciar os regimes jurídicos aplicáveis aos servidores da instituição.', 1, 4);

INSERT INTO seg_funcionalidade (cod_funcionalidade, nome, descricao, situacao, cod_funcionalidade_pai)
VALUES
(9, 'CARGOS_FUNCOES', 'Permite gerenciar os cargos e funções exercidos pelos servidores, incluindo cadastro e atualização de suas informações.', 1, 4);

INSERT INTO seg_funcionalidade (cod_funcionalidade, nome, descricao, situacao, cod_funcionalidade_pai)
VALUES
(10, 'JORNADAS_TRABALHO', 'Permite gerenciar as jornadas de trabalho disponíveis, incluindo horários, períodos e carga horária.', 1, 4);

INSERT INTO seg_funcionalidade (cod_funcionalidade, nome, descricao, situacao, cod_funcionalidade_pai)
VALUES
(11, 'CALENDARIO_INSTITUCIONAL', 'Permite gerenciar o calendário institucional, incluindo o cadastro e a manutenção de feriados, pontos facultativos e demais eventos oficiais.', 1, 4);

INSERT INTO seg_funcionalidade (cod_funcionalidade, nome, descricao, situacao, cod_funcionalidade_pai)
VALUES
(12, 'FOLHA_PONTO', 'Permite gerar, consultar e emitir as folhas de ponto dos servidores de acordo com as jornadas de trabalho e o calendário institucional.', 1, 4);

INSERT INTO seg_funcionalidade (cod_funcionalidade, nome, descricao, situacao, cod_funcionalidade_pai)
VALUES
(13, 'IMPORTAR_DADOS', 'Permite a importação de dados', 1, 1);

INSERT INTO seg_funcionalidade (cod_funcionalidade, nome, descricao, situacao, cod_funcionalidade_pai)
VALUES
(14, 'TELA_INICIAL_INTRANET', 'Permite acessar a tela inicial do Intranet', 1, NULL);

/* ATUALIZA FUNCIONALIDADE PAI */
UPDATE seg_funcionalidade
SET cod_funcionalidade_pai = 14
WHERE cod_funcionalidade = 1;

UPDATE seg_funcionalidade
SET cod_funcionalidade_pai = 14
WHERE cod_funcionalidade = 4;


/* VINCULA AS FUNCIONALIDADES AOS PERFIS */
/* PERFIL: ADMINISTRADOR */
INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (1, 1, 1, 1, 1);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (1, 2, 1, 1, 1);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (1, 3, 1, 1, 1);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (1, 4, 1, 1, 1);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (1, 5, 1, 1, 1);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (1, 6, 1, 1, 1);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (1, 7, 1, 1, 1);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (1, 8, 1, 1, 1);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (1, 9, 1, 1, 1);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (1, 10, 1, 1, 1);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (1, 11, 1, 1, 1);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (1, 12, 1, 1, 1);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (1, 13, 1, 1, 1);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (1, 14, 1, 1, 1);

/* PERFIL: FUNCIONARIO */
INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (2, 1, 1, 0, 0);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (2, 2, 1, 0, 0);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (2, 3, 1, 0, 0);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (2, 4, 1, 0, 0);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (2, 5, 1, 0, 0);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (2, 6, 1, 0, 0);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (2, 7, 1, 0, 0);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (2, 8, 1, 0, 0);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (2, 9, 1, 0, 0);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (2, 10, 1, 0, 0);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (2, 11, 1, 0, 0);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (2, 12, 1, 0, 0);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (2, 13, 1, 0, 0);

INSERT INTO seg_perfil_funcionalidade
(cod_perfil, cod_funcionalidade, leitura, escrita, excluir)
VALUES (2, 14, 1, 0, 0);