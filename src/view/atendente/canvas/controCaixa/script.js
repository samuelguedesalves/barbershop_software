

function capiturarHorario(){
    var horario = new Date();

    var hora_bruta = horario.getHours();
    var minuto_bruto = horario.getMinutes();
    
    var hora = hora_bruta+' : '+minuto_bruto;

    return hora;
}

function abrirOuFecharCaixa () {
    var horario = capiturarHorario();
    var situacao = document.getElementById('situacao_caixa').textContent;
    
    console.log(situacao, horario);
    //gravarNoBanco(situacao, horario);
}

function gravarNoBanco(situacao, hora){
    const connection = require('../../../../script_bd/connect');

    if(situacao == 'Aberto'){
        //é necessario adicionar o query de fechamento de caixa
        connection.query('', (err, res)=>{
            if(!err){
                window.location.reload();
            }else{
                throw err;
            }
        });
    }else{
        //é necessario adicionar o query de abertura de caixa
        connection.query('', (err, res)=>{
            if(!err){
                window.location.reload();
            }else{
                throw err;
            }
        });
    }

}