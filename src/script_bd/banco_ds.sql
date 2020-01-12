#alter user 'root'@'localhost' identified with mysql_native_password by 'root';

create database Banco_DS;
use Banco_DS;

-- -------------------------- TABELAS DO BANCO ---------------

-- tabela do tipo de usuario
create table tipo_usuario (
cod_tipo_usu integer not null primary key auto_increment,
tipo_usuario varchar (200) not null
);
insert into tipo_usuario value(1, "Adiministrador");
insert into tipo_usuario value(2, "Funcionário");
insert into tipo_usuario value(3, "Caixa");

-- tabela usuario
create table usuario (
cod_usu integer not null primary key auto_increment,
nome_usu varchar (200) not null,
senha_usu varchar (200) not null,
cod_tipo_usuario integer not null,
foreign key (cod_tipo_usuario) references tipo_usuario(cod_tipo_usu)
);

-- tabela estado
create table estado (
cod_est integer not null primary key auto_increment,
nome_est varchar (200) not null,
sigla_est varchar (2)
);

-- tabela cidade
create table cidade (
cod_cid integer not null primary key auto_increment,
nome_cid varchar (200) not null,
cod_est_cid int,
foreign key (cod_est_cid) references estado(cod_est)
);

-- tabela sexo
create table sexo (
cod_sexo int not null primary key auto_increment,
nome_sexo varchar (100) not null
);

-- tabela cliente
create table cliente (
cod_cli integer not null primary key auto_increment,
nome_cli varchar (200) not null,
cpf_cli varchar (20) not null,
rg_cli varchar (30),
datanasc_cli date,
telefone_cli varchar (50),
email_cli varchar (200) not null,
endereco_cli varchar (200),
cod_sex_Cli integer not null,
foreign key (cod_sex_Cli) references sexo(cod_sexo)
);

-- tabela funcionario
create table funcionario (
cod_func integer not null primary key auto_increment,
nome_func varchar (200) not null,
rg_func varchar (20),
cpf_func varchar (20) not null,
datanasc_func date,
telefone_func varchar (50),
email_func varchar (200) not null,
estado_civil_func varchar (200) not null,
endereco_cli varchar (200),
cod_sex_func integer not null,
foreign key (cod_sex_func) references sexo(cod_sexo)
);

-- tabela fornecedor
create table fornecedor(
cod_forn integer not null primary key auto_increment,
nome_forn varchar(200) not null,
cnpj_forn varchar(200) not null,
cep_forn varchar(200) not null,
telefone varchar(50) not null,
email_func varchar (200) not null,
endereco_func varchar (200),
cod_uf_func integer not null,
cod_cidade_forn integer not null,
foreign key (cod_uf_func) references estado (cod_est),
foreign key (cod_cidade_forn) references cidade(cod_cid)
);

-- tabela produto
create table produto(
cod_prod integer primary key not null auto_increment,
nome_prod varchar(200) not null,
quant_Prod int not null,
valor_Unit_Forn_prod double not null,
valor_Unit_vend_prod double not null,
cod_forn_Prod integer not null,
foreign key (cod_forn_Prod) references fornecedor(cod_forn)
);

-- tabela compra de produto
create table compra_produto (
cod_comp integer not null primary key auto_increment,
data_comp date,
valortotal_comp double,
formpag_comp varchar (100),
cod_forn_CP integer,
foreign key (cod_forn_CP) references fornecedor(cod_forn)
);
insert into compra_produto values (null, '2001-03-07', 1000, 'avista', 1);

-- tabela itens da compra de produtos
create table Itens_Compra (
cod_itenscomp integer not null primary key auto_increment,
quant_itenscomp integer not null,
valor_itenscomp float not null,
cod_prod_itenscomp integer not null,
cod_comp_itenscomp integer not null,
foreign key (cod_prod_itenscomp) references produto(cod_prod),
foreign key (cod_comp_itenscomp) references compra_produto(cod_comp)
);

-- tabela serviços
create table servico (
cod_serv integer not null primary key auto_increment,
descricao_serv varchar(300),
tipo_serv varchar (100),
valor_serv float not null,
tempo_serv time
);

-- tabela caixa
create table caixa (
cod_caixa integer not null primary key auto_increment,
dataabertura_caixa date not null,
datafechamento_caixa date,
saldoinicial_caixa double not null,
troco_caixa double,
valorcréditos_caixa double,
valordébitos_caixa double,
saldofinal_caixa double,
status_caixa varchar (100) not null
);

