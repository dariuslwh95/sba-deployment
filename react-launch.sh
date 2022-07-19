#!/bin/bash
yum install -y docker
systemctl enable docker
systemctl start docker
yum install -y awslogs
systemctl enable awslogsd 
systemctl start awslogsd
docker run -d --log-driver=awslogs --log-opt awslogs-region=ap-south-1 --log-opt awslogs-group=lambda --log-opt awslogs-create-group=true -p 80:3000 --env REACT_APP_API_URL=http://${api_endpoint}/ kushagratandon12/sba_frontend:nonginx


