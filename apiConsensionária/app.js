const express = require('express');
const mysql = require('mysql');

const app = express();
const port = 3000;

// Configurações de conexão com o banco de dados MySQL
const connection = mysql.createConnection({
    host: '3000',
    user: 'root',
    password: '',
    database: 'concessionariadb'
});

// Conectar ao banco de dados MySQL
connection.connect((err) => {
    if (err) {
        console.error('Erro ao conectar ao banco de dados:', err);
        return;
    }
    console.log('Conexão bem-sucedida ao banco de dados MySQL');
});

// Rota para exibir o relatório
app.get('/', (req, res) => {
    // Consulta para obter informações das views
    connection.query("SHOW FULL TABLES WHERE TABLE_TYPE LIKE 'VIEW'", (err, rows) => {
        if (err) {
            console.error('Erro ao executar a consulta:', err);
            res.status(500).send('Erro ao buscar informações das views.');
            return;
        }
        // Renderizar o template HTML passando as informações das views
        res.send(renderHTML(rows));
    });
});

// Função para renderizar o template HTML
function renderHTML(views) {
    let html = '<!DOCTYPE html>';
    html += '<html lang="en">';
    html += '<head>';
    html += '<meta charset="UTF-8">';
    html += '<meta name="viewport" content="width=device-width, initial-scale=1.0">';
    html += '<title>Relatório de Views</title>';
    html += '</head>';
    html += '<body>';
    html += '<h1>Relatório de Views</h1>';
    html += '<ul>';
    views.forEach(view => {
        html += '<li>Nome: ' + view.Tables_in_seu_banco_de_dados + '</li>';
        html += '<li>Tipo: VIEW</li><br>';
    });
    html += '</ul>';
    html += '</body>';
    html += '</html>';
    return html;
}

app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
});
