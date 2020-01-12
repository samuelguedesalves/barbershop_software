const mysql = require('mysql');

module.exports = function conexao (consulta){
    const conection = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "Banco_DS"
    });
}