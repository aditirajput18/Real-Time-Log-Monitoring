#!/bin/bash
# Run inside lambda folder
rm -rf package
mkdir package
pip install -r requirements.txt -t ./package
cd package
zip -r ../package.zip .
cd ..
zip -g package.zip lambda_function.py
