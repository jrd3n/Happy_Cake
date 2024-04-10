#!/bin/bash

# Start Nginx in the background
service nginx start

# Start your Flask application in the foreground
python3 /happy_cake/app.py
