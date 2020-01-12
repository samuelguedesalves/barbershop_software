create database Banco_DS;
use Banco_DS;

#drop database Banco_ds;

create table Tipo_Usuario (
cod_tipo_usu integer not null primary key auto_increment,
Tipo_Usuario varchar (200) not null
);
insert into Tipo_Usuario value(1, "Adiministrador");
insert into Tipo_Usuario value(2, "Funcionário");
insert into Tipo_Usuario value(3, "Caixa");
insert into Tipo_Usuario value(4, "Programador");

-- mostrando os tipos de usuário disponíveis: vai ser mostrado no combobox
delimiter $$
create procedure selecionar_Tipo_Usuario()
begin
select Tipo_Usuario.Tipo_Usuario as "Tipo do Usuário"
from Tipo_Usuario;
end;
$$ delimiter ;
call selecionar_Tipo_Usuario();

create table Usuario (
cod_usu integer not null primary key auto_increment,
nome_usu varchar (200) not null,
senha_usu varchar (200) not null,
cod_tipo_Usu integer not null,
foreign key (cod_tipo_Usu) references Tipo_Usuario (cod_tipo_usu)
);
-- procedimento para cadastar usuário
delimiter $$
create procedure cadastrar_Usuario(Usuario varchar (200), senha varchar (200), cod_tipo_Usu integer)
begin
declare teste_usu integer;
select cod_usu into teste_usu from Usuario where nome_usu = Usuario;

if(Usuario<>'') and (senha<>'') then
	if(teste_usu <> 0)then
		select ' Já existe um usuário com o esse nome!' as confirmação;
	else
		insert into Usuario value(null, Usuario, senha, cod_tipo_Usu);
		select ' Usuario inserido' as confirmação;
	end if;
else
	select 'Insira todas as informações requeridas!' as erro;
end if;
end;
$$ delimiter ;
call cadastrar_Usuario('Rafael', 'martins', 2);
call cadastrar_Usuario('samuel', 'samu', 4);
call cadastrar_Usuario('Marco', 'sougay', 3);
#delete from usuario where cod_usu = 2;

-- procedimento de verificação do usuário e retorna i tio do usuário logado
delimiter $$
create procedure verificar_Usuario(nome_usuario varchar (200), senha_usuario varchar (200))
begin

declare cod_user varchar(200);
declare senha_user varchar(200);
declare funcao_user  varchar(200);

select cod_usu into cod_user from Usuario where nome_usu= nome_usuario;
select senha_usu into senha_user from Usuario  where cod_usu = cod_user;

select Tipo_Usuario.Tipo_Usuario into funcao_user from Tipo_Usuario, Usuario 
where usuario.cod_tipo_Usu = Tipo_Usuario.cod_tipo_usu and cod_usu = cod_user;

if(cod_user is not null) then
	if(senha_user = senha_usuario)then
		if(nome_usuario<>'') and (senha_usuario<>'')then
			select funcao_user as resposta;
		else
			select 'Preencham os campos requeridos!' as resposta;
        end if;
    else
		select 'senha ESTA incorretos ' as resposta;
    end if;
else
	select 'O usuario esta incorreto ' as resposta;
end if;
end;
$$ delimiter ;

call verificar_Usuario('samuel', 'samu');
call verificar_Usuario('Rafael', 'martins');
#drop procedure verificar_Usuario;


create table Estado (
cod_est integer not null primary key auto_increment,
nome_est varchar (200) not null,
sigla_est varchar (2)
);
-- procediemnto de inserção de estado;
delimiter $$
create procedure inserirEstado(nome_est varchar (200), sigla_est varchar (2))
begin
insert into Estado value(null, nome_est, sigla_est);
select 'Estado inserido' as confirmação;
end;
$$ delimiter ;
call inserirEstado('Rondônia', 'RO');

create table cidade (
cod_cid integer not null primary key auto_increment,
nome_cid varchar (200) not null,
cod_est_cid int,
foreign key (cod_est_cid) references Estado (cod_est)
);

-- procediemnto inserção de cidade;
delimiter $$
create procedure inserirCidade(nome_cid varchar (200), cod_est int)
begin
insert into cidade value(null, nome_cid, cod_est);
select 'Cidade inserido' as confirmação;
end;
$$ delimiter ;
call inserirCidade('Ji-Paraná', 1);

