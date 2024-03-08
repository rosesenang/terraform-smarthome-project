
resource "aws_placement_group" "projectplacement" {
  name     = var.placementgroupname
  strategy = "spread"
}

resource "aws_autoscaling_group" "all" {
  desired_capacity   = var.desired
  max_size           = var.max
  min_size           = var.min
  placement_group    = aws_placement_group.projectplacement.id
  launch_template {
    id = var.lt_id
  }
  vpc_zone_identifier = var.vpc_zone_identify
}

resource "aws_autoscaling_attachment" "all" {
  autoscaling_group_name = aws_autoscaling_group.all.id
  lb_target_group_arn = var.loadbalancer_target_group_arn
}