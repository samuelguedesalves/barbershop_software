const {dialog} = require('electron').remote;
const mysql = require('mysql');
const $ = require('../../../../assets/jquery/jquery-3.4.1.min.js');

var nome_cliente = "";
var sexo_cliente = "";
var cpf_cliente = "";
var rg_cliente = "";
var dataNacimento_cliente = "";
var telefone_cliente = "";
var email_cliente = "";
var endereco_cliente = "";

function change_nome (change_value){
    nome_cliente = change_value;
    if(change_value != ''){
        document.getElementById('nome_do_cliente').innerHTML = change_value;
        document.getElementById('nome_do_cliente_2').innerHTML = change_value;
    }else{
        dialog.showErrorBox("Erro", "É necessario que insira um nome");
        document.getElementById('nome_do_cliente').innerHTML = "Nome";
        document.getElementById('nome_do_cliente_2').innerHTML = "";
    }
}

function change_sexo (change_value){
    if(change_value != '-1'){
        sexo_cliente = change_value;
    }else{
        dialog.showErrorBox("Erro", "Você deve selecionar um SEXO valido!");
    }
}

// capiturar valor do CPF
function change_cpf(change_value){
    if(change_value != ""){
        cpf_cliente = change_value;
    }else{
        dialog.showErrorBox("Erro", "É necessario que você insira um CPF valido!");
    }
}

// capturar valor do RG
function change_rg(change_value){
    if(change_value != ""){
        rg_cliente = change_value;
    }else{
        dialog.showErrorBox("Erro", "É necessario que você insira um RG valido!");
    }
}

// capturar valor do Data de Nacimento
function change_data_nacimento(change_value){
    if(change_value != ""){
        dataNacimento_cliente = change_value;
    }else{
        dialog.showErrorBox("Erro", "É necessario que você insira um DATA valida!");
    }
}

// capturar valor do Telefone
function change_telefone(change_value){
    if(change_value != ""){
        telefone_cliente = change_value;
    }else{
        dialog.showErrorBox("Erro", "É necessario que você insira um TELEFONE valido!");
    }
}

// capturar valor do Email
function change_email(change_value){
    if(change_value != ""){
        email_cliente = change_value;
    }else{
        dialog.showErrorBox("Erro", "É necessario que você insira um EMAIL valido!");
    }
}

// capturar valor da Endereço
function change_endereco(change_value){
    if(change_value != ""){
        endereco_cliente = change_value;
    }else{
        dialog.showErrorBox("Erro", "É necessario que você insira um ENDEREÇO valido!");
    }
}

// função de execusão no banco de dados (call procedure)
function adicionar_novo_cliente () {
    const connect = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "Banco_DS",
    });

    connect.query("call cadastrarCliente('"+nome_cliente+"', "+cpf_cliente+", "+rg_cliente+", '2001-07-12', '"+telefone_cliente+"', '"+email_cliente+"', '"+endereco_cliente+"', "+sexo_cliente+")", (err, res) => {
        if (!err) {
            dialog.showErrorBox("Sucesso!", "Cadastro do(a) "+nome_cliente+" realizado com sucesso!");
            window.location.reload();
        }else{
            dialog.showErrorBox("Erro", err);
        };

    });
}