-- procediemento para mostrar no combobox, as cidades pré-cadastradas no banco, afim de que sej selecionado e tmbém ja seja identificado o UF 
delimiter $$
create procedure mostrar_cidade_cadastradas()
begin
select 
cidade.nome_cid as Cidade,
-- estabelecendo conexão entre as duas tabelas(cidade.cod_est_cid= Estado.cod_est)
Estado.sigla_est as UF
from
cidade, Estado
where cidade.cod_est_cid= Estado.cod_est;
end;
$$ delimiter ;
call mostrar_cidade_cadastradas();

create table Sexo (
cod_sexo int not null primary key auto_increment,
nome_sexo varchar (100) not null
);
-- procediemnto inserção de sexo;
delimiter $$
create procedure inserirSexo(nome_sexo varchar (100))
begin
insert into Sexo value(null, nome_sexo);
select 'Sexo inserido' as confirmação;
end;
$$ delimiter ;
call inserirSexo('Masculino');
call inserirSexo('Feminino');
call inserirSexo('Outro');

-- na interface Cadastrar funcionario- chamar o procedimeno para adcionar o sexo, no caso os sexos inseridos
delimiter $$
create procedure inserir_Sexos()
begin
select Sexo.nome_sexo as Sexo from Sexo;
end;
$$ delimiter ;
call inserir_Sexos();

create table Cliente (
cod_cli integer not null primary key auto_increment,
nome_cli varchar (200) not null,
cpf_cli varchar (20) not null,
rg_cli varchar (30),
datanasc_cli date,
telefone_cli varchar (50),
email_cli varchar (200) not null,
endereco_cli varchar (200),
cod_sex_Cli integer not null,
foreign key (cod_sex_Cli) references Sexo (cod_sexo)
);
-- Fazer validação do CPF

-- procedimento inserção de Cliente;
delimiter $$
create procedure cadastrarCliente(nome_cli varchar (200), cpf_cli varchar (20), rg_cli varchar (30),
 datanasc_cli date, telefone_cli varchar (50), email_cli varchar (200), endereco_cli varchar (200),  cod_sex_Cli integer)
begin
insert into Cliente value(null, nome_cli, cpf_cli, rg_cli, datanasc_cli, telefone_cli, email_cli, endereco_cli, cod_sex_Cli);
SELECT 'Cliente inserido' AS confirmação;

end;
$$ delimiter ;
call cadastrarCliente('Rafael', 05631238290, 234323, '2001-08-11', '993192714', 'rafaelmartins11@gmail.com', 'rua amazonas, bairro matagal, número 2222', 1);
call cadastrarCliente('samuel', 02331535230, 225505, '2001-07-12', '993192714', 'samuelguedes@gmail.com', 'rua amazonas, bairro matagal, número 2222', 1);

-- Função buscar cliente:
delimiter $$
create procedure buscar_Cliente()
begin
	select Cliente.nome_Cli as "Cliente" from Cliente;
end;
$$ delimiter ;
call buscar_Cliente();

create table Funcionario (
cod_func integer not null primary key auto_increment,
nome_func varchar (200) not null,
rg_func varchar (20),
cpf_func varchar (20) not null,
datanasc_func date,
telefone_func varchar (50),
email_func varchar (200) not null,
estado_civil_func varchar (200) not null,
endereco_cli varchar (200),
cod_sex_Fun integer not null,
foreign key (cod_sex_Fun) references Sexo (cod_sexo)
);
-- procedimento inserção de Funcionario;
delimiter $$
create procedure cadastrarFuncionario(nome_func varchar (200),
rg_func varchar (20), cpf_func varchar (20) , datanasc_func date, telefone_func varchar (50), 
email_func varchar (200) , estado_civil_func varchar (200) , endereco_func varchar (200), cod_sex_Fun integer)
begin
insert into Funcionario value(null, nome_func, rg_func, cpf_func, datanasc_func, telefone_func, email_func, estado_civil_func, endereco_func, cod_sex_Fun );
SELECT ' Fucnionario inserido!' AS confirmação;
end;
$$ delimiter ;
call cadastrarFuncionario('samuel', 5445454, 05631838290, '2012-10-09','992644585', 'rafaelmartins99@gmail.com', 'rondônia','rua amazonas, bairro matagal, número 2222' , 1);