-- tabela venda
create table venda (
cod_vend integer not null primary key auto_increment,
data_vend date,
valortotal_vend double not null,
desconto_vend double,
formpag_vend varchar (50),
parcelas_vend int,
cod_cli_vend integer not null,
foreign key (cod_cli_vend) references cliente(cod_cli)
);

-- tabela itens presentes na lista de venda
create table Itens_venda(
cod_itensvend integer not null primary key auto_increment,
quant_itensvend integer not null,
cod_prod integer not null,
cod_vend integer not null,
foreign key (cod_prod) references produto(cod_prod),
foreign key (cod_vend) references venda(cod_vend)
);

-- tabela de recebimento
create table Recebimentos (
cod_receb integer not null primary key auto_increment,
datavencimento_receb date,
valor_receb double,
parcela_receb varchar(100),
status_receb varchar (100),
formapagamento_receb varchar (100),
datapagamento_receb date,
cod_func integer,
cod_caixa integer,
cod_vend integer not null,
foreign key (cod_caixa) references caixa(cod_caixa),
foreign key (cod_vend) references venda(cod_vend),
foreign key (cod_func) references funcionario(cod_func)
);

-- tabela de despesas
create table Despesas (
cod_desp integer not null primary key auto_increment,
descrição_desp varchar (200),
valor_desp double,
númerodoc_desp integer,
cod_forn int,
foreign key (cod_forn) references fornecedor(cod_forn)
);

-- tabela de pagamentos
create table Pagamentos (
cod_pag integer not null primary key auto_increment,
datavencimento_pag date,
valor_pag float,
parcela_pag varchar (100),
status_pag varchar (100),
formapagamento_pag varchar (100),
datapagamento_pag date,
cod_func integer,
cod_caixa integer,
cod_desp integer,
cod_comp integer,
foreign key (cod_caixa) references caixa(cod_caixa),
foreign key (cod_desp) references Despesas(cod_desp),
foreign key (cod_comp) references compra_produto(cod_comp),
foreign key (cod_func) references funcionario(cod_func)
);

-- tabela de promoção
create table Promocao(
cod_promo integer not null primary key auto_increment,
valor_promo float,
validade_promo varchar (100),
cod_prod_promo integer not null,
foreign key(cod_prod_promo) references produto(cod_prod)
);


-- -------------------------- PROCEDIMENTOS DO BANCO ---------------


-- mostrando os tipos de usuário disponíveis: vai ser mostrado no combobox
delimiter $$
create procedure selecionar_tipo_usuario()
begin
select tipo_usuario.tipo_usuario as "Tipo do Usuário"
from tipo_usuario;
end;
$$ delimiter ;
call selecionar_tipo_usuario();

-- procedimento para cadastar usuário
delimiter $$
create procedure cadastrar_usuario(usuario varchar (200), senha varchar (200), cod_tipo_usuario integer)
begin
	declare teste_usu integer;
	select cod_usu into teste_usu from usuario where nome_usu = usuario;

	if(usuario<>'') and (senha<>'') then
		if(teste_usu <> 0)then
			select ' Já existe um usuário com o esse nome!' as confirmação;
		else
			insert into usuario value(null, usuario, senha, cod_tipo_usuario);
			select ' usuario inserido' as confirmação;
		end if;
	else
		select 'Insira todas as informações requeridas!' as erro;
	end if;
