const {dialog} = require('electron').remote;
const $ = require('../../../../assets/jquery/jquery-3.4.1.min.js');
const mysql = require('mysql');


// ----------------- COMBOBOX FORNECEDOR
function buscar_fornecedor () {
    const connection = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "Banco_DS",
    });

    connection.query('call buscar_Fornecedor', (err, result) =>{
        if (err) throw err;
        carregar_combobox_fornecedor(result[0]);
    });
}

function carregar_combobox_fornecedor(res){
    
    var combobox_forn = document.getElementById('combobox_forn');

    var tamanho_vetor = res.length;

    for(var i = 0; i < tamanho_vetor ; i++){

        var option = document.createElement('option');
        option.appendChild(document.createTextNode(res[i].nome));
        option.setAttribute('value', res[i].codigo );
    
        combobox_forn.appendChild(option);
    }

}

buscar_fornecedor();

//CHANGE INPUTS

var nome_produto = "";
var codigo_fornecedor = "";
var valor_compra = "";
var valor_venda = "";

function change_nome(change_value){
    nome_produto = change_value;
    //console.log(change_value);
}

function change_fornecedor(change_value){
    codigo_fornecedor = change_value;
    //console.log(change_value);
}

function change_compra(change_value){
    valor_compra = change_value;
    //console.log(change_value);
}

function change_venda(change_value){
    valor_venda = change_value;
    //console.log(change_value);
}

function cadastrar_novo_produto(){
    if(nome_produto == ""){
        dialog.showErrorBox("Erro","O nome não pode ser Vazio!")
    }else{
        if(codigo_fornecedor == ""){
            dialog.showErrorBox("Erro","Selecione um fornecedor!");
        }else{
            if(valor_compra == ""){
                dialog.showErrorBox("Erro","O valor da COMPRA não pode ser vazio!");
            }else{
                if(valor_venda == ""){
                    dialog.showErrorBox("Erro","O valor da VENDA não pode ser vazio!");
                }else{
                    
                    // cadastrar novo produto no banco de dados
                    const connection = mysql.createConnection({
                        host: "localhost",
                        user: "root",
                        password: "root",
                        database: "banco_ds",
                    });

                    connection.query("call cadastrarProduto('"+nome_produto+"',"+valor_compra+","+valor_venda+","+codigo_fornecedor+")",(err, res)=>{
                        if (err) {
                            dialog.showErrorBox("Erro", err);
                        }else{
                            dialog.showErrorBox("Sucesso!", "Produto Cadaastrado com sucesso!");
                            window.location.reload();
                        }
                    });
                }
            }
        }       
    }
}
