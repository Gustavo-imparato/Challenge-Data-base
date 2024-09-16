--ENTREGA 3 
--PROFESSOR A CRIACAO DA TABELA PARA AUDITORIA ESTA JUNTO COM O CODIGO DA SPRINT 1 PARA MELHOR ORGANIZAÇÃO DO PROJETO, 
--DE RESTO TANTO A ENTREGA DA SPRINT 1 E A 2 NAO FORAM ALTERADAS, JA QUE O PROFESSOR ANTERIOR NAO PEDIU NENHUMA MUDANCA OU CORRECAO

--PROCEDURES

--procedure 1- faz o join com duas tabelas tb_carrinho1 tb_historico_venda1 e converte os dados para Json usando a funcao ConverteJson
SET SERVEROUTPUT ON;
DECLARE
    v_id_carrinho tb_carrinho1.id_carrinho%TYPE;
    v_qnt_produtos tb_carrinho1.qnt_produtos%TYPE;
    v_sub_total tb_carrinho1.sub_total%TYPE;
    v_id_venda tb_historico_venda1.id_venda%TYPE;
    v_json CLOB;
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
        
        BEGIN
            -- Chama a função convertida para JSON
            v_json := converteJson(v_id_carrinho, v_qnt_produtos, v_sub_total, v_id_venda);
            
            -- Exibe o JSON gerado, com verificação de NULL
            IF v_json IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE(v_json);
            ELSE
                DBMS_OUTPUT.PUT_LINE('Erro ao gerar JSON.');
            END IF;
        EXCEPTION
            WHEN VALUE_ERROR THEN
                -- Trata na conversao de dados
                DBMS_OUTPUT.PUT_LINE('Erro de conversão de valor ao gerar JSON.');
            WHEN PROGRAM_ERROR THEN
                -- Trata de programacao
                DBMS_OUTPUT.PUT_LINE('Erro de programação ao gerar JSON.');
            WHEN OTHERS THEN
                -- Trata qualquer outro erro
                DBMS_OUTPUT.PUT_LINE('Erro inesperado ao gerar JSON: ' || SQLERRM);
        END;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
END;




--PROCEDURE 2

CREATE OR REPLACE PROCEDURE relatorio_historico_venda IS
    CURSOR c_vendas IS
        SELECT vl_venda 
        FROM tb_historico_venda1
        ORDER BY id_venda;
    
    v_anterior tb_historico_venda1.vl_venda%TYPE := NULL;
    v_atual tb_historico_venda1.vl_venda%TYPE;
    v_proximo tb_historico_venda1.vl_venda%TYPE;
    
    contador INTEGER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Relatório de Vendas:');
    
    OPEN c_vendas;
    
    FETCH c_vendas INTO v_atual;
    
    IF c_vendas%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum dado encontrado.');
        CLOSE c_vendas;
        RETURN;
    END IF;
    
    LOOP
        BEGIN
            FETCH c_vendas INTO v_proximo;
            
            DBMS_OUTPUT.PUT_LINE('Anterior: ' || NVL(TO_CHAR(v_anterior), 'Vazio') || 
                                 ', Atual: ' || NVL(TO_CHAR(v_atual), 'Vazio') || 
                                 ', Próximo: ' || NVL(TO_CHAR(v_proximo), 'Vazio'));
            
            v_anterior := v_atual;
            v_atual := v_proximo;
            
            contador := contador + 1;
            
            EXIT WHEN c_vendas%NOTFOUND OR contador >= 5;
            
        EXCEPTION
            WHEN VALUE_ERROR THEN
                -- Trata erros na conversao de dados
                DBMS_OUTPUT.PUT_LINE('Erro de conversão de valor.');
                v_proximo := NULL;
            WHEN PROGRAM_ERROR THEN
                -- Trata erros de programacao
                DBMS_OUTPUT.PUT_LINE('Erro de programação.');
                EXIT;
            WHEN OTHERS THEN
            -- Trata qualquer outro erro
                DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
                EXIT;
        END;
    END LOOP;
    
    CLOSE c_vendas;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
