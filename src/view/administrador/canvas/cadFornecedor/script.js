const {dialog} = require('electron').remote;

var nomeForn = '';
var cnpjForn = '';
var cepForn = '';
var telefoneForn = '';
var emailForn = '';
var enderecoForn = '';
var estadoForn = -1;
var cidadeForn = -1;

function verificarDados(){
    if(nomeForn != ''){
        if(cnpjForn != ''){
            if(cepForn != ''){
                if(telefoneForn != ''){
                    if(emailForn != ''){
                        if(enderecoForn != ''){
                            if(estadoForn != -1){
                                if(cidadeForn != -1){

                                    inserirNoBanco(nomeForn, cnpjForn, cepForn, telefoneForn, emailForn, enderecoForn, estadoForn, cidadeForn);

                                }else{
                                    dialog.showErrorBox('Erro','Insira uma Cidade valida!');
                                }
                            }else{
                                dialog.showErrorBox('Erro','Insira um Estado valido!');
                            }
                        }else{
                            dialog.showErrorBox('Erro','Insira um Endereço valido!');
                        }
                    }else{
                        dialog.showErrorBox('Erro','Insira um E-mail valido!');
                    }
                }else{
                    dialog.showErrorBox('Erro','Insira um Telefone valido!');
                }
            }else{
                dialog.showErrorBox('Erro','Insira um CEP valido!');
            }
        }else{
            dialog.showErrorBox('Erro','Insira um CNPJ valido!');
        }
    }else{
        dialog.showErrorBox('Erro','Insira um Nome valido!');
    }
}

function inserirNoBanco (nome, cnpj, cep, telefone, email, endereco, estado, cidade){
    const connect = require('../../../../script_bd/connect');

    //falta adicionar o comando na query
    connect.query('', (err, res) => {
        if(!err){
            finalizarCadastro();
        }else{
            throw err;
        }
    });
}

function finalizarCadastro(){
    window.location.reload();
}