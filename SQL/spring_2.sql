--PROFESSOR, COMO O PROFESSOR ANTERIOR NAO PEDIU NENHUMA MUDANCA NOS CODIGOS MANTIVE ASSIM
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

--UPDATE EMPRESA
CREATE OR REPLACE PROCEDURE CRIAR_EMPRESA(
    p_id_empresa IN NUMBER,
    p_nm_empresa IN VARCHAR2,
    p_razao_social IN VARCHAR2,
    p_nome_fantasia IN VARCHAR2
)
AS 
BEGIN
    UPDATE tb_empresa1
    SET nm_empresa = p_nm_empresa,
        razao_social = p_razao_social,
        nome_fantasia = p_nome_fantasia
    WHERE id_empresa = p_id_empresa;
    
    dbms_output.put_line('Update realizado com sucesso em empresa!');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Erro no update de empresa: ' || SQLERRM);
END;

--UPDATE USUARIO 
CREATE OR REPLACE PROCEDURE CRIAR_USUARIO(
    p_id_usuario IN NUMBER,
    p_nome IN VARCHAR2,
    p_nm_usuario IN VARCHAR2,
    p_senha IN VARCHAR2,
    p_id_empresa IN NUMBER
)
AS 
BEGIN
    UPDATE tb_usuario1
    SET nome = p_nome,
        nm_usuario = p_nm_usuario,
        senha = p_senha,
        id_empresa = p_id_empresa
    WHERE id_usuario = p_id_usuario;
    
    dbms_output.put_line('Update realizado com sucesso em usuário!');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Erro no update de usuário: ' || SQLERRM);
END;

--UPDATE BACKLOG
CREATE OR REPLACE PROCEDURE CRIAR_BACKLOG(
    p_id_backlog IN NUMBER,
    p_titulo IN VARCHAR2,
    p_descricao_backlog IN VARCHAR2,
    p_id_usuario IN NUMBER,
    p_id_empresa IN NUMBER
)
AS 
BEGIN
    UPDATE tb_backlog1
    SET titulo = p_titulo,
        descricao_backlog = p_descricao_backlog,
        id_usuario = p_id_usuario,
        id_empresa = p_id_empresa
    WHERE id_backlog = p_id_backlog;
    
    dbms_output.put_line('Update realizado com sucesso em backlog!');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Erro no update de backlog: ' || SQLERRM);
END;



--PROCEDURE DELETE

--DELETE MARCA
CREATE OR REPLACE PROCEDURE deletar_marca (
   id_marca IN NUMBER
)
IS
BEGIN

    IF id_marca IS NULL OR id_marca = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'ID da marca invÃ¡lido: nulo ou zero!');
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
        RAISE_APPLICATION_ERROR(-20000, 'ID da categoria invÃ¡lido: nulo ou zero!');
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
        RAISE_APPLICATION_ERROR(-20000, 'ID do modelo invÃ¡lido: nulo ou zero!');
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
        RAISE_APPLICATION_ERROR(-20000, 'ID da venda invÃ¡lido: nulo ou zero!');
    END IF;

    DELETE FROM tb_historico_venda1
    WHERE id_venda = id_venda;

    -- Mensagem de sucesso
    DBMS_OUTPUT.PUT_LINE('venda com ID ' || id_venda || ' deletada com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar venda: ' || SQLERRM);
END deletar_historico_venda;


--DELETE PRODUTO
CREATE OR REPLACE PROCEDURE deletar_produto (
   id_produto IN NUMBER
)
IS
BEGIN

    IF id_produto IS NULL OR id_produto = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'ID do produto invÃ¡lido: nulo ou zero!');
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
        RAISE_APPLICATION_ERROR(-20000, 'ID do carrinho invÃ¡lido: nulo ou zero!');
    END IF;

    DELETE FROM tb_carrinho1
    WHERE id_carrinho = id_carrinho;

    -- Mensagem de sucesso
    DBMS_OUTPUT.PUT_LINE('carrinho com ID ' || id_carrinho || ' deletado com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar carrinho: ' || SQLERRM);
END deletar_carrinho;

--DELETE EMPRESA 
CREATE OR REPLACE PROCEDURE deletar_empresa (
   p_id_empresa IN NUMBER
)
IS
BEGIN
    IF p_id_empresa IS NULL OR p_id_empresa = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'ID da empresa inválido: nulo ou zero!');
    END IF;

    DELETE FROM tb_empresa1
    WHERE id_empresa = p_id_empresa;

    -- Mensagem de sucesso
    DBMS_OUTPUT.PUT_LINE('Empresa com ID ' || p_id_empresa || ' deletada com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar empresa: ' || SQLERRM);
END deletar_empresa;


--DELETAR USUARIO 
CREATE OR REPLACE PROCEDURE deletar_usuario (
   p_id_usuario IN NUMBER
)
IS
BEGIN
    IF p_id_usuario IS NULL OR p_id_usuario = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'ID do usuário inválido: nulo ou zero!');
    END IF;

    DELETE FROM tb_usuario1
    WHERE id_usuario = p_id_usuario;

    -- Mensagem de sucesso
    DBMS_OUTPUT.PUT_LINE('Usuário com ID ' || p_id_usuario || ' deletado com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar usuário: ' || SQLERRM);
END deletar_usuario;


