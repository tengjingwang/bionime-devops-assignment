# Bionime_assignment by TJWang

tengjingwang@gmail.com

## Notes

You have to provide your own AWS credentials for this to work. The scripts **ASSUMES** the AWS credentials provided had the proper premissions to do so.

This script assumes the use of environment variable, that is `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`

## Tasks

[X] VPC w/ 1 pub and 1 pri subnet
    [X] routing tables
    [ ] test in each instance and make sure they can connect each other
    [X] RDS/MySQL instance in said pri subnet
    [ ] ECS instance in pub subnet
        [ ] Cloudwatch agent + log to cloudwatch

[X] cleanup

### Questions

[ ] How to test
[ ] NAT gateway file to initialize for some reason...
[X] Should deal with IAM and premission crap?
    Nah, too much effort. Other interview to attend to.
