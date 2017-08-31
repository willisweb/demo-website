#!/bin/bash -ex
yum update -y aws-cfn-bootstrap
yum install -y aws-cli
# Install Apache and PHP
yum install -y httpd24 php70
service httpd start
chkconfig httpd on
# Helper function.
function error_exit
{
  /opt/aws/bin/cfn-signal -e 1 -r "$1" 'https://cloudformation-waitcondition-eu-west-1.s3-eu-west-1.amazonaws.com/arn%3Aaws%3Acloudformation%3Aeu-west-1%3A193552552972%3Astack/CodeDeployBGStack-c03nrgu/b89b9120-8da6-11e7-a95d-500c3cb898d2/WaitHandle?AWSAccessKeyId=AKIAJRBFOG6RPGASDWGA&Expires=1504199689&Signature=K3GSC3EvSLCgSo1xRjbEjJ7ha%2F4%3D'
  exit 1
}
# Install the AWS CodeDeploy Agent.
cd /home/ec2-user/
aws configure set default.s3.signature_version s3v4 || error_exit 'Failed to set aws cli signature to version 4'
aws s3 cp 's3://aws-codedeploy-eu-west-1/latest/codedeploy-agent.noarch.rpm' . --region eu-west-1 || error_exit 'Failed to download AWS CodeDeploy Agent.'
yum -y install codedeploy-agent.noarch.rpm || error_exit 'Failed to install AWS CodeDeploy Agent.' 
# All is well, so signal success.
/opt/aws/bin/cfn-signal -e 0 -r "AWS CodeDeploy Agent setup complete." 'https://cloudformation-waitcondition-eu-west-1.s3-eu-west-1.amazonaws.com/arn%3Aaws%3Acloudformation%3Aeu-west-1%3A193552552972%3Astack/CodeDeployBGStack-c03nrgu/b89b9120-8da6-11e7-a95d-500c3cb898d2/WaitHandle?AWSAccessKeyId=AKIAJRBFOG6RPGASDWGA&Expires=1504199689&Signature=K3GSC3EvSLCgSo1xRjbEjJ7ha%2F4%3D'