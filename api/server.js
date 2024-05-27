const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3000;

const pool = new Pool({
  connectionString: process.env.DATABASE_URL
});

app.get('/', async (req, res) => {
  const result = await pool.query('SELECT * FROM test_table');
  res.send(result.rows);
});

app.listen(port, () => {
  console.log(`API listening at http://localhost:${port}`);
});
