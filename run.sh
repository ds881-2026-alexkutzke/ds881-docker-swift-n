#!/bin/bash
docker build -t calculadora-api -f rhuan.Dockerfile .
docker stop meu-container-calc 2>/dev/null || true
docker rm meu-container-calc 2>/dev/null || true
docker run -d -p 8080:8080 --name meu-container-calc calculadora-api