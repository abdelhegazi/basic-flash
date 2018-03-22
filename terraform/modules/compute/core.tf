#/* Application Instance */#
resource "aws_instance" "app_instances" {
  count                  = "${var.mod_app_instances_count}"
  ami                    = "${var.mod_ami}"
  instance_type          = "${var.mod_instance_type}"
  availability_zone      = "${element(split(",", var.mod_azs), count.index)}"
  key_name               = "${var.mod_key_name}"
  vpc_security_group_ids = ["${aws_security_group.app_instance_sg1.id}"]
  subnet_id              = "${element(split(",", var.mod_pubsn_ids), count.index)}"
  monitoring             = true
  user_data              = "${data.template_file.user_data.rendered}"
  # user_data = <<-EOF
  #             #!/bin/sh
  #             yum -y update
  #             yum -y install epel-release
  #             echo "Hello, Utas" > index.html
  #             yum -y install python-pip python-dev curl git net-tools
  #             pip install Flask
  #             pip install --upgrade pip
  #             git clone https://github.com/abdelhegazi/basic-flask-python.git /app/
  #             nohub /usr/bin/python /app/app/app.py &
  #             EOF

  tags {
    Name           = "app_utas_instance_${count.index}"
    ansible_filter = "app_utas_${count.index}"
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/userdata_config.tpl")}"
}


// Allocating eip to the openvpn server
resource "aws_eip" "app_instance_eip" {
  vpc = "true"
}

resource "aws_eip_association" "app_eip_assoc" {
  instance_id      = "${aws_instance.app_instances.id}"
  allocation_id    = "${aws_eip.app_instance_eip.id}"
}


#/* App Security Group */#
resource "aws_security_group" "app_instance_sg1" {
  vpc_id      = "${var.mod_vpc_id}"
  name        = "${var.mod_app_sg1_name}mod_sg1_name"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags {
    Name           = "app_utas_sg1"
    ansible_filter = "app_utas_sg1"
  }
}
