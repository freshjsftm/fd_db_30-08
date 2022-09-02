const { Client } = require("pg");
const axios = require("axios");
const http = axios.create({
  baseURL: 'https://randomuser.me/api/'
});
const loadUser = async()=>{
  const {data:{results}} = await http.get('?results=100&seed=fd2022&nat=us,dk,fr,gb&page=3');
  return results;
}
const config = {
  user: "postgres",
  password: "postgres",
  host: "localhost",
  database: "fd_test",
  port: 5432,
};
function mapUsers(users) {
  return users
    .map(
      ({name:{first, last}, email, gender, dob:{date}}) =>
        `('${first}', '${last}', '${email}', '${gender==='male'}', '${date}','${(Math.random()+1.2).toFixed(2)}')`
    )
    .join(",");
}
const client = new Client(config);
start();
async function start() {
  await client.connect();
  const users = await loadUser();
  const res = await client.query(`
  INSERT INTO "users"("firstName","lastName","email","isMale","birthday","height")
  VALUES ${mapUsers(users)};
  `);
  await client.end();
}
