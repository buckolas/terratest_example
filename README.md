Follow this tutorial:
https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180

Set your AWS credentials using:
export AWS_ACCESS_KEY_ID=<enter key here>
export AWS_SECRET_ACCESS_KEY=<enter secret here>

Get terraform modules:
go get github.com/gruntwork-io/terratest/modules/http-helper
go get github.com/gruntwork-io/terratest/modules/terraform

Execute the tests:
cd tests/
go test