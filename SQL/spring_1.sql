--Nova versão da sprint 1 para atender aos novos requisistos de negocio, 
--Não fiz nenhuma alteração no codigo existente já que o professor não apontou nenhum ponto onde deveriamos mudar. 


DROP TABLE tb_carrinho1;
DROP TABLE tb_historico_venda1;
DROP TABLE tb_produto1;
DROP TABLE tb_modelo1;
DROP TABLE tb_categoria1;
DROP TABLE tb_marca1;
DROP TABLE tb_backlog1;
DROP TABLE tb_usuario1;
DROP TABLE tb_empresa1;

CREATE TABLE tb_carrinho1 (
    id_carrinho                          NUMBER NOT NULL,
    qnt_produtos                         NUMBER NOT NULL,
    sub_total                            NUMBER NOT NULL,
    tb_produto_id_produto                NUMBER NOT NULL,
    tb_historico_venda_id_venda          NUMBER NOT NULL,
    tb_produto_tb_modelo_id_modelo       NUMBER NOT NULL,
    tb_produto_tb_modelo_id_marca        NUMBER NOT NULL,
    tb_produto_tb_categoria_id_categoria NUMBER NOT NULL
);

ALTER TABLE tb_carrinho1
    ADD CONSTRAINT tb_carrinho1_pk PRIMARY KEY (id_carrinho,
                                                tb_produto_id_produto,
                                                tb_produto_tb_modelo_id_modelo,
                                                tb_produto_tb_modelo_id_marca,
                                                tb_produto_tb_categoria_id_categoria,
                                                tb_historico_venda_id_venda);

CREATE TABLE tb_categoria1 (
    id_categoria        NUMBER NOT NULL,
    nm_categoria        VARCHAR2(150) NOT NULL,
    descricao_categoria VARCHAR2(500)
);

ALTER TABLE tb_categoria1 ADD CONSTRAINT tb_categoria1_pk PRIMARY KEY (id_categoria);

CREATE TABLE tb_historico_venda1 (
    id_venda NUMBER NOT NULL,
    vl_venda NUMBER NOT NULL,
    dt_venda DATE NOT NULL
);

ALTER TABLE tb_historico_venda1 ADD CONSTRAINT tb_historico_venda1_pk PRIMARY KEY (id_venda);

CREATE TABLE tb_marca1 (
    id_marca            NUMBER NOT NULL,
    nm_marca            VARCHAR2(150) NOT NULL,
    descricao_marca     VARCHAR2(500)
);

ALTER TABLE tb_marca1 ADD CONSTRAINT tb_marca1_pk PRIMARY KEY (id_marca);

CREATE TABLE tb_modelo1 (
    id_modelo         NUMBER NOT NULL,
    nm_modelo         VARCHAR2(150) NOT NULL,
    descricao_modelo  VARCHAR2(500),
    tb_marca_id_marca NUMBER NOT NULL,
    CONSTRAINT tb_modelo1_pk PRIMARY KEY (id_modelo, tb_marca_id_marca)
);


CREATE TABLE tb_produto1 (
    id_produto                  NUMBER NOT NULL,
    nm_produto                  VARCHAR2(150) NOT NULL,
    preco_custo                 NUMBER(9, 2) NOT NULL,
    descricao_produto           VARCHAR2(500),
    preco_venda                 NUMBER(9, 2) NOT NULL,
    estoque                     CHAR(1) NOT NULL,
    tb_categoria_id_categoria   NUMBER NOT NULL,
    tb_modelo_id_modelo         NUMBER NOT NULL,
    tb_modelo_tb_marca_id_marca NUMBER NOT NULL
);

--As tabelas abaixo foram criadas depois da spint 1 
--elas não se relacionam com as demais 


CREATE TABLE tb_empresa1 (
    id_empresa    NUMBER PRIMARY KEY,
    nm_empresa    VARCHAR2(150) NOT NULL,
    razao_social VARCHAR2(150),
    nome_fantasia VARCHAR2(150)
);

CREATE TABLE tb_usuario1 (
    id_usuario NUMBER PRIMARY KEY,
    nome VARCHAR2(50),
    nm_usuario VARCHAR2(50) NOT NULL,
    senha VARCHAR2(20)
);