END relatorio_historico_venda;


--BLOCO ANONIMO PARA CHAMAR A PROCEDURE 2
BEGIN
    relatorio_historico_venda;
END;

--FUNCOES
--funcao 1- converte o retorna de procuderes para o formato Json

CREATE OR REPLACE FUNCTION converteJson (
    p_id_carrinho tb_carrinho1.id_carrinho%TYPE,
    p_qnt_produtos tb_carrinho1.qnt_produtos%TYPE,
    p_sub_total tb_carrinho1.sub_total%TYPE,
    p_id_venda tb_historico_venda1.id_venda%TYPE
) RETURN CLOB IS
    v_json CLOB;
BEGIN
    BEGIN
        v_json := '{' ||
                  '"id_carrinho": "' || p_id_carrinho || '", ' ||
                  '"qnt_produtos": ' || TO_CHAR(p_qnt_produtos) || ', ' ||
                  '"sub_total": ' || TO_CHAR(p_sub_total) || ', ' ||
                  '"id_venda": "' || p_id_venda || '"' ||
                  '}';
    EXCEPTION
        WHEN VALUE_ERROR THEN
            -- Trata problemas com a conversao de valores
            DBMS_OUTPUT.PUT_LINE('Erro de conversão de valor.');
            v_json := NULL;
        WHEN PROGRAM_ERROR THEN
            -- Trata erros de programacao como problemas com CLOB
            DBMS_OUTPUT.PUT_LINE('Erro de programação.');
            v_json := NULL;
        WHEN OTHERS THEN
            -- Trata qualquer outro erro 
            DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
            v_json := NULL;
    END;
    
    RETURN v_json;
END converteJson;


--Funcao 2- essa funcao substitui a procedure listar_empresa_backlog presente na entrega da sprint 2

SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION listar_empresa_backlog
RETURN CLOB IS
    v_json CLOB := '[';
BEGIN
    FOR i IN (
        SELECT e.id_empresa, e.nm_empresa, e.razao_social, e.nome_fantasia,
               b.id_backlog, b.titulo, b.descricao_backlog
        FROM tb_empresa1 e
        JOIN tb_backlog1 b ON e.id_empresa = b.id_empresa
    )
    LOOP
        v_json := v_json || '{' ||
                  '"id_empresa": ' || '"' || i.id_empresa || '", ' ||
                  '"nm_empresa": "' || i.nm_empresa || '", ' ||
                  '"razao_social": "' || i.razao_social || '", ' ||
                  '"nome_fantasia": "' || i.nome_fantasia || '", ' ||
                  '"id_backlog": ' || '"' || i.id_backlog || '", ' ||
                  '"titulo": "' || i.titulo || '", ' ||
                  '"descricao_backlog": "' || i.descricao_backlog || '"' ||
                  '},';
    END LOOP;
    
    -- Remove a última vírgula e fecha o JSON
    IF v_json LIKE '%,]' THEN
        v_json := SUBSTR(v_json, 1, LENGTH(v_json) - 1);
    END IF;
    v_json := v_json || ']';
    
    RETURN v_json;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'Erro: ' || SQLERRM;
END listar_empresa_backlog;

--bloco anonimo para chamar a function 
DECLARE
    v_result CLOB;
BEGIN
    v_result := listar_empresa_backlog;
    DBMS_OUTPUT.PUT_LINE(v_result);
END;

--TRIGGERS
--TRIGGER PARA INSERT

CREATE OR REPLACE TRIGGER after_insert_tb_produto1
AFTER INSERT ON tb_produto1
FOR EACH ROW
BEGIN
    INSERT INTO tb_auditoria_produto1 (operacao_tipo, dados_anteriores, dados_novos, usuario_nome)
    VALUES (
        'INSERT',
        NULL,
        'id_produto=' || :NEW.id_produto || 
        ', nm_produto=' || :NEW.nm_produto || 
        ', preco_custo=' || :NEW.preco_custo || 
        ', descricao_produto=' || :NEW.descricao_produto || 
        ', preco_venda=' || :NEW.preco_venda || 
        ', estoque=' || :NEW.estoque || 
        ', tb_categoria_id_categoria=' || :NEW.tb_categoria_id_categoria || 
        ', tb_modelo_id_modelo=' || :NEW.tb_modelo_id_modelo || 
        ', tb_modelo_tb_marca_id_marca=' || :NEW.tb_modelo_tb_marca_id_marca,
        USER
    );
