# Bionime_assignment by TJWang

tengjingwang@gmail.com

## Notes

You have to provide your own AWS credentials for this to work. The scripts **ASSUMES** the AWS credentials provided had the proper premissions to do so.

This script assumes the use of environment variable, that is `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`

## Tasks

[O] VPC w/ 1 pub and 1 pri subnet
    [O] routing tables
    [O] test in each instance and make sure they can connect each other
    [O] RDS/MySQL instance in said pri subnet
    [ ] ECS instance in pub subnet
        [O] get an instance up
            [O] password?
        [ ] Cloudwatch agent + log to cloudwatch
            [ ] Let me see if I can get away w/o using packer
            [ ] iam roles
        [X] careful with security group
            not specified in the assignment
            [O] still gonna set them tho for testing...

### Questions

[X] Should deal with IAM and premission crap?
    Nah, too much effort. Other interview to attend to.