--DELETE BACKLOG
CREATE OR REPLACE PROCEDURE deletar_backlog (
   p_id_backlog IN NUMBER
)
IS
BEGIN
    IF p_id_backlog IS NULL OR p_id_backlog = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'ID do backlog inválido: nulo ou zero!');
    END IF;

    DELETE FROM tb_backlog1
    WHERE id_backlog = p_id_backlog;

    -- Mensagem de sucesso
    DBMS_OUTPUT.PUT_LINE('Backlog com ID ' || p_id_backlog || ' deletado com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar backlog: ' || SQLERRM);
END deletar_backlog;

--PROCEDURES COM CURSOR JOIN

--PRIMEIRO
set serveroutput on;
DECLARE
    v_id_carrinho tb_carrinho1.id_carrinho%TYPE;
    v_qnt_produtos tb_carrinho1.qnt_produtos%TYPE;
    v_sub_total tb_carrinho1.sub_total%TYPE;
    v_id_venda tb_historico_venda1.id_venda%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Carrinho e Historico de Vendas:');
    
    FOR i IN (SELECT c.id_carrinho, c.qnt_produtos, c.sub_total, h.id_venda
                            FROM tb_carrinho1 c
                            JOIN tb_historico_venda1 h ON c.tb_historico_venda_id_venda = h.id_venda)
    LOOP
        v_id_carrinho := i.id_carrinho;
        v_qnt_produtos := i.qnt_produtos;
        v_sub_total := i.sub_total;
        v_id_venda := i.id_venda;
        
        DBMS_OUTPUT.PUT_LINE('ID Carrinho: ' || v_id_carrinho || ', Quantidade de Produtos: ' || v_qnt_produtos || ', Subtotal: ' || v_sub_total || ', ID Venda: ' || v_id_venda);
    END LOOP;
END;


--SEGUNDO
set serveroutput on;
CREATE OR REPLACE PROCEDURE listar_empresa_backlog IS
    v_id_empresa tb_empresa1.id_empresa%TYPE;
    v_nm_empresa tb_empresa1.nm_empresa%TYPE;
    v_razao_social tb_empresa1.razao_social%TYPE;
    v_nome_fantasia tb_empresa1.nome_fantasia%TYPE;
    v_id_backlog tb_backlog1.id_backlog%TYPE;
    v_titulo tb_backlog1.titulo%TYPE;
    v_descricao_backlog tb_backlog1.descricao_backlog%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Empresas e seus Backlogs:');
    
    FOR i IN (
        SELECT e.id_empresa, e.nm_empresa, e.razao_social, e.nome_fantasia,
               b.id_backlog, b.titulo, b.descricao_backlog
        FROM tb_empresa1 e
        JOIN tb_backlog1 b ON e.id_empresa = b.id_empresa
    )
    LOOP
        v_id_empresa := i.id_empresa;
        v_nm_empresa := i.nm_empresa;
        v_razao_social := i.razao_social;
        v_nome_fantasia := i.nome_fantasia;
        v_id_backlog := i.id_backlog;
        v_titulo := i.titulo;
        v_descricao_backlog := i.descricao_backlog;
        
        DBMS_OUTPUT.PUT_LINE('ID Empresa: ' || v_id_empresa || ', Nome Empresa: ' || v_nm_empresa || 
                             ', Razão Social: ' || v_razao_social || ', Nome Fantasia: ' || v_nome_fantasia ||
                             ', ID Backlog: ' || v_id_backlog || ', Título: ' || v_titulo || 
                             ', Descrição: ' || v_descricao_backlog);
    END LOOP;
END listar_empresa_backlog;




--IMPLEMENTACAO DA REGRA DE NEGOCIO
--CRUZANDO A TABELA HISTORICO VENDA E PRODUTO
CREATE OR REPLACE PROCEDURE cruzar_produto_venda AS
BEGIN
    FOR produto_venda IN (
        SELECT 
            p.nm_produto, 
            p.preco_custo, 
            p.preco_venda, 
            h.id_venda, 
            h.vl_venda, 
            h.dt_venda
        FROM 
            tb_produto1 p
        JOIN 
            tb_modelo1 m ON p.tb_modelo_id_modelo = m.id_modelo
        JOIN 
            tb_marca1 ma ON m.tb_marca_id_marca = ma.id_marca
        JOIN 
            tb_carrinho1 c ON p.id_produto = c.tb_produto_id_produto
        JOIN 
            tb_historico_venda1 h ON c.tb_historico_venda_id_venda = h.id_venda
    )
    LOOP
        
        DBMS_OUTPUT.PUT_LINE(
            'Produto: ' || produto_venda.nm_produto || 
            ', PreÃ§o de Custo: ' || produto_venda.preco_custo || 
            ', PreÃ§o de Venda: ' || produto_venda.preco_venda || 
            ', ID Venda: ' || produto_venda.id_venda || 
            ', Valor da Venda: ' || produto_venda.vl_venda || 
            ', Data da Venda: ' || produto_venda.dt_venda
        );
    END LOOP;
END;

DECLARE
    v_total_vendas NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Lista de produtos e seus precos:');
    cruzar_produto_venda;
    DBMS_OUTPUT.PUT_LINE('A consulta de precos foi concluÃ­da com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro ao executar a consulta: ' || SQLERRM);
END;