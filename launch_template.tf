resource "aws_launch_template" "epsilon-lt" {
  name_prefix   = "epsilon-lt"
  image_id      = "ami-0cff7528ff583bf9a"
  instance_type = "t3a.micro"
  user_data = base64encode(templatefile("react-launch.sh", { api_endpoint = "${aws_lb.epsilon-lb-api.dns_name}" }))
  key_name = "epsilon-key-pair"
  vpc_security_group_ids = ["${aws_security_group.epsilon-vpc-sg.id}"]
  iam_instance_profile {
    name = "scbcep-cloudwatch-agent"
  }
}

resource "aws_launch_template" "epsilon-lt-apiserver" {
  name_prefix   = "epsilon-lt"
  image_id      = "ami-0cff7528ff583bf9a"
  instance_type = "t3a.micro"
  
user_data = base64encode(templatefile("apiserver-launch.sh", { rds_endpoint = "${aws_db_instance.postgres.endpoint}" }))
  key_name = "epsilon-key-pair"
  vpc_security_group_ids = ["${aws_security_group.epsilon-vpc-sg.id}"]
  iam_instance_profile {
    name = "scbcep-cloudwatch-agent"
  }
}