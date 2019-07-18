provider "aws" {
  region     = "us-east-1"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

module "gitlab" {
  source = "../../module/single-node-omnibus/"
  vpc_id = "${var.vpc_id}"
  namespace = "eg"
  name = "app"
  stage = "test"
  attributes = ["xyz"]
  private_subnet_id = "${var.private_subnet_id}"
  public_subnet_id = "${var.public_subnet_id}"
  s3_buckets = ["abc","bcd"]
  dns_name = "${var.dns_name}"
  domain_name = "${var.domain_name}"
  zone_id = "${var.zone_id}"
  private_key_extension = ".pem"
  public_key_extension = ".pub"
  public_key_path = "./secrets"
  gitlab_application_ami = "${var.gitlab_ami}"

}