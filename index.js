const { Client } = require("pg");

const config = {
  user: 'postgres', 
  password: 'postgres', 
  host: 'localhost', 
  database: 'fd_test', 
  port: 5432
}
const users = [{
  firstName:"Jan1",
  lastName:"Janskyi",
  email:"qwerty1@qwe.com",
  isMale: true,
  birthday:'1971-06-28',
  height:1.78
},{
  firstName:"Jan2",
  lastName:"Janskyi",
  email:"qwerty2@qwe.com",
  isMale: true,
  birthday:'1971-06-28',
  height:1.78
}]

function mapUsers(users){
  return users
          .map((user)=>`('${user.firstName}', '${user.lastName}', '${user.email}', '${user.isMale}', '${user.birthday}','${user.height}')`)
          .join(',')
}

const client = new Client(config);
start();

async function start(){
  await client.connect();
  const res = await client.query(`
  INSERT INTO "users"("firstName","lastName","email","isMale","birthday","height")
  VALUES ${mapUsers(users)};
  `);
  await client.end();
}
