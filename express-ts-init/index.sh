#!/bin/bash

if [ $1 ];
then
	mkdir $1
	cd $1
fi

echo $'===> Initializing node project\n'
npm init -y
echo $'\n===> Installing GTS\n'
npm i gts --save-dev
echo $'\n===> Initializing GTS project\n'
npx gts init

echo $'\n===> Installing cors\n'
npm i cors
echo $'\n===> Installing dotenv\n'
npm i dotenv --save-dev
echo $'\n===> Installing express\n'
npm i express
echo $'\n===> Installing express-async-errors\n'
npm i express-async-errors
echo $'\n===> Installing http-status-codes\n'
npm i http-status-codes
echo $'\n===> Installing jsonwebtoken\n'
npm i jsonwebtoken
echo $'\n===> Installing mongodb\n'
npm i mongodb
echo $'\n===> Installing zod\n'
npm i zod
echo $'\n===> Installing @types/cors\n'
npm i @types/cors --save-dev
echo $'\n===> Installing @types/express\n'
npm i @types/express --save-dev
echo $'\n===> Installing @types/jsonwebtoken\n'
npm i @types/jsonwebtoken --save-dev
echo $'\n===> Installing @types/node\n'
npm i @types/node --save-dev
echo $'\n===> Installing ts-node-dev\n'
npm i ts-node-dev --save-dev
echo $'\n===> Installing @types/jsonwebtoken\n'
npm i @types/jsonwebtoken --save-dev
