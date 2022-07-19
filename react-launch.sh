#!/bin/bash
yum install -y docker
systemctl enable docker
systemctl start docker
yum install -y awslogs
systemctl enable awslogsd 
systemctl start awslogsd
docker run -d --log-driver=awslogs --log-opt awslogs-region=us-east-2 --log-opt awslogs-group=lambda --log-opt awslogs-create-group=true -p 80:3000 --env REACT_APP_API_URL=http://${api_endpoint}/ kushagratandon12/smart_bank_fronend:nginx

# docker run -d -p 80:3000 --env REACT_APP_API_URL=http:// anshshrivastava/smartbankfrontend:v4
