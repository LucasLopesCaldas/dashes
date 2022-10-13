#!/bin/bash

if [ $1 ];
then
	mkdir $1
	cd $1
fi

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
npx auto-dash get electron-init/index.html
npx auto-dash get electron-init/main.js

echo $'\n===> Created!\n'
