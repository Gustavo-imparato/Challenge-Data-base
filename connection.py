import cx_Oracle

cx_Oracle.init_oracle_client(lib_dir=r"/instantclient_21_13")
#configurei a importação com a instantclient_21_13 dentro da pasta, porém pelo peso dela a retirei no momento do envio

hostname = "oracle.fiap.com.br"
port = "1521"
sid = "ORCL"
username = "RM551988"
password = "310304"

#estabelecendo conexão
dsn_tns = cx_Oracle.makedsn(hostname, port, sid)
connection = cx_Oracle.connect(username, password, dsn_tns)

#criando cursor
cursor = connection.cursor()

#update categoria
try:
    
    id_categoria = 1
    nm_categoria = "nome"
    descricao_categoria = "breve descricao"

    cursor.callproc("CRIAR_CATEGORIA", [id_categoria, nm_categoria, descricao_categoria])
    print("Procedure para update de categoria executada com sucesso :) ")

    connection.commit()

except cx_Oracle.DatabaseError as e:
    error, = e.args
    print("Erro ao executar a procedure: ", error.message)
    connection.rollback()

    

#update marca
try:
    
    id_marca = 1
    nm_marca = "nome"
    descricao_marca = "breve descricao de cada marca"

    cursor.callproc("CRIAR_MARCA", [id_marca, nm_marca, descricao_marca])
    print("Procedure para update de marca executada com sucesso :) ")

    connection.commit()

except cx_Oracle.DatabaseError as e:
    error, = e.args
    print("Erro ao executar a procedure: ", error.message)
    connection.rollback()

#update modelo
try:
    
    id_modelo = 1
    nm_modelo = "nome"
    descricao_modelo = "breve descricao"
    tb_marca_id_marca = 2

    cursor.callproc("CRIAR_MODELO", [id_modelo, nm_modelo, descricao_modelo, tb_marca_id_marca])
    print("Procedure para update de modelo executada com sucesso :) ")

    connection.commit()

except cx_Oracle.DatabaseError as e:
    error, = e.args
    print("Erro ao executar a procedure: ", error.message)
    connection.rollback()

#update historico de venda 
try:
    
    id_venda = 1
    vl_venda = "nome"
    dt_venda = "breve descricao"

    cursor.callproc("CRIAR_CATEGORIA", [id_venda, vl_venda, dt_venda])
    print("Procedure para update de historico de venda executada com sucesso :) ")

    connection.commit()

except cx_Oracle.DatabaseError as e:
    error, = e.args
    print("Erro ao executar a procedure: ", error.message)
    connection.rollback()

#update carrinho

try:
    
    id_carrinho = 1
    qnt_produtos = 4
    sub_total = 50
    tb_produto_id_produto = 3
    tb_historico_venda_id_venda = 4
    tb_produto_tb_modelo_id_modelo = 6
    tb_produto_tb_modelo_id_marca = 7
    tb_produto_tb_categoria_id_categoria = 9

    cursor.callproc("CRIAR_CARRINHO", [id_carrinho, qnt_produtos, sub_total, tb_produto_id_produto, tb_historico_venda_id_venda, tb_produto_tb_modelo_id_modelo, tb_produto_tb_modelo_id_marca, tb_produto_tb_categoria_id_categoria  ])
    print("Procedure para update de carrinho executada com sucesso :) ")

    connection.commit()

except cx_Oracle.DatabaseError as e:
    error, = e.args
    print("Erro ao executar a procedure: ", error.message)
    connection.rollback()

#update produto
try:
    
    id_produto = 1
    nm_produto = "nome"
    preco_custo = 60.67
    descricao_produto = "breve descricao"
    preco_venda = 79.99
    estoque = 24
    tb_categoria_id_categoria = 1
    tb_modelo_id_modelo = 4
    tb_modelo_tb_marca_id_marca = 6

    cursor.callproc("CRIAR_PRODUTO", [id_produto, nm_produto, preco_custo, descricao_produto, preco_venda, estoque, tb_categoria_id_categoria, tb_modelo_id_modelo, tb_modelo_tb_marca_id_marca])
    print("Procedure para update de produto executada com sucesso :) ")

    connection.commit()

except cx_Oracle.DatabaseError as e:
    error, = e.args
    print("Erro ao executar a procedure: ", error.message)
    connection.rollback()

finally:
    # Close cursor and connection in finally block
    cursor.close()
    connection.close()
    

