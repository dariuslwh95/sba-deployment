resource "aws_launch_template" "lambda-lt" {
  name_prefix   = "lambda-lt"
  image_id      = "ami-0dc633995664f082b"
  instance_type = "t3a.small"
  user_data = base64encode(templatefile("react-launch.sh", { api_endpoint = "${aws_lb.lambda-lb-api.dns_name}" }))
  key_name = "lambda-key-pair"
  vpc_security_group_ids = ["${aws_security_group.lambda-vpc-sg.id}"]
  iam_instance_profile {
    name = "scbcep-cloudwatch-agent"
  }
}

resource "aws_launch_template" "lambda-lt-apiserver" {
  name_prefix   = "lambda-lt-api"
  image_id      = "ami-0dc633995664f082b"
  instance_type = "t3a.small"
  
user_data = base64encode(templatefile("apiserver-launch.sh", { rds_endpoint = "${aws_db_instance.postgres.endpoint}" }))
  key_name = "lambda-key-pair"
  vpc_security_group_ids = ["${aws_security_group.lambda-vpc-sg.id}"]
  iam_instance_profile {
    name = "scbcep-cloudwatch-agent"
  }
}