const mysql = require("mysql");
const fs = require("fs");
const path = require("path");

const connection = mysql.createConnection({
 host: "localhost",
 user: "root",
 password: "my_secret_password",
 database: "senior_high_school",
 port: 3307,
});

connection.connect((err) => {
 if (err) throw err;
 console.log("Connected!");

 const dir = "./jsonExport";
 if (!fs.existsSync(dir)) {
  fs.mkdirSync(dir);
 }

 // Get a list of all tables
 connection.query("SHOW TABLES", (err, tables) => {
  if (err) throw err;

  // For each table, run a SELECT * query and write the results to a JSON file
  tables.forEach((table) => {
   const tableName = table[`Tables_in_${connection.config.database}`];
   connection.query(`SELECT * FROM ${tableName}`, (err, results) => {
    if (err) throw err;

    const json_data = JSON.stringify(results, null, 2);
    const filePath = path.join(dir, `${tableName}.json`);
    fs.writeFileSync(filePath, json_data);
    console.log(`JSON data has been written to ${filePath}`);
   });
  });
  connection.end();
 });
});
