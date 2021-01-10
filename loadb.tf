resource "aws_elb" "alb" {
  name            = var.elb_name
  subnets         = [var.subpubid,var.subpubid1]
  security_groups = [var.sg_id]
  internal        = var.elb_internal

  dynamic "listener"{
    for_each = [var.listner_count]
    content {
      instance_port     = var.instance_port
      instance_protocol = var.instance_protocol
      lb_port           = var.lb_port 
      lb_protocol       = var.lb_protocol
    }
  }
   health_check {
     target              = var.target
     interval            = var.interval
     healthy_threshold   = var.healthy_threshold
     unhealthy_threshold = var.unhealthy_threshold
     timeout             = var.timeout
  }

  tags = {
    Name  = "elb"
  }

}

resource "aws_elb_attachment" "baz" {
  elb      = var.elb_id
  instance = var.pvtinstance_id
}
