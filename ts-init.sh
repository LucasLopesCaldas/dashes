#!/bin/bash

if [ $1 ];
then
	mkdir $1
	cd $1
fi

echo Initializing node project...
npm init -y
echo Installing GTS...
npm i gts --save-dev
echo Initializing GTS project...
npx gts init