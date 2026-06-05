resource "aws_db_subnet_group" "main" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags       = { Name = "${var.name}-subnet-group" }
}

resource "aws_security_group" "rds" {
  name        = "${var.name}-rds-sg"
  description = "RDS security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.name}-rds-sg" }
}

resource "aws_db_instance" "main" {
  identifier        = var.name
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = var.instance_class
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password
  port              = 3306

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  skip_final_snapshot = true
  multi_az            = false
  storage_type        = "gp2"
  allocated_storage   = 20

  tags = { Name = var.name, Environment = var.environment }
}
