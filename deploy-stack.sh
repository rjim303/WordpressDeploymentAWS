#!/bin/bash

aws cloudformation deploy --stack-name Wordpressdeployment --template-file ./main.yml