CREATE TABLE tb_backlog1 (
    id_backlog NUMBER PRIMARY KEY,
    titulo  VARCHAR2(150) NOT NULL,
    descricao_backlog   VARCHAR2(500)
);

--relacionamentos das tabelas

ALTER TABLE tb_produto1
    ADD CONSTRAINT tb_produto1_pk PRIMARY KEY (id_produto,
                                               tb_modelo_id_modelo,
                                               tb_modelo_tb_marca_id_marca,
                                               tb_categoria_id_categoria);

ALTER TABLE tb_carrinho1
    ADD CONSTRAINT tb_carrinho1_tb_historico_venda1_fk FOREIGN KEY (tb_historico_venda_id_venda)
        REFERENCES tb_historico_venda1 (id_venda);

ALTER TABLE tb_carrinho1
    ADD CONSTRAINT tb_carrinho1_tb_produto1_fk FOREIGN KEY (tb_produto_id_produto,
                                                           tb_produto_tb_modelo_id_modelo,
                                                           tb_produto_tb_modelo_id_marca,
                                                           tb_produto_tb_categoria_id_categoria)
        REFERENCES tb_produto1 (id_produto,
                                tb_modelo_id_modelo,
                                tb_modelo_tb_marca_id_marca,
                                tb_categoria_id_categoria);

ALTER TABLE tb_modelo1
    ADD CONSTRAINT tb_modelo1_tb_marca1_fk FOREIGN KEY (tb_marca_id_marca)
        REFERENCES tb_marca1 (id_marca);

ALTER TABLE tb_produto1
    ADD CONSTRAINT tb_produto1_tb_categoria1_fk FOREIGN KEY (tb_categoria_id_categoria)
        REFERENCES tb_categoria1 (id_categoria);

ALTER TABLE tb_produto1
    ADD CONSTRAINT tb_produto1_tb_modelo1_fk FOREIGN KEY (tb_modelo_id_modelo,
                                                         tb_modelo_tb_marca_id_marca)
        REFERENCES tb_modelo1 (id_modelo,
                               tb_marca_id_marca);

ALTER TABLE tb_usuario1
ADD id_empresa NUMBER NOT NULL;

ALTER TABLE tb_usuario1
ADD CONSTRAINT fk_usuario_empresa FOREIGN KEY (id_empresa)
REFERENCES tb_empresa1 (id_empresa);

ALTER TABLE tb_backlog1
ADD id_usuario NUMBER NOT NULL;

ALTER TABLE tb_backlog1
ADD id_empresa NUMBER NOT NULL;

ALTER TABLE tb_backlog1
ADD CONSTRAINT fk_backlog_usuario FOREIGN KEY (id_usuario)
REFERENCES tb_usuario1 (id_usuario);

ALTER TABLE tb_backlog1
ADD CONSTRAINT fk_backlog_empresa FOREIGN KEY (id_empresa)
REFERENCES tb_empresa1 (id_empresa);



--insercoes 

--insercoes na tabela tb_categoria1
INSERT INTO tb_categoria1 (id_categoria, nm_categoria, descricao_categoria) VALUES (1, 'Eletronicos', 'Produtos eletronicos e dispositivos tecnologicos.');
INSERT INTO tb_categoria1 (id_categoria, nm_categoria, descricao_categoria) VALUES (2, 'Roupas', 'Roupas para homens, mulheres e criancas.');
INSERT INTO tb_categoria1 (id_categoria, nm_categoria, descricao_categoria) VALUES (3, 'Alimentos', 'Alimentos secos, enlatados, frescos, etc.');
INSERT INTO tb_categoria1 (id_categoria, nm_categoria, descricao_categoria) VALUES (4, 'Moveis', 'Moveis para casa, escritorio e decoracao.');
INSERT INTO tb_categoria1 (id_categoria, nm_categoria, descricao_categoria) VALUES (5, 'Esportes', 'Equipamentos e acessorios esportivos para diversas modalidades.');

--insercoes na tabela tb_marca1

