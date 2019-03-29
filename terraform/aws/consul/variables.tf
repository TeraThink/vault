# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY
# AWS_DEFAULT_REGION

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "ami_id" {
  description = "The ID of the AMI to run in the cluster. This should be an AMI built from the Packer template under examples/consul-ami/consul.json. To keep this example simple, we run the same AMI on both server and client nodes, but in real-world usage, your client nodes would also run your apps. If the default value is used, Terraform will look up the latest AMI build automatically."
#  default     = "ami-7eb2a716"
#  default    = "ami-034cb3fbaf12e75c1"
  #Terathink AMI Id
  default    = "ami-0ec3600483abd26e0"

}

variable "cluster_name" {
  description = "What to name the Consul cluster and all of its associated resources"
  default     = "consul"
}

variable "server_ui_required" {
  description = "What is flag for server ui, true or false "
  default     = "false"
}

variable "server_or_agent" {
  description = "What is the node, is it server or agent, true or false "
  default     = "false"
}


variable "num_servers" {
  description = "The number of Consul server nodes to deploy. We strongly recommend using 3 or 5."
  default     = 2
}

variable "consul_binary_download_url" {
  description = "The consul binary download URL"
  default     = "https://releases.hashicorp.com/consul/1.4.4/consul_1.4.4_linux_amd64.zip"
}


variable "num_clients" {
  description = "The number of Consul client nodes to deploy. You typically run the Consul client alongside your apps, so set this value to however many Instances make sense for your app code."
  default     = 4
}

variable "cluster_tag_key" {
  description = "The tag the EC2 Instances will look for to automatically discover each other and form a cluster."
  default     = "consul-servers"
}

variable "ssh_key_name" {
  description = "The name of an EC2 Key Pair that can be used to SSH to the EC2 Instances in this cluster. Set to an empty string to not associate a Key Pair."
  default     = "vault_test"
}

variable "vpc_id" {
  description = "The ID of the VPC in which the nodes will be deployed.  Uses default VPC if not supplied."
  default     = "vpc-53f91529"
}

variable "spot_price" {
  description = "The maximum hourly price to pay for EC2 Spot Instances."
  default     = ""
}
variable "subnets" {
    default = "subnet-762f8a2a"
    description = "list of subnets to launch Vault within"
}
