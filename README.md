Read through [the Terratest tutorial](https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180), making sure to install Terraform and Go in advance.

## AWS ##
In an AWS account, create a user and export new AWS credentials from within the console. Set your AWS credentials locallys by executing these commands:
```
export AWS_ACCESS_KEY_ID=<enter key here>
export AWS_SECRET_ACCESS_KEY=<enter secret here>
```

## Go ##
Get terraform modules that will be executed by the Go tests:
```
go get github.com/gruntwork-io/terratest/modules/http-helper
go get github.com/gruntwork-io/terratest/modules/terraform
```

## Testing ##
Execute the tests:
```
cd tests/
go test
```

## Infrastructure Test Ideas ##
1. Test server responds on a specific port
2. Test ports open/closed
  - ssh
3. Check status of EC2 instance
4. SSL certs being presented
  - Expiration date
5. Resources tagged as expected and following name formats
6. VPC boundaries established and enforced
7. Subnets private vs public
8. S3 bucket policies