create table Fornecedor(
cod_forn integer not null primary key auto_increment,
nome_forn varchar(200) not null,
cnpj_forn varchar(200) not null,
cep_forn varchar(200) not null,
telefone varchar(50) not null,
email_func varchar (200) not null,
endereco_func varchar (200),
cod_uf_func integer not null,
cod_cidade_forn integer not null,
foreign key (cod_uf_func) references Estado (cod_est),
foreign key (cod_cidade_forn) references cidade (cod_cid)
);
-- procedimento inserção de Fornecedor;
delimiter $$
create procedure cadastrarFornecedor(nome_forn varchar(200), cnpj_forn varchar(200), cep_forn varchar(200), 
telefone varchar(50), email_func varchar (200), endereco_func varchar (200), cod_uf_func integer, cod_cidade_forn integer)
begin
	insert into Fornecedor value(null, nome_forn, cnpj_forn, cep_forn, telefone, email_func, endereco_func, cod_uf_func, cod_cidade_forn);
	select ' Fornecedor inserido!' as confirmação;
end;
$$ delimiter ;
call cadastrarFornecedor('Locks','rhaler', '25255-45', '95603-648', 'maridamargaret@gmail.com', 'rua amazonas, bairro matagal, número 2222', 1, 1);
call cadastrarFornecedor('Hollister','rhaler', '25255-45', '95603-648', 'maridamargaret@gmail.com', 'rua amazonas, bairro matagal, número 2222', 1, 1);
#drop procedure buscar_Fornecedor
delimiter $$
create procedure buscar_Fornecedor()
begin
	select Fornecedor.nome_forn as 'nome', Fornecedor.cod_forn as 'codigo' from Fornecedor;
end;
$$ delimiter ;
call buscar_Fornecedor();


-- tirei o atributo quantidade
create table Produto(
cod_prod integer primary key not null auto_increment,
nome_prod varchar(200) not null,
valor_Unit_Forn_prod double not null,
valor_Unit_vend_prod double not null,
cod_forn_Prod integer not null,
foreign key (cod_forn_Prod) references Fornecedor (cod_forn)
);
-- procedimento inserção de Produto;
delimiter $$
create procedure cadastrarProduto(nome_prod varchar(200), valor_Unit_Forn_prod double, valor_Unit_vend_prod double, cod_forn_Prod integer)
begin
	insert into Produto value(null, nome_prod, valor_Unit_Forn_prod, valor_Unit_vend_prod, cod_forn_Prod);
	SELECT ' Produto inserido!' AS confirmação;
end;
$$ delimiter ;
call cadastrarProduto('shamp',15.50, 19.50, 1);
call cadastrarProduto('shamp',15.50, 19.50, 1);
call cadastrarProduto('bagre',10.00, 15.00, 1);

create table Servico (
cod_serv integer not null primary key auto_increment,
descricao_serv varchar(300),
tipo_serv varchar (100),
valor_serv float not null,
tempo_serv time
);
-- procedimento inserção do Servico;
delimiter $$
create procedure cadastrarServico(descricao_serv varchar(300),tipo_serv varchar (100), valor_serv float, tempo_serv time)
begin
	insert into Servico value(null, descricao_serv, tipo_serv, valor_serv, tempo_serv);
	SELECT ' Servico inserido!' AS confirmação;
end;
$$ delimiter ;
call cadastrarServico('Corte capilar', 'corte', 15.00, '02:00');


-- ----------- NESTE CASO, ESSA INTERFACE VAI EMNVOLVER DIFERENTES PROCEDIMENTOS duas tabelas:  Compra_Produto, Itens_Compra
-- ----------------- Inseirir compra(vou criar uma forma de captar o ultimo codigo + 1);
create table Compra_Produto (
cod_comp integer not null primary key auto_increment,
data_comp date,
valortotal_comp double,
formpag_comp varchar (100),
cod_forn_CP integer,
foreign key (cod_forn_CP) references Fornecedor (cod_forn)
);

create table Itens_Compra (
cod_itenscomp integer not null primary key auto_increment,
quant_itenscomp integer not null,
valor_itenscomp float not null,
cod_prod_itenscomp integer not null,
cod_comp_itenscomp integer not null,
foreign key (cod_prod_itenscomp) references Produto (cod_prod),
foreign key (cod_comp_itenscomp) references Compra_Produto (cod_comp)
);

