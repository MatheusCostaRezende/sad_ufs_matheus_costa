CREATE TABLE enquete (
  id_enq SERIAL  NOT NULL ,
  op1_enq INTEGER    ,
  op2_enq INTEGER    ,
  op3_enq INTEGER      ,
PRIMARY KEY(id_enq));




CREATE TABLE tipo_anuncio (
  id_anuncio SERIAL  NOT NULL ,
  desc_anuncio VARCHAR(500)    ,
  tam_anuncio INTEGER    ,
  local_anuncio VARCHAR(50)    ,
  valor_mensal DECIMAL(10,2)    ,
  valor_semestral DECIMAL(10,2)    ,
  valor_anual DECIMAL(10,2)      ,
PRIMARY KEY(id_anuncio));




CREATE TABLE sessao (
  id_sessao SERIAL  NOT NULL ,
  nomesessao VARCHAR(50)    ,
  desc_sessao VARCHAR(500)      ,
PRIMARY KEY(id_sessao));




CREATE TABLE administrador (
  cpf_adm VARCHAR(20)   NOT NULL ,
  nome_adm VARCHAR(100)    ,
  cep_adm INTEGER    ,
  end_adm VARCHAR(100)    ,
  complemento_adm VARCHAR(100)    ,
  numero_adm INTEGER    ,
  bairro_adm VARCHAR(50)    ,
  cidade_adm VARCHAR(50)    ,
  estado_adm VARCHAR(2)    ,
  rg_adm VARCHAR(20)    ,
  data_nasc_adm VARCHAR(12)    ,
  telefone_adm VARCHAR(20)    ,
  celular_adm VARCHAR(20)    ,
  email_adm VARCHAR(100)    ,
  senha_adm VARCHAR(8)    ,
  dt_cad_adm VARCHAR(12)    ,
  dt_acesso VARCHAR(12)      ,
PRIMARY KEY(cpf_adm));




CREATE TABLE anunciante (
  cnpj_anunc VARCHAR(25)   NOT NULL ,
  nome_anunc VARCHAR(100)    ,
  cep_anunc INTEGER    ,
  end_anunc VARCHAR(100)    ,
  comp_anunc VARCHAR(100)    ,
  numero_anunc INTEGER    ,
  bairro_anunc VARCHAR(50)    ,
  cidade_anunc VARCHAR(50)    ,
  estado_anunc VARCHAR(2)    ,
  data_nasc_anunc VARCHAR(12)    ,
  desc_anunc VARCHAR(200)    ,
  telefone_anunc VARCHAR(20)    ,
  celular_anunc VARCHAR(20)    ,
  email_anunc VARCHAR(100)    ,
  senha_anunc VARCHAR(8)    ,
  dt_cad_anunc VARCHAR(12)    ,
  dt_acesso VARCHAR(12)      ,
PRIMARY KEY(cnpj_anunc));




CREATE TABLE usuario (
  cpf_usu VARCHAR(20)   NOT NULL ,
  nome_usu VARCHAR(100)    ,
  cep_usu INTEGER    ,
  end_usu VARCHAR(100)    ,
  complemento_usu VARCHAR(100)    ,
  numero_usu INTEGER    ,
  bairro_usu VARCHAR(50)    ,
  cidade_usu VARCHAR(50)    ,
  estado_usu VARCHAR(2)    ,
  rg_usu VARCHAR(20)    ,
  data_nasc_usu VARCHAR(12)    ,
  telefone_usu VARCHAR(20)    ,
  celular_usu VARCHAR(20)    ,
  email_usu VARCHAR(100)    ,
  senha_usu VARCHAR(8)    ,
  receber VARCHAR(1)    ,
  dt_cad_usu VARCHAR(12)    ,
  dt_acesso VARCHAR(12)      ,
PRIMARY KEY(cpf_usu));




CREATE TABLE pedido_orcamento (
  idpedido_orcamento SERIAL  NOT NULL ,
  usuario_cpf_usu VARCHAR(20)   NOT NULL ,
  idade_aniv INTEGER    ,
  dt_festa DECIMAL(10,2)    ,
  hora_festa VARCHAR(20)    ,
  tema_festa VARCHAR(25)    ,
  num_conv INTEGER    ,
  num_meninas INTEGER    ,
  num_meninos INTEGER      ,
PRIMARY KEY(idpedido_orcamento)  ,
  FOREIGN KEY(usuario_cpf_usu)
    REFERENCES usuario(cpf_usu));


