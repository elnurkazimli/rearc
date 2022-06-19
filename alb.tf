resource "aws_lb" "rearc" {
  name               = "rearc-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = []
  subnets            = ["10.0.1.0/24", "10.0.2.0/24",]

  enable_deletion_protection = true
}