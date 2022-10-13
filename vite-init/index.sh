#!/bin/bash

if [ $1 ];
then
	mkdir $1
	cd $1
fi

echo $'===> Initializing vite project\n'
npm create vite@latest .
  
if test -f package.json;
then
  echo $'===> Installing dependecies\n'
  npm i
fi
