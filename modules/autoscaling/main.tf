resource "aws_placement_group" "projectplacement" {
  name     = var.placementgroupname
  strategy = "spread"
}

resource "aws_autoscaling_group" "all" {
  # availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  desired_capacity   = var.desired
  max_size           = var.max
  min_size           = var.min
  placement_group    = aws_placement_group.projectplacement.id
  launch_template {
    id = var.lt_id
  }
  vpc_zone_identifier = var.vpc_zone_identify
}