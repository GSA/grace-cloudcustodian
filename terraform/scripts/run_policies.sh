#! /bin/sh
set -x

pip3 install c7n
for policy in policies/*
do
  custodian run -s out -c $policy
done