-- criando variavel global, que será chamada na camada de aplicação: Número de Compras
delimiter $$
create trigger atualizarNum_compra after insert on Compra_Produto for each row
begin
if((select cod_comp from Compra_Produto where cod_comp = new.cod_comp) > 1)then
	select cod_comp into @Num_compra from Compra_Produto where ((cod_comp = last_insert_id() +1));
else
	select cod_comp into @Num_compra from Compra_Produto where (cod_comp = last_insert_id());
end if;
end;
$$ delimiter ;
-- procedimento inserção de Compra_Produto;
#drop procedure comprarProdutos;
delimiter $$
create procedure comprarProdutos()
begin
	insert into Compra_Produto values (null, curdate(), null, '', null);
	select @Num_compra as resposta;
else
	select 'O código do fornecedor informado não existe!' as Alerta;
end if;
end;
$$ delimiter ;
call comprarProdutos('2019-09-09','', '');
call comprarProdutos('2019-09-09','cartão de crédito', 1);
call comprarProdutos('2019-09-09','cartão de crédito', 1);


select @num_compra;

-- criando gatilho para realizar atulizações em: valor total da compra --------- na quantidade do produto
-- no valor unitario do produto comprado do fornecedor
delimiter $$
create trigger inserirItemCompra after insert on itens_compra for each row
begin
select valor_Unit_Forn_prod into @valor_unit_Forn from produto where cod_prod = new.cod_prod_itenscomp;

update compra_produto set valortotal_comp = valortotal_comp + (new.quant_itenscomp * new.valor_itenscomp)
	where cod_comp = new.cod_comp_itenscomp;
    
update Produto set valor_Unit_Forn_prod = new.valor_itenscomp 
	where cod_prod = new.cod_prod_itenscomp;
end;
$$ delimiter ;
drop trigger inserirItemCompra;
-- criação do procedimento itens_compra
-- vai ser chamada no ---- + (mais)----- da interface
delimiter $$
create procedure InserirItemCompra(quant_itenscomp integer, valor_itenscomp float, cod_prod_itenscomp integer, cod_comp_itenscomp integer)
begin
	insert into itens_compra values (null, quant_itenscomp, valor_itenscomp, cod_prod_itenscomp, cod_comp_itenscomp);
	select 'Itens da compra inserido com sucesso!' as Confirmacao;
end;
$$ delimiter ;
drop procedure InserirItemCompra;
-- chamada do procedimento--------->>> OK
call InserirItemCompra(10, 12.00, 1, 1);
call InserirItemCompra(2, 4.00, 1, 1);
call InserirItemCompra(2, 4.00, 1, 2);


-- criação do gatilho para negativar os itens da compra, ou seja. Refere-se ao quesito de desistencia do iten da compra
-- sera executado apos apertar na licheira da interface
delimiter $$
create trigger removerItemCompra after delete on itens_compra for each row
begin

update compra_produto set valortotal_comp = valortotal_comp - (old.quant_itenscomp * old.valor_itenscomp)
	where cod_comp = old.cod_comp_itenscomp;
    
update produto set valor_Unit_Forn_prod = @valor_unit_Forn
	where cod_prod = old.cod_prod_itenscomp;

end;
$$ delimiter ;

-- criação do procedimento para negativar os itens da compra, ou seja. Refere-se ao quesito de desistencia do iten da compra
-- Coversando com a inteface------>>>>> sera o botãozinho da LICHEIRA 
delimiter $$
create procedure RemoverItemCompra(cod_itenscompra integer)
begin
	delete from itens_compra where cod_itenscomp = cod_itenscompra;
	select 'Itens removido com sucesso!' as Confirmacao;
end;
$$ delimiter ;
-- chamada do procedimento------>>>> OK

-- Para o botão cancelar compra---- criação do procedimento para cancelar a compra
delimiter $$
create procedure cancelarCompra_produto()
begin
	delete from itens_compra where cod_comp_itenscomp = @Num_compra;
    
	delete from Compra_produto where cod_comp = @Num_compra;
	select 'Compra removida com sucesso!' as Confirmacao;
end;
$$ delimiter ;
-- chamando o procedimento->>>>>>>OK
call cancelarCompra_produto();
select @Num_compra;

