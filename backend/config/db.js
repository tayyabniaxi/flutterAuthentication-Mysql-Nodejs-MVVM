const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '', // Enter your MySQL password
  database: 'crud'
});

connection.connect((err) => {
  if (err) throw err;
  console.log('Connected to MySQL Database');
});

module.exports = connection;