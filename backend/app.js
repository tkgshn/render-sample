const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// API endpoint
app.get('/api/hello', (req, res) => {
  res.json({ message: 'Hello from the backend!' });
});

// Serve static files from the React app
app.use(express.static(path.join(__dirname, 'public')));

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
