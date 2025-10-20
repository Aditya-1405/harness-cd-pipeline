const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.send('Hello from Harness CD Demo App! Aditya 🚀');
});

app.listen(PORT, () => {
  console.log(`App running on port ${PORT}`);
});