end;
$$ delimiter ;
call cadastrar_usuario('Rafael', 'martins', 2);
call cadastrar_usuario('samuel', 'samu', 2);
call cadastrar_usuario('marco', 'sougay', 3;
call cadastrar_usuario('matheus', '1111', 2);


-- procedimento de verificação do usuário paga login
delimiter $$
create procedure verificar_usuario(nome_usuario varchar (200), senha_usuario varchar (200))
begin

	declare cod_user varchar(200);
	declare senha_user varchar(200);
	declare funcao_user  varchar(200);

	select cod_usu into cod_user from usuario where nome_usu= nome_usuario;
	select senha_usu into senha_user from usuario  where cod_usu = cod_user;

	select tipo_usuario into funcao_user from tipo_usuario, usuario 
	where usuario.cod_tipo_usuario = tipo_usuario.cod_tipo_usu and cod_usu = cod_user;

	if(cod_user is not null) then
		if(senha_user = senha_usuario)then
			if(nome_usuario<>'') and (senha_usuario<>'')then
				select funcao_user as resposta;
			else
				select 'Preencha os Campos Requeridos!' as resposta;
			end if;
		else
			select 'Senha Incorreta' as resposta;
		end if;
	else
		select 'Usuario Inválido' as resposta;
	end if;
end;
$$ delimiter ;
call verificar_usuario('samuel', 'samu');
call verificar_usuario('Rafael', 'martins');


-- procediemnto de inserção de estado;
delimiter $$
create procedure inserir_estado(nome_est varchar (200), sigla_est varchar (2))
begin
	insert into estado value(null, nome_est, sigla_est);
	select 'Estado Inserido' as confirmação;
end;
$$ delimiter ;
call inserir_estado('Rondônia', 'RO');


-- procediemnto inserção de cidade;
delimiter $$
create procedure inserir_cidade(nome_cid varchar (200), cod_est int)
begin
	insert into cidade value(null, nome_cid, cod_est);
	select 'Cidade Inserido' as confirmação;
end;
$$ delimiter ;
call inserir_cidade('Ji-Paraná', 1);


-- procediemento para mostrar no combobox, as cidades pré-cadastradas no banco, afim de que sej selecionado e tmbém ja seja identificado o UF 
delimiter $$
create procedure mostrar_cidade_cadastradas()
begin
	-- estabelecendo conexão entre as duas tabelas(cidade.cod_est_cid= estado.cod_est)
	select cidade.nome_cid as cidade, estado.sigla_est as UF from cidade, estado where cidade.cod_est_cid = estado.cod_est;
end;
$$ delimiter ;
call mostrar_cidade_cadastradas();


-- procediemnto inserção de sexo;
delimiter $$
create procedure inserir_sexo(nome_sexo varchar (100))
begin
	insert into sexo value(null, nome_sexo);
	select 'Sexo Inserido' as confirmação;
end;
$$ delimiter ;
call inserir_sexo('Masculino');
call inserir_sexo('Feminino');
call inserir_sexo('Outro');


-- na interface Cadastrar funcionario chamar o procedimeno para adcionar o sexo, no caso os sexos inseridos
delimiter $$
create procedure mostar_sexos()
begin
	select sexo.nome_sexo as sexo from sexo;
end;
$$ delimiter ;
call mostar_sexos();


-- procedimento inserção de cliente;
delimiter $$
create procedure cadastrar_cliente(nome_cli varchar (200), cpf_cli varchar (20), rg_cli varchar (30),
 datanasc_cli date, telefone_cli varchar (50), email_cli varchar (200), endereco_cli varchar (200),  cod_sex_Cli integer)
begin
insert into cliente value(null, nome_cli, cpf_cli, rg_cli, datanasc_cli, telefone_cli, email_cli, endereco_cli, cod_sex_Cli);
SELECT 'Cliente Inserido' AS confirmação;

end;
$$ delimiter ;
call cadastrar_cliente('Rafael', 05631238290, 234323, '2001-08-11', '993192714', 'rafaelmartins11@gmail.com', 'rua amazonas, bairro matagal, número 2222', 1);
call cadastrar_cliente('samuel', 02331535230, 225505, '2001-07-12', '993192714', 'samuelguedes@gmail.com', 'rua amazonas, bairro matagal, número 2222', 1);


-- Função buscar cliente:
delimiter $$
create procedure buscar_cliente()
begin
	select cliente.nome_Cli as "cliente" from cliente;
end;
$$ delimiter ;
call buscar_cliente();


-- Procedimento inserção de Funcionario;
delimiter $$
create procedure cadastrar_funcionario(nome_func varchar (200),
rg_func varchar (20), cpf_func varchar (20) , datanasc_func date, telefone_func varchar (50), 
email_func varchar (200) , estado_civil_func varchar (200) , endereco_func varchar (200), cod_sex_func integer)
begin
insert into funcionario value(null, nome_func, rg_func, cpf_func, datanasc_func, telefone_func, email_func, estado_civil_func, endereco_func, cod_sex_func );
SELECT ' Fucnionario Inserido!' AS confirmação;
end;
$$ delimiter ;
call cadastrar_funcionario('samuel', 5445454, 05631838290, '2012-10-09','992644585', 'rafaelmartins99@gmail.com', 'rondônia','rua amazonas, bairro matagal, número 2222' , 1);


-- Procedimento inserção de fornecedor;
delimiter $$
create procedure cadastrar_fornecedor(nome_forn varchar(200), cnpj_forn varchar(200), cep_forn varchar(200), 
telefone varchar(50), email_func varchar (200), endereco_func varchar (200), cod_uf_func integer, cod_cidade_forn integer)
begin
	insert into fornecedor value(null, nome_forn, cnpj_forn, cep_forn, telefone, email_func, endereco_func, cod_uf_func, cod_cidade_forn);
	select 'Fornecedor Inserido!' as confirmação;
end;
$$ delimiter ;
call cadastrar_fornecedor('Locks','rhaler', '25255-45', '95603-648', 'maridamargaret@gmail.com', 'rua amazonas, bairro matagal, número 2222', 1, 1);


-- Procedimento para buscar fornecedor
delimiter $$
create procedure buscar_fornecedor()
begin
	select fornecedor.nome_forn as 'Nome', fornecedor.cod_forn as 'Cod' from fornecedor;
end;
$$ delimiter ;
# drop procedure buscar_fornecedor;
call buscar_fornecedor();


-- Procedimento inserção de produto;
delimiter $$
create procedure cadastrar_produto(nome_prod varchar(200), valor_Unit_Forn_prod double, valor_Unit_vend_prod double, cod_forn_Prod integer)
begin
	insert into produto value(null, nome_prod, 0, valor_Unit_Forn_prod, valor_Unit_vend_prod, cod_forn_Prod);
	SELECT 'Produto Inserido!' AS confirmação;
end;
$$ delimiter ;
call cadastrar_produto('shamp',15.50, 19.50, 1);
call cadastrar_produto('shamp',15.50, 19.50, 1);
call cadastrar_produto('bagre',10.00, 15.00, 1);


-- Procedimento inserção do servico;
delimiter $$
create procedure cadastrar_servico(descricao_serv varchar(300),tipo_serv varchar (100), valor_serv float, tempo_serv time)
begin
	insert into servico value(null, descricao_serv, tipo_serv, valor_serv, tempo_serv);
	SELECT ' Servico Inserido!' AS confirmação;
end;
$$ delimiter ;
call cadastrar_servico('Corte capilar', 'corte', 15.00, '02:00');


-- Gatilho para variavel global, que será chamada na camada de aplicação: Número de Compras
-- refere-se ao número que estará no alto da interface: indicando o número da compra que o usuário estará efetuando
delimiter $$
create trigger atualizar_num_compra after insert on compra_produto for each row
begin
	if((select cod_comp from compra_produto where cod_comp = new.cod_comp) > 1)then
		select cod_comp into @Num_compra from compra_produto where ((cod_comp = last_insert_id() +1));
	else
		select cod_comp into @Num_compra from compra_produto where (cod_comp = last_insert_id());
	end if;
end;
$$ delimiter ;

-- Gatilho para diminuir a variável global: caso o usuário decida cancelar a compra
delimiter $$
create trigger diminuir_num_compra after delete on compra_produto for each row
begin
	select cod_comp into @Num_compra from compra_produto where ((cod_comp = last_insert_id() -1));
end;
$$ delimiter ;


-- Buscar codigo da compra
delimiter $$
create procedure buscar_codigo_compra ()
begin
	select cod_comp as 'codigo' from compra_produto where cod_comp = last_insert_id();
end;
$$ delimiter ;
call buscar_codigo_compra;


-- Buscar produto de acordo com o fornecedor
delimiter $$
CREATE PROCEDURE buscar_produtos_fornecedor(cod_forn int)
begin
	select cod_prod as 'codigo', nome_prod as 'nome'  from produto where cod_forn_prod = cod_forn;
end;
$$ delimiter ;
call buscar_produtos_fornecedor('1');


-- Procedimento para realizar definitivamente a compra: botão comprar produto
delimiter $$
create procedure finalizar_atualizar_compra_produto()
begin
	declare capitar_data date;
	set capitar_data = curdate();

	insert into compra_produto values (null, curdate(),0, null, null);
	select @Num_compra as resposta;
end;
$$ delimiter ;


-- Criando gatilho para realizar atulizações em: valor total da compra --------- na quantidade do produto
-- No valor unitario do produto comprado do fornecedor
delimiter $$
create trigger inserir_itens_compra after insert on itens_compra for each row
begin
	select valor_Unit_Forn_prod into @valor_unit_Forn from produto where cod_prod = new.cod_prod_itenscomp;

	update compra_produto set valortotal_comp = valortotal_comp + (new.quant_itenscomp * new.valor_itenscomp) where cod_comp = new.cod_comp_itenscomp;    
	update produto set quant_prod = quant_prod + new.quant_itenscomp where cod_prod = new.cod_prod_itenscomp;
	update produto set valor_Unit_Forn_prod = new.valor_itenscomp where cod_prod = new.cod_prod_itenscomp;

end;
$$ delimiter ;


-- Criação do procedimento itens_compra
-- Vai ser chamada no ---- +(mais)----- da interface
delimiter $$
create procedure inserir_itens_compra(quant_itenscomp integer, valor_itenscomp float, cod_prod_itenscomp integer, cod_comp_itenscomp integer)
begin
	insert into itens_compra values (null, quant_itenscomp, valor_itenscomp, cod_prod_itenscomp, cod_comp_itenscomp);
	select 'Itens da Compra Inserido com Sucesso!' as Confirmacao;
end;
$$ delimiter ;
call inserir_itens_compra(10, 12.00, 1, 1);
call inserir_itens_compra(2, 4.00, 1, 1);
call inserir_itens_compra(2, 4.00, 1, 2);


-- Criação do gatilho para negativar os itens da compra, ou seja. Refere-se ao quesito de desistencia do iten da compra
-- Sera executado após apertar na licheira da interface
delimiter $$
create trigger remover_itens_compra after delete on itens_compra for each row
begin
	update compra_produto set valortotal_comp = valortotal_comp - (old.quant_itenscomp * old.valor_itenscomp) where cod_comp = old.cod_comp_itenscomp;	
	update produto set quant_prod = quant_prod - old.quant_itenscomp where cod_prod = old.cod_prod_itenscomp;
	update produto set valor_Unit_Forn_prod = @valor_unit_Forn where cod_prod = old.cod_prod_itenscomp;
end;
$$ delimiter ;


-- Criação do procedimento para negativar os itens da compra, ou seja. Refere-se ao quesito de desistencia do iten da compra
-- Coversando com a inteface------>>>>> sera o botãozinho da LICHEIRA 
delimiter $$
create procedure remover_itens_compra(cod_itenscompra integer)
begin
	delete from itens_compra where cod_itenscomp = cod_itenscompra;
	select 'Itens Removido com Sucesso!' as Confirmacao;
end;
$$ delimiter ;


-- Para o botão cancelar compra---- criação do procedimento para cancelar a compra
delimiter $$
create procedure cancelar_compra_produto()
begin
	delete from itens_compra where cod_comp_itenscomp = @Num_compra;
    
	delete from compra_produto where cod_comp = @Num_compra;
	select 'Compra Removida com Sucesso!' as Confirmacao;
end;
$$ delimiter ;


-- criando variável global que recebe nomes do cliente, para aparecer no combobox, onde o usuário vai escolher
-- o objetivo é, depoius de ser selecionado, o procedimento já recebe o código
delimiter $$
create procedure selecionar_nome_cliente()
begin
	select nome_cli from cliente;
end;
$$ delimiter ;
call selecionar_nome_cliente();


-- criando procedimento de escolher cliente e armazenando o id dele na variável global
-- a lógica é simular o momento onde o cliente será selecionado no combobox
delimiter $$
create procedure selecionando_armazenando_cliente(nome_cliente varchar(200))
begin
	select nome_cli as cliente, telefone_cli as Telefone from cliente where nome_cli = nome_cliente;
	select cod_cli into @cod_cliente from cliente where nome_cli = nome_cliente;
end;
$$ delimiter ;
call selecionando_armazenando_cliente('samuel');


-- criar procedimento para inserir venda
delimiter $$
create procedure vender_produtos(data_vend date, valortotal_vend double , desconto_vend double, formpag_vend varchar (50), parcelas_vend int)
begin
	declare cod_cliente integer;
	set cod_cliente= @cod_cliente;

	if((formpag_vend = 'a vista') and (parcelas_vend = 1)) or ((formpag_vend = 'parcelado') and (parcelas_vend between 2 and 6)) then
		insert into venda value(null, data_vend, valortotal_vend, desconto_vend, formpag_vend, parcelas_vend, cod_cliente);
		select 'Venda Realizada com Sucesso' as confirmação;
	else	
		select 'A Forma de Pagamento Inserido não Existe' as Alerta;
	end if;
end;
$$ delimiter ;
call vender_produtos('2019-10-02', 50.00, 1.05, 'A vista', 1);
call vender_produtos('2019-10-03', 100.00, 1.05, 'A vista', 1);


-- Procedimento para buscar valor do produto
delimiter $$
create procedure buscar_valor_produto(cod_produto integer)
begin
	select produto.nome_prod as 'nome' , produto.valor_Unit_Forn_prod as 'valor' from produto where produto.cod_prod = cod_produto order by nome_prod;
end;
$$ delimiter ;
call buscar_valor_produto(3);