INSERT INTO tb_marca1 (id_marca, nm_marca, descricao_marca) VALUES (1, 'Sony', 'Marca lider em produtos eletronicos.');
INSERT INTO tb_marca1 (id_marca, nm_marca, descricao_marca) VALUES (2, 'Nike', 'Marca conhecida por seus produtos esportivos.');
INSERT INTO tb_marca1 (id_marca, nm_marca, descricao_marca) VALUES (3, 'Samsung', 'Fabricante de uma variedade de eletronicos e eletrodomesticos.');
INSERT INTO tb_marca1 (id_marca, nm_marca, descricao_marca) VALUES (4, 'Adidas', 'Marca global de roupas esportivas e acessorios.');
INSERT INTO tb_marca1 (id_marca, nm_marca, descricao_marca) VALUES (5, 'Apple', 'Conhecida por seus produtos de tecnologia, como iPhone, iPad e Mac.');

--insercoes na tabela tb_modelo1

INSERT INTO tb_modelo1 (id_modelo, nm_modelo, descricao_modelo, tb_marca_id_marca) VALUES (1, 'PlayStation 5', 'Console de ultima geracao da Sony.', 1);
INSERT INTO tb_modelo1 (id_modelo, nm_modelo, descricao_modelo, tb_marca_id_marca) VALUES (2, 'Air Max 270', 'Tenis de corrida da Nike com tecnologia Air.', 2);
INSERT INTO tb_modelo1 (id_modelo, nm_modelo, descricao_modelo, tb_marca_id_marca) VALUES (3, 'Galaxy S21 Ultra', 'Smartphone premium da Samsung com camera de alta qualidade.', 3);
INSERT INTO tb_modelo1 (id_modelo, nm_modelo, descricao_modelo, tb_marca_id_marca) VALUES (4, 'UltraBoost', 'Tenis de corrida da Adidas com amortecimento responsivo.', 4);
INSERT INTO tb_modelo1 (id_modelo, nm_modelo, descricao_modelo, tb_marca_id_marca) VALUES (5, 'iPhone 13 Pro', 'ultimo smartphone da Apple com tela ProMotion e camera aprimorada.', 5);

--insercoes na tabela tb_historico_venda1

INSERT INTO tb_historico_venda1 (id_venda, vl_venda, dt_venda) VALUES (1, 1200.00, TO_DATE('2024-04-01', 'YYYY-MM-DD'));
INSERT INTO tb_historico_venda1 (id_venda, vl_venda, dt_venda) VALUES (2, 500.50, TO_DATE('2024-04-03', 'YYYY-MM-DD'));
INSERT INTO tb_historico_venda1 (id_venda, vl_venda, dt_venda) VALUES (3, 3500.00, TO_DATE('2024-04-05', 'YYYY-MM-DD'));
INSERT INTO tb_historico_venda1 (id_venda, vl_venda, dt_venda) VALUES (4, 800.20, TO_DATE('2024-04-08', 'YYYY-MM-DD'));
INSERT INTO tb_historico_venda1 (id_venda, vl_venda, dt_venda) VALUES (5, 150.75, TO_DATE('2024-04-10', 'YYYY-MM-DD'));


--insercoes na tabela tb_produto1

INSERT INTO tb_produto1 (id_produto, nm_produto, preco_custo, descricao_produto, preco_venda, estoque, tb_categoria_id_categoria, tb_modelo_id_modelo, tb_modelo_tb_marca_id_marca) VALUES (1, 'PlayStation 5 Digital Edition', 500.00, 'Console de videogame sem leitor de disco.', 599.99, 'S', 1, 1, 1);
INSERT INTO tb_produto1 (id_produto, nm_produto, preco_custo, descricao_produto, preco_venda, estoque, tb_categoria_id_categoria, tb_modelo_id_modelo, tb_modelo_tb_marca_id_marca) VALUES (2, 'Nike Air Force 1', 80.00, 'Tenis casual da Nike.', 99.99, 'M', 2, 2, 2);
INSERT INTO tb_produto1 (id_produto, nm_produto, preco_custo, descricao_produto, preco_venda, estoque, tb_categoria_id_categoria, tb_modelo_id_modelo, tb_modelo_tb_marca_id_marca) VALUES (3, 'Samsung Galaxy Watch 4', 250.00, 'Relogio inteligente da Samsung.', 299.99, 'G', 1, 3, 3);
INSERT INTO tb_produto1 (id_produto, nm_produto, preco_custo, descricao_produto, preco_venda, estoque, tb_categoria_id_categoria, tb_modelo_id_modelo, tb_modelo_tb_marca_id_marca) VALUES (4, 'Adidas Stan Smith', 60.00, 'Tenis classico da Adidas.', 79.99, 'P', 2, 4, 4);
INSERT INTO tb_produto1 (id_produto, nm_produto, preco_custo, descricao_produto, preco_venda, estoque, tb_categoria_id_categoria, tb_modelo_id_modelo, tb_modelo_tb_marca_id_marca) VALUES (5, 'Apple AirPods Pro', 200.00, 'Fones de ouvido sem fio da Apple.', 249.99, 'M', 1, 5, 5);

