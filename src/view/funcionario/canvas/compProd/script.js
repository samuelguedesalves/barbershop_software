const $ = require('../../../../assets/jquery/jquery-3.4.1.min.js');
const mysql = require('mysql');



$(document).ready(function(){
    $('#adicionando_animacao').hide();
    $('#carregando_produto_animacao').hide();
});


// ----------------- COMBOBOX FORNECEDOR
function buscar_fornecedor () {
    const connection = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "Banco_DS",
    });

    connection.query('call buscar_Fornecedor()', (err, result) =>{
        if (err) throw err;
        carregar_combobox_fornecedor(result[0]);

    });
}


//função responsavel por carregar combobox do fornecedor
function carregar_combobox_fornecedor(res){
    
    var combobox_forn = document.getElementById('combobox_forn');
    var tamanho_vetor = res.length;
    
    for(var i = 0; i < tamanho_vetor ; i++){
        
        var option = document.createElement('option');
        option.appendChild(document.createTextNode(res[i].Nome));
        option.setAttribute('value', res[i].Cod );
        combobox_forn.appendChild(option);

    }
    
}
buscar_fornecedor();








// ----------------- COMBOBOX PRODUTO
function buscar_produtos_do_fornecedor (cod_forn) {
    
    const connection = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "Banco_DS",
    });

    connection.query('call buscar_produtos_fornecedor ('+cod_forn+')' , (err, result) =>{
        if (err) throw err;
        carregar_combobox_produto(result[0]);
    });

}

function carregar_combobox_produto (res) {
    var tamanho_vetor = res.length;
    var combobox_prod = document.getElementById('combobox_prod');

    for(var i = 0; i < tamanho_vetor; i++){

        var option = document.createElement('option');
        option.appendChild(document.createTextNode(res[i].nome));
        option.setAttribute('value', res[i].codigo);
        combobox_prod.appendChild(option);

    }
}


// ----------------- ADICIONAR A TABELA

function adicionar_produto () {
    var codigo_de_produto = document.getElementById('combobox_prod').value;
    var quantidade_do_produto = document.getElementById('quant_prod').value;

    $(document).ready(function(){
        $("#adicionando_animacao").fadeIn(800,function(){

            $("#tabela_produto").fadeOut(500, function(){

                window.setTimeout(function(){
                    $("#adicionando_animacao").fadeOut(800, function(){
    
                        buscar_valor_produto(codigo_de_produto, quantidade_do_produto);
    
                    });
                },1500);
                
            });

        });
    });

}

function buscar_valor_produto (cod_prod, prod_quant) {
    const connection = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "Banco_DS",
    });

    connection.query('call buscar_valor_Produto('+cod_prod+')', (err, result) =>{
        if (err) throw err;
        adicionar_a_lista(result[0][0],prod_quant);
    });
}

function adicionar_a_lista (resposta, quantidade) {
    
    var tabela = document.getElementById('tabela_produto');

    var linha  = document.createElement('tr');

    // criar coluna do botão excluir
    var coluna_lixeira = document.createElement('th');
    coluna_lixeira.setAttribute('scope','row');
    //criar botão excluir
    var button_lixeira = document.createElement('button');
    button_lixeira.setAttribute('type','button');
    button_lixeira.setAttribute('class','btn btn-danger');
    //criar icone do botão excluir
    var i_lixeira = document.createElement('i');
    i_lixeira.setAttribute('class','fas fa-trash');
    //montar botão adicionar a tabela
    button_lixeira.appendChild(i_lixeira);
    coluna_lixeira.appendChild(button_lixeira);
    linha.appendChild(coluna_lixeira);

    var coluna_nome = document.createElement('td');
    coluna_nome.appendChild(document.createTextNode(resposta.nome));
    linha.appendChild(coluna_nome);

    var coluna_quantidade = document.createElement('td');
    coluna_quantidade.appendChild(document.createTextNode(quantidade));
    linha.appendChild(coluna_quantidade);

    var coluna_valor = document.createElement('td');
    coluna_valor.setAttribute('class', 'valor_total_item');
    coluna_valor.appendChild(document.createTextNode( (quantidade * resposta.valor) ));
    linha.appendChild(coluna_valor);

    tabela.appendChild(linha);

    atualizar_valor_total(quantidade * resposta.valor);
}



function atualizar_valor_total (acrecimo) {

    $(document).ready(function(){
        $("#tabela_produto").fadeIn(800, function(){
            
            window.setTimeout(function(){

                var valor_total = parseFloat(document.getElementById('contador_total').textContent);    
                
                total_compra = valor_total + acrecimo;
            
                document.getElementById('contador_total').innerHTML = `${total_compra}`;

            },200);

        });
    })

    
    
}

/*
function iniciar_compra (){
    const connection = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "Banco_DS",
    });

    connection.query('call comprar_produto()', (err, result) =>{
        if (err) throw err;
        
        escrever_codigo_compra(result[0][0]);
    });
}


function escrever_codigo_compra(res){
    
    document.getElementById("codigo_compra").innerHTML = `${res.resposta}`;
}


iniciar_compra();
*/

function consultar_numero_compra (){
    const connection = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "Banco_DS",
    });

    connection.query('call buscar_codigo_compra()', (erro, result) => {
        if (erro) throw erro;
        console.log(result);
    });
}

consultar_numero_compra();