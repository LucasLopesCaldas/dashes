#!/bin/bash

if [ $1 ];
then
	mkdir $1
	cd $1
fi


INDEX='`<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <!-- https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP -->
    <meta
      http-equiv="Content-Security-Policy"
    />
    <title>Hello World!</title>
  </head>
  <body>
    <h1>Hello World!</h1>
  </body>
</html>
`'

MAIN='`const { app, BrowserWindow } = require("electron");
const createWindow = () => {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
  });

  win.loadFile("index.html");
};
app.whenReady().then(() => {
  createWindow();

  app.on("activate", () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});
app.on("window-all-closed", () => {
  if (process.platform !== "darwin") app.quit();
});
`'

echo $'===> Initialize node project\n'
npm init -y

node -e "
	const pkg=require('./package.json');
	pkg.main = 'main.js';
	pkg.author = 'Dev';
	pkg.description = 'My electron app';
  pkg.scripts.start = 'electron .';
	require('fs').writeFileSync('package.json', JSON.stringify(pkg, null, 2));
"

echo $'\n===> Installing electron\n'
npm install --save-dev electron

echo $'\n===> Creating project files\n'
node -e "
require('fs').writeFileSync('index.html', $INDEX);

require('fs').writeFileSync('main.js', $MAIN);
"
echo $'\n===> Created!\n'
