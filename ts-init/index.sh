#!/bin/bash

if [ $1 ];
then
	mkdir $1
	cd $1
fi

echo $'===> Initializing node project\n'
npm init -y
echo $'===> Installing GTS\n'
npm i gts --save-dev
echo $'\n===> Initializing GTS project\n'
npx gts init
