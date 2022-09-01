const { Client } = require("pg");

const config = {
  user: 'postgres', 
  password: 'postgres', 
  host: 'localhost', 
  database: 'fd_test', 
  port: 5432
}

const client = new Client(config);
start();
async function start(){
  await client.connect();
  const res = await client.query(`CREATE TABLE "test_node"("id" SERIAL PRIMARY KEY);`);
  //console.log(res)
  await client.end();
}
