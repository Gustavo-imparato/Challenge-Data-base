drop table tb_modelo1;
drop table tb_produto1;

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

-- FUNCOES PARA VALIDACAO DE DADOS
 
CREATE OR REPLACE FUNCTION VALIDACAO_PRODUTO (
    p_id_produto IN tb_produto1.id_produto%TYPE,
    p_nm_produto IN tb_produto1.nm_produto%TYPE,
    p_preco_custo IN tb_produto1.preco_custo%TYPE,
    p_descricao_produto IN tb_produto1.descricao_produto%TYPE,
    p_preco_venda IN tb_produto1.preco_venda%TYPE,
    p_estoque IN tb_produto1.estoque%TYPE,
    p_tb_categoria_id IN tb_produto1.tb_categoria_id_categoria%TYPE,
    p_tb_modelo_id IN tb_produto1.tb_modelo_id_modelo%TYPE,
    p_tb_modelo_marca_id IN tb_produto1.tb_modelo_tb_marca_id_marca%TYPE
) RETURN BOOLEAN
IS
BEGIN
    IF p_id_produto IS NULL OR p_nm_produto IS NULL OR p_preco_custo IS NULL OR p_preco_venda IS NULL 
       OR p_estoque IS NULL OR p_tb_categoria_id IS NULL OR p_tb_modelo_id IS NULL OR p_tb_modelo_marca_id IS NULL THEN
        RETURN FALSE;
    END IF;
    IF LENGTH(p_nm_produto) < 1 OR LENGTH(p_nm_produto) > 150 THEN
        RETURN FALSE;
    END IF;
 
    IF LENGTH(p_descricao_produto) < 1 OR LENGTH(p_descricao_produto) > 500 THEN
        RETURN FALSE;
    END IF;
 
    IF p_preco_custo <= 0 OR p_preco_venda <= 0 THEN
        RETURN FALSE;
    END IF;
 
    IF p_estoque != 'S' AND p_estoque != 'N' THEN
        RETURN FALSE;
    END IF;
    RETURN TRUE;
END;
 
--FUNCAO DE VALIDACAO DE CATEGORIA
 
CREATE OR REPLACE FUNCTION VALIDACAO_CATEGORIA(
    p_id_categoria IN tb_categoria1.id_categoria%TYPE,
    p_nm_categoria IN tb_categoria1.nm_categoria%TYPE,
    p_descricao_categoria IN tb_categoria1.descricao_categoria%TYPE
) RETURN BOOLEAN
IS 
BEGIN
    IF p_id_categoria IS NULL OR p_nm_categoria IS NULL OR p_descricao_categoria IS NULL THEN
        RETURN FALSE;
    END IF;
    IF LENGTH(p_nm_categoria) < 1 OR LENGTH(p_nm_categoria) > 150 THEN
        RETURN FALSE;
    END IF;
    IF LENGTH(p_descricao_categoria) < 1 OR LENGTH(p_descricao_categoria) > 500 THEN
        RETURN FALSE;
    END IF;
    RETURN TRUE;
END;

--PROCEDURES
 
--PROCEDURE UPDATE
 
--UPDATE MARCA
CREATE OR REPLACE PROCEDURE CRIAR_MARCA(
    id_marca in number,
    nm_marca in varchar,
    descricao_marca in varchar
)
AS 
BEGIN
    INSERT INTO tb_marca1(
        id_marca,
        nm_marca,
        descricao_marca
    ) VALUES (
        id_marca,
        nm_marca,
        descricao_marca
    );
    dbms_output.put_line('update realizado com sucesso em marca!');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('erro no update de marca' || SQLERRM);
END;
 
--UPDATE CATEGORIA
CREATE OR REPLACE PROCEDURE CRIAR_CATEGORIA(
    id_categoria in number,
    nm_categoria in varchar,
    descricao_categoria in varchar
)
AS 
BEGIN
    INSERT INTO tb_categoria1(
        id_categoria,
        nm_categoria,
        descricao_categoria
    ) VALUES (
        id_categoria,
        nm_categoria,
        descricao_categoria
    );
    dbms_output.put_line('update realizado com sucesso em categoria!');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('erro no update de categoria' || SQLERRM);
END;
 
--UPDATE MODELO
CREATE OR REPLACE PROCEDURE CRIAR_MODELO(
    id_modelo in number,
    nm_modelo in varchar,
    descricao_modelo in varchar,
    tb_marca_id_marca in number
)
AS 
BEGIN
    INSERT INTO tb_modelo1(
        id_modelo,
        nm_modelo,
        descricao_modelo,
        tb_marca_id_marca
    ) VALUES (
        id_modelo,
        nm_modelo,
        descricao_modelo,
        tb_marca_id_marca
    );
    dbms_output.put_line('update realizado com sucesso em modelo!');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('erro no update de modelo' || SQLERRM);
END;
 
--UPDATE HISTORICO DE VENDAS
CREATE OR REPLACE PROCEDURE CRIAR_HISTORICO_VENDAS(
    id_venda in number,
    vl_venda in number,
    dt_venda in date
)
AS 
BEGIN
    INSERT INTO tb_historico_venda1(
        id_venda,
        vl_venda,
        dt_venda
    ) VALUES (
        id_venda,
        vl_venda,
        dt_venda
    );
    dbms_output.put_line('update realizado com sucesso em historico de venda!');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('erro no update de historico de venda' || SQLERRM);
END;
 
