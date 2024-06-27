const express = require('express');
const app = express();
const path = require('path');

app.get('/download', (req, res) => {
    const file = path.join(__dirname, 'client.ovpn');
    res.download(file);
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`HTTP server is running on port ${port}`);
});