CREATE INDEX pedido_orcamento_FKIndex1 ON pedido_orcamento (usuario_cpf_usu);


CREATE INDEX IFK_solicita ON pedido_orcamento (usuario_cpf_usu);


CREATE TABLE contrato (
  idcontrato SERIAL  NOT NULL ,
  anunciante_cnpj_anunc VARCHAR(25)   NOT NULL ,
  tipo_anuncio_id_anuncio INTEGER   NOT NULL ,
  dt_inicio VARCHAR(12)    ,
  dt_termino VARCHAR(12)    ,
  tipo_plano VARCHAR(1)    ,
  periodo INTEGER      ,
PRIMARY KEY(idcontrato)    ,
  FOREIGN KEY(anunciante_cnpj_anunc)
    REFERENCES anunciante(cnpj_anunc),
  FOREIGN KEY(tipo_anuncio_id_anuncio)
    REFERENCES tipo_anuncio(id_anuncio));


CREATE INDEX contrato_FKIndex1 ON contrato (anunciante_cnpj_anunc);
CREATE INDEX contrato_FKIndex2 ON contrato (tipo_anuncio_id_anuncio);


CREATE INDEX IFK_faz ON contrato (anunciante_cnpj_anunc);
CREATE INDEX IFK_envolve ON contrato (tipo_anuncio_id_anuncio);


CREATE TABLE pertence (
  sessao_id_sessao INTEGER   NOT NULL ,
  anunciante_cnpj_anunc VARCHAR(25)   NOT NULL   ,
PRIMARY KEY(sessao_id_sessao, anunciante_cnpj_anunc)    ,
  FOREIGN KEY(sessao_id_sessao)
    REFERENCES sessao(id_sessao),
  FOREIGN KEY(anunciante_cnpj_anunc)
    REFERENCES anunciante(cnpj_anunc));


CREATE INDEX pertence_FKIndex1 ON pertence (sessao_id_sessao);
CREATE INDEX pertence_FKIndex2 ON pertence (anunciante_cnpj_anunc);


CREATE INDEX IFK_Rel_10 ON pertence (sessao_id_sessao);
CREATE INDEX IFK_Rel_11 ON pertence (anunciante_cnpj_anunc);


CREATE TABLE recebe (
  anunciante_cnpj_anunc VARCHAR(25)   NOT NULL ,
  pedido_orcamento_idpedido_orcamento INTEGER   NOT NULL   ,
PRIMARY KEY(anunciante_cnpj_anunc, pedido_orcamento_idpedido_orcamento)    ,
  FOREIGN KEY(anunciante_cnpj_anunc)
    REFERENCES anunciante(cnpj_anunc),
  FOREIGN KEY(pedido_orcamento_idpedido_orcamento)
    REFERENCES pedido_orcamento(idpedido_orcamento));


CREATE INDEX anunciante_has_pedido_orcamento_FKIndex1 ON recebe (anunciante_cnpj_anunc);
CREATE INDEX anunciante_has_pedido_orcamento_FKIndex2 ON recebe (pedido_orcamento_idpedido_orcamento);


CREATE INDEX IFK_Rel_17 ON recebe (anunciante_cnpj_anunc);
CREATE INDEX IFK_Rel_18 ON recebe (pedido_orcamento_idpedido_orcamento);


CREATE TABLE pagamento (
  idpagamento SERIAL  NOT NULL ,
  contrato_idcontrato INTEGER   NOT NULL ,
  periodo_referente INTEGER    ,
  vencimento VARCHAR(12)    ,
  valor DECIMAL(10,2)    ,
  situacao VARCHAR(50)      ,
PRIMARY KEY(idpagamento)  ,
  FOREIGN KEY(contrato_idcontrato)
    REFERENCES contrato(idcontrato));


CREATE INDEX pagamento_FKIndex1 ON pagamento (contrato_idcontrato);


CREATE INDEX IFK_gera ON pagamento (contrato_idcontrato);



