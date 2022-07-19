#!/bin/bash
yum install -y docker
systemctl enable docker
systemctl start docker
yum install -y awslogs
systemctl enable awslogsd 
systemctl start awslogsd
docker run -d --log-driver=awslogs --log-opt awslogs-region=ap-south-1 --log-opt awslogs-group=lambda --log-opt awslogs-create-group=true -p 80:8080 --env spring.datasource.username=postgres --env spring.datasource.password=postgres --env spring.datasource.url=jdbc:postgresql://${rds_endpoint}/smartbankapp brainupgrade/sba-apiserver:usage

# docker run -d -p 80:3000 --env REACT_APP_API_URL=http:// anshshrivastava/smartbankfrontend:v4
# docker run -d --log-driver=awslogs --log-opt awslogs-region=ap-south-1 --log-opt awslogs-group=lambda-apiserver --log-opt awslogs-create-group=true -p 8080:8080 --env spring.datasource.username=postgres --env spring.datasource.password=postgres --env spring.datasource.url=jdbc:postgresql://ansh-smartbank-db.cahc0qobfhru.ap-south-1.rds.amazonaws.com:5432/smartbankapp anshshrivastava/smartbankapi:v5