create table Caixa (
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
--  ainda não vou mecher

create table Venda (
cod_vend integer not null primary key auto_increment,
data_vend date,
valortotal_vend double not null,
desconto_vend double,
formpag_vend varchar (50),
parcelas_vend int,
cod_cli_vend integer not null,
foreign key (cod_cli_vend) references Cliente (cod_cli)
);


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
select nome_cli as Cliente, telefone_cli as Telefone 
from cliente 
where nome_cli = nome_cliente;

select cod_cli into @cod_cliente from cliente where nome_cli = nome_cliente;
end;
$$ delimiter ;
call selecionando_armazenando_cliente('samuel');
 
-- criar procedimento para inserir venda
delimiter $$
create procedure vender_Produtos(data_vend date, valortotal_vend double , 
desconto_vend double, formpag_vend varchar (50), parcelas_vend int)
begin
declare cod_cliente integer;
set cod_cliente= @cod_cliente;

if((formpag_vend = 'a vista') and (parcelas_vend = 1)) or ((formpag_vend = 'parcelado') and (parcelas_vend between 2 and 6)) then

	insert into Venda value(null, data_vend, valortotal_vend, desconto_vend, formpag_vend, parcelas_vend, cod_cliente);
	select 'Venda realizada com Sucesso' as confirmação;
else	
	select 'A forma de pagamento uinserido não existe' as Alerta;
end if;
end;
$$ delimiter ;
drop procedure vender_Produtos;
call vender_Produtos('2019-10-02', 50.00, 1.05, 'A vista', 1);
call vender_Produtos('2019-10-03', 100.00, 1.05, 'A vista', 1);

create table Itens_Venda(
cod_itensvend integer not null primary key auto_increment,
quant_itensvend integer not null,
cod_prod integer not null,
cod_vend integer not null,
foreign key (cod_prod) references Produto (cod_prod),
foreign key (cod_vend) references Venda (cod_vend)
);

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
foreign key (cod_caixa) references Caixa (cod_caixa),
foreign key (cod_vend) references Venda (cod_vend),
foreign key (cod_func) references Funcionario (cod_func)
);

create table Despesas (
cod_desp integer not null primary key auto_increment,
descrição_desp varchar (200),
valor_desp double,
númerodoc_desp integer,
cod_forn int,
foreign key (cod_forn) references Fornecedor (cod_forn)
);


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
foreign key (cod_caixa) references Caixa (cod_caixa),
foreign key (cod_desp) references Despesas (cod_desp),
foreign key (cod_comp) references Compra_produto (cod_comp),
foreign key (cod_func) references Funcionario (cod_func)

);
create table Promocao(
cod_promo integer not null primary key auto_increment,
valor_promo float,
validade_promo varchar (100),
cod_prod_promo integer not null,
foreign key(cod_prod_promo) references Produto(cod_prod)
);

delimiter $$
create procedure cadastrarPromocao(valor_promo float,  cod_prod_promo integer)
begin
set validade_promo = (select validade_prod);

	insert into Promocao value(valor_promo, cod_prod_promo);
	select 'Pormocão cadastrada com sucesso!' as Confirmacao;
end;
$$ delimiter ;

delimiter $$
create procedure verificar_Produtos_Disponiveis_para_Promocao()
begin
	
    select cod_prod, nome_prod from produto where quant_prod > 0;
    
end;
$$ delimiter ;
call verificar_Produtos_Disponiveis_para_Promocao();

-- feito pelo marco
delimiter $$
create procedure combox_selecionar_produto(cod_forne integer)
begin
if(cod_forne = (select cod_forn from fornecedor where cod_forn = cod_forne))then
select produto.cod_prod as 'codigo', produto.nome_prod as 'nome', produto.valor_Unit_Forn_prod as 'valor' from produto where cod_forn_Prod = cod_forn_prod order by produto.nome_prod;

else
    select 'fornecedor não existe' as fail;
    end if;
end;
$$ delimiter ;
call combox_selecionar_produto(1);
-- drop procedure combox_selecionar_produto;


delimiter $$
create procedure buscar_valor_Produto(cod_Produto integer)
begin
select Produto.nome_prod as 'nome' , Produto.valor_Unit_Forn_prod as 'valor' from Produto
where Produto.cod_prod = cod_Produto order by nome_prod; 
end;
$$ delimiter ;
drop procedure buscar_valor_Produto;
call buscar_valor_Produto(3);
-- drop procedure buscar_valor_Produto;

-- procedimento nova compra de produtos
delimiter $$
create procedure nova_compra_produtos ()
begin
	insert into compra_produto values ();
end;
$$ delimiter ;