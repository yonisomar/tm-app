terraform {
  backend "s3" {
    bucket       = "threat-modeling-app---tfstate"
    key          = "state"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }

}