--insercoes na tabela tb_carrinho1

INSERT INTO tb_carrinho1 (id_carrinho, qnt_produtos, sub_total, tb_produto_id_produto, tb_historico_venda_id_venda, tb_produto_tb_modelo_id_modelo, tb_produto_tb_modelo_id_marca, tb_produto_tb_categoria_id_categoria) VALUES (1, 2, 199.98, 1, 1, 1, 1, 1);
INSERT INTO tb_carrinho1 (id_carrinho, qnt_produtos, sub_total, tb_produto_id_produto, tb_historico_venda_id_venda, tb_produto_tb_modelo_id_modelo, tb_produto_tb_modelo_id_marca, tb_produto_tb_categoria_id_categoria) VALUES (2, 1, 99.99, 2, 1, 2, 2, 2);
INSERT INTO tb_carrinho1 (id_carrinho, qnt_produtos, sub_total, tb_produto_id_produto, tb_historico_venda_id_venda, tb_produto_tb_modelo_id_modelo, tb_produto_tb_modelo_id_marca, tb_produto_tb_categoria_id_categoria) VALUES (3, 3, 899.97, 3, 2, 3, 3, 1);
INSERT INTO tb_carrinho1 (id_carrinho, qnt_produtos, sub_total, tb_produto_id_produto, tb_historico_venda_id_venda, tb_produto_tb_modelo_id_modelo, tb_produto_tb_modelo_id_marca, tb_produto_tb_categoria_id_categoria) VALUES (4, 1, 79.99, 4, 2, 4, 4, 2);
INSERT INTO tb_carrinho1 (id_carrinho, qnt_produtos, sub_total, tb_produto_id_produto, tb_historico_venda_id_venda, tb_produto_tb_modelo_id_modelo, tb_produto_tb_modelo_id_marca, tb_produto_tb_categoria_id_categoria) VALUES (5, 1, 249.99, 5, 3, 5, 5, 1);

--insercoes na tabela empresa1
INSERT INTO tb_empresa1 (id_empresa, nm_empresa, razao_social, nome_fantasia) VALUES (1, 'Tech Corp', 'Tech Corporation Ltda', 'TechCorp');
INSERT INTO tb_empresa1 (id_empresa, nm_empresa, razao_social, nome_fantasia) VALUES (2, 'Edu Solutions', 'Educação Soluções S.A.', 'EduSolutions');
INSERT INTO tb_empresa1 (id_empresa, nm_empresa, razao_social, nome_fantasia) VALUES (3, 'Health Plus', 'Saúde Mais Ltda', 'HealthPlus');
INSERT INTO tb_empresa1 (id_empresa, nm_empresa, razao_social, nome_fantasia) VALUES (4, 'AG e CO', 'Alimentacoes saudaveis', 'AGCO');
INSERT INTO tb_empresa1 (id_empresa, nm_empresa, razao_social, nome_fantasia) VALUES (5, 'SABER', 'impressoras de qualidade', 'SABER Ltda');


