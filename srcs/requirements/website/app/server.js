'use strict';

const express = require('express');
const path = require('path');

// Constants
const PORT = 3000;
const HOST = '0.0.0.0';

// App
const app = express();
app.use(express.static('public'));
app.use('/static', express.static(__dirname + '/images'));

app.get('/', (req, res) => {
    // Use index.html
    res.sendFile(path.join(__dirname, './index.html'));
});

app.get('/data/data.json',function(req,res){
    res.sendFile(path.join(__dirname + '/data/data.json'));
});

app.get('/stylesheets/style.css',function(req,res){
    res.sendFile(path.join(__dirname + '/stylesheets/style.css'));
});

app.get('/stylesheets/compiled.css',function(req,res){
    res.sendFile(path.join(__dirname + '/stylesheets/compiled.css'));
});

app.get('/js/render.js',function(req,res){
    res.sendFile(path.join(__dirname + '/js/render.js'));
});

app.listen(PORT, HOST, () => {
    console.log(`Running on http://${HOST}:${PORT}`);
});