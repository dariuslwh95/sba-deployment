resource "aws_launch_template" "epsilon-lt" {
  name_prefix   = "epsilon-lt"
  image_id      = "ami-0cff7528ff583bf9a"
  instance_type = "t3a.micro"
  user_data = filebase64("react-launch.sh")
  key_name = "epsilon-key-pair"

}