--insercoes na tabela usuario1
INSERT INTO tb_usuario1 (id_usuario, nome, nm_usuario, senha, id_empresa) VALUES (1, 'João Silva', 'joaosilva', 'senha123', 1);
INSERT INTO tb_usuario1 (id_usuario, nome, nm_usuario, senha, id_empresa) VALUES (2, 'Maria Oliveira', 'mariaoliveira', 'senha456', 2);
INSERT INTO tb_usuario1 (id_usuario, nome, nm_usuario, senha, id_empresa) VALUES (3, 'Carlos Souza', 'carlossouza', 'senha789', 3);
INSERT INTO tb_usuario1 (id_usuario, nome, nm_usuario, senha, id_empresa) VALUES (4, 'Jim Butcher', 'jbutcher', 'password1', 4);
INSERT INTO tb_usuario1 (id_usuario, nome, nm_usuario, senha, id_empresa) VALUES (5, 'Brandon Sanderson', 'kaladin', '1173', 5);



--insercoes na tabela backlog1
INSERT INTO tb_backlog1 (id_backlog, titulo, descricao_backlog, id_usuario, id_empresa) VALUES (1, 'Projeto Alpha', 'Desenvolvimento do projeto Alpha', 1, 1);
INSERT INTO tb_backlog1 (id_backlog, titulo, descricao_backlog, id_usuario, id_empresa) VALUES (2, 'Implementação Beta', 'Implementação das funcionalidades Beta', 2, 2);
INSERT INTO tb_backlog1 (id_backlog, titulo, descricao_backlog, id_usuario, id_empresa) VALUES (3, 'Teste Gama', 'Testes do sistema Gama', 3, 3);
INSERT INTO tb_backlog1 (id_backlog, titulo, descricao_backlog, id_usuario, id_empresa) VALUES (4, 'WillSharper', 'testes de implantacao do WS', 4, 4);
INSERT INTO tb_backlog1 (id_backlog, titulo, descricao_backlog, id_usuario, id_empresa) VALUES (5, 'StoneWarden', 'testes de segurancao do SW', 5, 5);


--BLOCOS ANONIMOS

--BLOCO 1
SET SERVEROUTPUT ON;
DECLARE
    v_produto_id tb_produto1.id_produto%TYPE;
    v_produto_nome tb_produto1.nm_produto%TYPE;
    v_categoria_nome tb_categoria1.nm_categoria%TYPE;
    v_preco_venda tb_produto1.preco_venda%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Produtos e suas categorias:');
    FOR prod IN (SELECT p.id_produto, p.nm_produto, c.nm_categoria, p.preco_venda
                    FROM tb_produto1 p
                    JOIN tb_categoria1 c ON p.tb_categoria_id_categoria = c.id_categoria
                    ORDER BY p.id_produto)
    LOOP
        v_produto_id := prod.id_produto;
        v_produto_nome := prod.nm_produto;
        v_categoria_nome := prod.nm_categoria;
        v_preco_venda := prod.preco_venda;
        
        DBMS_OUTPUT.PUT_LINE('Produto ID: ' || v_produto_id || ', Nome: ' || v_produto_nome || ', Categoria: ' || v_categoria_nome || ', Preco de venda: ' || v_preco_venda);
    END LOOP;
END;

--BLOCO 2

DECLARE
    v_marca tb_marca1.nm_marca%TYPE;
    v_categoria tb_categoria1.nm_categoria%TYPE;
    v_total_produtos NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Marcas, categorias e total de produtos:');
    
    FOR marca_cat IN (SELECT m.nm_marca, c.nm_categoria, COUNT(p.id_produto) AS total_produtos
                        FROM tb_marca1 m
                        JOIN tb_modelo1 mo ON m.id_marca = mo.tb_marca_id_marca
                        JOIN tb_produto1 p ON mo.id_modelo = p.tb_modelo_id_modelo
                        JOIN tb_categoria1 c ON p.tb_categoria_id_categoria = c.id_categoria
                        GROUP BY m.nm_marca, c.nm_categoria
                        ORDER BY m.nm_marca, c.nm_categoria)
    LOOP
        v_marca := marca_cat.nm_marca;
        v_categoria := marca_cat.nm_categoria;
        v_total_produtos := marca_cat.total_produtos;
        
        DBMS_OUTPUT.PUT_LINE('Marca: ' || v_marca || ', Categoria: ' || v_categoria || ', Total de produtos: ' || v_total_produtos);
    END LOOP;
END;