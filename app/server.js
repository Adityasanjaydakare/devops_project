const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send("🚀 DevSecOps Pipeline Deployed Successfully on Kubernetes!");
});

app.listen(3000, () => {
  console.log("App running on port 3000");
});