END;

--TRIGGER PARA UPDATE

CREATE OR REPLACE TRIGGER after_update_tb_produto1
AFTER UPDATE ON tb_produto1
FOR EACH ROW
BEGIN
    INSERT INTO tb_auditoria_produto1 (operacao_tipo, dados_anteriores, dados_novos, usuario_nome)
    VALUES (
        'UPDATE',
        'id_produto=' || :OLD.id_produto || 
        ', nm_produto=' || :OLD.nm_produto || 
        ', preco_custo=' || :OLD.preco_custo || 
        ', descricao_produto=' || :OLD.descricao_produto || 
        ', preco_venda=' || :OLD.preco_venda || 
        ', estoque=' || :OLD.estoque || 
        ', tb_categoria_id_categoria=' || :OLD.tb_categoria_id_categoria || 
        ', tb_modelo_id_modelo=' || :OLD.tb_modelo_id_modelo || 
        ', tb_modelo_tb_marca_id_marca=' || :OLD.tb_modelo_tb_marca_id_marca,
        'id_produto=' || :NEW.id_produto || 
        ', nm_produto=' || :NEW.nm_produto || 
        ', preco_custo=' || :NEW.preco_custo || 
        ', descricao_produto=' || :NEW.descricao_produto || 
        ', preco_venda=' || :NEW.preco_venda || 
        ', estoque=' || :NEW.estoque || 
        ', tb_categoria_id_categoria=' || :NEW.tb_categoria_id_categoria || 
        ', tb_modelo_id_modelo=' || :NEW.tb_modelo_id_modelo || 
        ', tb_modelo_tb_marca_id_marca=' || :NEW.tb_modelo_tb_marca_id_marca,
        USER
    );
END;

--TRIGGER PARA DELETE

CREATE OR REPLACE TRIGGER after_delete_tb_produto1
AFTER DELETE ON tb_produto1
FOR EACH ROW
BEGIN
    INSERT INTO tb_auditoria_produto1 (operacao_tipo, dados_anteriores, dados_novos, usuario_nome)
    VALUES (
        'DELETE',
        'id_produto=' || :OLD.id_produto || 
        ', nm_produto=' || :OLD.nm_produto || 
        ', preco_custo=' || :OLD.preco_custo || 
        ', descricao_produto=' || :OLD.descricao_produto || 
        ', preco_venda=' || :OLD.preco_venda || 
        ', estoque=' || :OLD.estoque || 
        ', tb_categoria_id_categoria=' || :OLD.tb_categoria_id_categoria || 
        ', tb_modelo_id_modelo=' || :OLD.tb_modelo_id_modelo || 
        ', tb_modelo_tb_marca_id_marca=' || :OLD.tb_modelo_tb_marca_id_marca,
        NULL,
        USER
    );
END;

--TESTE DO TRIGGER PARA INSERTS
INSERT INTO tb_produto1 (id_produto, nm_produto, preco_custo, descricao_produto, preco_venda, estoque, tb_categoria_id_categoria, tb_modelo_id_modelo, tb_modelo_tb_marca_id_marca)
VALUES (6, 'Produto A', 100.00, 'Descrição do Produto A', 150.00, 'S', 1, 5, 5);

SELECT * FROM tb_auditoria_produto1;

--TESTE DO TRIGGER PARA  UPDATE
UPDATE tb_produto1
SET preco_venda = 160.00
WHERE id_produto = 6;

SELECT * FROM tb_auditoria_produto1;

--TESTE DO TRIGGER PARA DELETE
DELETE FROM tb_produto1
WHERE id_produto = 6;

SELECT * FROM tb_auditoria_produto1;