--UPDATE PRODUTO
CREATE OR REPLACE PROCEDURE CRIAR_PRODUTO(
    id_produto in number,
    nm_produto in varchar,
    preco_custo in number,
    descricao_produto in varchar,
    preco_venda in number,
    estoque in char,
    tb_categoria_id_categoria in number,
    tb_modelo_id_modelo in number,
    tb_modelo_tb_marca_id_marca in number
)
AS 
BEGIN
    INSERT INTO tb_produto1(
        id_produto,
        nm_produto,
        preco_custo,
        descricao_produto,
        preco_venda,
        estoque,
        tb_categoria_id_categoria,
        tb_modelo_id_modelo,
        tb_modelo_tb_marca_id_marca
    ) VALUES (
        id_produto,
        nm_produto,
        preco_custo,
        descricao_produto,
        preco_venda,
        estoque,
        tb_categoria_id_categoria,
        tb_modelo_id_modelo,
        tb_modelo_tb_marca_id_marca
    );
    dbms_output.put_line('update realizado com sucesso em produto!');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('erro no update de produo' || SQLERRM);
END;
 
--UPDATE CARRINHO
 
CREATE OR REPLACE PROCEDURE CRIAR_CARRINHO(
    id_carrinho in number,
    qnt_produtos in number,
    sub_total in number,
    tb_produto_id_produto in number,
    tb_historico_venda_id_venda in number,
    tb_produto_tb_modelo_id_modelo in number,
    tb_produto_tb_modelo_id_marca in number,
    tb_produto_tb_categoria_id_categoria in number
)
AS 
BEGIN
    INSERT INTO tb_carrinho1(
        id_carrinho,
        qnt_produtos,
        sub_total,
        tb_produto_id_produto,
        tb_historico_venda_id_venda,
        tb_produto_tb_modelo_id_modelo,
        tb_produto_tb_modelo_id_marca,
        tb_produto_tb_categoria_id_categoria
    ) VALUES (
        id_carrinho,
        qnt_produtos,
        sub_total,
        tb_produto_id_produto,
        tb_historico_venda_id_venda,
        tb_produto_tb_modelo_id_modelo,
        tb_produto_tb_modelo_id_marca,
        tb_produto_tb_categoria_id_categoria
    );
    dbms_output.put_line('update realizado com sucesso em carrinho!');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('erro no update de carrinho' || SQLERRM);
END;


--PROCEDURE DELETE

--DELETE MARCA
CREATE OR REPLACE PROCEDURE deletar_marca (
   id_marca IN NUMBER
)
IS
BEGIN

    IF id_marca IS NULL OR id_marca = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'ID da marca inválido: nulo ou zero!');
    END IF;

    DELETE FROM tb_marca1
    WHERE id_marca = id_marca;

    -- Mensagem de sucesso
    DBMS_OUTPUT.PUT_LINE('marca com ID ' || id_marca || ' deletada com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar marca: ' || SQLERRM);
END deletar_marca;


--DELETE CATEGORIA
CREATE OR REPLACE PROCEDURE deletar_categoria (
   id_categoria IN NUMBER
)
IS
BEGIN

    IF id_categoria IS NULL OR id_categoria = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'ID da categoria inválido: nulo ou zero!');
    END IF;

    DELETE FROM tb_categoria1
    WHERE id_categoria = id_categoria;

    -- Mensagem de sucesso
    DBMS_OUTPUT.PUT_LINE('categoria com ID ' || id_categoria || ' deletada com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar categoria: ' || SQLERRM);
END deletar_categoria;


--DELETE MODELO
CREATE OR REPLACE PROCEDURE deletar_modelo (
   id_modelo IN NUMBER
)
IS
BEGIN

    IF id_modelo IS NULL OR id_modelo = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'ID do modelo inválido: nulo ou zero!');
    END IF;

    DELETE FROM tb_modelo1
    WHERE id_modelo = id_modelo;

    -- Mensagem de sucesso
    DBMS_OUTPUT.PUT_LINE('modelo com ID ' || id_modelo || ' deletado com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar modelo: ' || SQLERRM);
END deletar_modelo;


--DELETE HISTORICO DE VENDAS
CREATE OR REPLACE PROCEDURE deletar_historico_venda (
   id_venda IN NUMBER
)
IS
BEGIN

    IF id_venda IS NULL OR id_venda = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'ID da venda inválido: nulo ou zero!');
    END IF;

    DELETE FROM tb_historico_venda1
    WHERE id_venda = id_venda;

    -- Mensagem de sucesso
    DBMS_OUTPUT.PUT_LINE('venda com ID ' || id_venda || ' deletada com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar venda: ' || SQLERRM);
END deletar_deletar_venda;


--DELETE PRODUTO
CREATE OR REPLACE PROCEDURE deletar_produto (
   id_produto IN NUMBER
)
IS
BEGIN

    IF id_produto IS NULL OR id_produto = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'ID do produto inválido: nulo ou zero!');
    END IF;

    DELETE FROM tb_produto1
    WHERE id_produto = id_produto;

    -- Mensagem de sucesso
    DBMS_OUTPUT.PUT_LINE('produto com ID ' || id_produto || ' deletado com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar produto: ' || SQLERRM);
END deletar_produto;

--DELETE CARRINHO
CREATE OR REPLACE PROCEDURE deletar_carrinho (
   id_carrinho IN NUMBER
)
IS
BEGIN

    IF id_carrinho IS NULL OR id_carrinho = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'ID do carrinho inválido: nulo ou zero!');
    END IF;

    DELETE FROM tb_carrinho1
    WHERE id_carrinho = id_carrinho;

    -- Mensagem de sucesso
    DBMS_OUTPUT.PUT_LINE('carrinho com ID ' || id_carrinho || ' deletado com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar carrinho: ' || SQLERRM);
END deletar_carrinho;





