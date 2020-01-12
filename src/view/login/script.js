const $ = require('../../assets/jquery/jquery-3.4.1.min.js');
const { dialog } = require('electron').remote;

$(document).ready(function(){
    $("#animacao_login").hide();
});

function capturar_input () {
    var nome = document.querySelector('#nome_usuario').value;
    var senha = document.querySelector('#senha_usuario').value;

    if(nome != ''){
        if(senha != ''){
            verificar_acesso(nome, senha);
        }else{
            dialog.showErrorBox('Senha Invalida!', 'Você deve inserir uma senha.');
        }
    }else{
        dialog.showErrorBox('Usuário Invalido!', 'Você deve inserir um usuário.');
    }

}

function verificar_acesso (nome, senha) {
    var mysql = require('mysql');

    var connect = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: 'root',
        database: 'banco_ds'
    });

    connect.query('call verificar_Usuario("'+nome+'","'+senha+'")', (err, res) => {
        if (err) throw err;
        console.log(res[0][0].resposta)
        verificar_tipo_usuario(res[0][0].resposta);
    })
}

function verificar_tipo_usuario(res){

    if (res == 'Programador'){
        const caminho = '../funcionario/index.html';
        redirecionamento(caminho)
    } else {
        if (res == 'Adiministrador') {
            const caminho = '../administrador/index.html';
            redirecionamento(caminho);
        } else {
            if (res == 'Funcionário') {
                const caminho = '../funcionario/index.html';
                redirecionamento(caminho);
            } else {
                if (res == 'Caixa') {
                    const caminho = '../atendente/index.html';
                    redirecionamento(caminho);
                } else {
                    dialog.showErrorBox('Erro', ''+res+'');
                }
          }
      }
    }
}

function redirecionamento(caminho){
    $(document).ready(function(){
        $("#form_de_login").fadeOut(function(){
            window.setTimeout(function(){
                $("#animacao_login").fadeIn(function(){
                    window.setTimeout(function(){
                        $("#animacao_login").fadeOut(function(){
                            window.setTimeout(function(){
                                window.location.assign(caminho);
                            }, 500);
                        })
                    }, 500);
                })
            }, 500);
        })
    })
}