const {dialog} = require('electron').remote;
const mysql = require('mysql');

var nome_usuario = '';
var tipo_usuario = -1;
var senha_usuario = '';
var senha_confirmacao_usuario = '';

function validar_dados(){
    if(nome_usuario != ''){
        if(tipo_usuario != -1){
            if(senha_usuario != ''){
                if(senha_confirmacao_usuario != ''){
                    if(senha_usuario == senha_confirmacao_usuario){
                        
                        gravarNoBanco(nome_usuario, tipo_usuario, senha_usuario);
                        
                    }else{
                        dialog.showErrorBox('Erro', 'A senha não está igual!');                        
                    }
                }else{
                    dialog.showErrorBox('Erro', 'É necessario que confirme a senha!');
                }
            }else{
                dialog.showErrorBox('Erro', 'É necessario que insira uma senha de usuario valida!');
            }
        }else{
            dialog.showErrorBox('Erro', 'É necessario que insira um tipo de usuario valido!');            
        }
    }else{
        dialog.showErrorBox('Erro', 'É necessario que insira um nome de usuario valido!');
    }
}


function gravarNoBanco(nome, tipo, senha){
    const connection = require('../../../../script_bd/connect');

    //falta colocar a query
    connection.query('', (err, res)=>{
        if(!err){
            finalizar();
        }else{
            throw err;
        }
    });
}

function finalizar(){
    window.location.reload();
}