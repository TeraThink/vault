//-------------------------------------------------------------------
// Vault settings
//-------------------------------------------------------------------

variable "access_key"{
  default = "AKIAI3OHWYK6P6DRMBDA"
  description = "AWS Access Key"
}

variable "secret_key"{
  default = "1pkntD/1FQ0UupoQmoycB4qo8LQS+bNCWsffHjNC"
  description = "AWS secret Key"
}

variable "download-url" {
    default = "https://releases.hashicorp.com/vault"
    description = "URL to download Vault"
}

variable "vaultzipfile" {
  default = "vault_1.1.0_linux_amd64.zip"
  description = "Vault Archive`"
}

variable "vaultversion" {
  default = "1.1.0"
  description = "Vault version`"
}


#variable "config" {
#    description = "Configuration (text) for Vault"
#}

# variable "vaultservice" {
#    description = "Configuration (text) for VaultService"
# }

variable "extra-install" {
    default = ""
    description = "Extra commands to run in the install script"
}

//-------------------------------------------------------------------
// AWS settings
//-------------------------------------------------------------------

variable "ami" {
    // ubuntu ami
    #default = "ami-7eb2a716"
    default = "ami-0ec3600483abd26e0"
    // Centos ami
    //default = "ami-0015b9ef68c77328d"
    // Terathink Centos 7.5 AMI ami-0ec3600483abd26e0
    description = "AMI for Vault instances"
}

variable "availability-zones" {
    default = "us-east-1a,us-east-1b"
    description = "Availability zones for launching the Vault instances"
}

variable "elb-health-check" {
    default = "HTTP:8200/v1/sys/health"
    description = "Health check for Vault servers"
}

variable "instance_type" {
  // ubuntu default size
    # default = "m3.medium"
    default = "t2.micro"
    // Centos default size
    //default = "m4.large"
    description = "Instance type for Vault instances"
}

variable "key-name" {
    default = "vault_test"
  //  default = "newVaultDemo"
    description = "SSH key name for Vault instances"
}

variable "nodes" {
    default = "1"
    description = "number of Vault instances"
}
//subnet-015cba378ae588b52 --TTDEMO-DEV-Private APP-us-east-1a
//subnet-08e18e612cb89ed97 -- TTDEMO-DEV-Private APP-us-east-1b
//subnet-015cba378ae588b52,subnet-08e18e612cb89ed97
//subnet-762f8a2a
variable "subnets" {
    default = "subnet-762f8a2a"
    description = "list of subnets to launch Vault within"
}
// vpc-0f8a9c8d263059691
//vpc-53f91529
variable "vpc-id" {
    default = "vpc-53f91529"
    description = "VPC ID"
}

//subnet-015cba378ae588b52
//subnet-095ed9b161d94829d
//subnet-06b9c80844f5fa1e5
