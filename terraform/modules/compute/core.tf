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

  user_data = <<-EOF
        #!/bin/bash
        # apt-get -y update
        # apt-get install build-essential checkinstall
        # apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev

        yum -y update
      	yum install epel-release
        echo "Hello, Ubertas" > index.html
        yum -y install python-pip python-dev curl git net-tools
        git clone https://github.com/abdelhegazi/basic-flask-python.git /app/
        /usr/bin/sh /app/app.py &
        EOF

  tags {
    Name           = "app_utas_instance_${count.index}"
    ansible_filter = "app_utas_${count.index}"
  }
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
