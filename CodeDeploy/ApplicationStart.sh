#!/bin/bash
#Program Name: ApplicationStart.sh
#Author name: Wenhao Fang
# Date Created: Jan 10th 2024
# Date Created: Jan 10th 2024
# Repo: AWS_EC2_ECDjangoDeploy
# Project: EC_Django_Deployer
# Description of the script:
#   script of ApplicationStart
#   as user ubuntu

# create ApplicationStart log/
sudo rm -rf /home/ubuntu/Deploy_ApplicationStart.log
sudo touch /home/ubuntu/Deploy_ApplicationStart.log

# start logging
sudo echo -e "$(date +'%Y-%m-%d %H:%M:%S') ApplicationStart starting..." >>/home/ubuntu/Deploy_ApplicationStart.log

###########################################################
## Django Migrate
###########################################################
# activate env
source /home/ubuntu/env/bin/activate

###########################################################
## Django Migrate
###########################################################
# django make migrations
python3 manage.py makemigrations &&
    sudo echo -e "$(date +'%Y-%m-%d %H:%M:%S') Django - make migrations." >>/home/ubuntu/Deploy_ApplicationStart.log ||
    sudo echo -e "$(date +'%Y-%m-%d %H:%M:%S') Fail: Django - make migrations." >>/home/ubuntu/Deploy_ApplicationStart.log

# django migrate
python3 manage.py migrate &&
    sudo echo -e "$(date +'%Y-%m-%d %H:%M:%S') Django - migrate." >>/home/ubuntu/Deploy_ApplicationStart.log ||
    sudo echo -e "$(date +'%Y-%m-%d %H:%M:%S') Fail: Django - migrate." >>/home/ubuntu/Deploy_ApplicationStart.log

# collect static files
python3 manage.py collectstatic &&
    sudo echo -e "$(date +'%Y-%m-%d %H:%M:%S') Django - static files." >>/home/ubuntu/Deploy_ApplicationStart.log ||
    sudo echo -e "$(date +'%Y-%m-%d %H:%M:%S') Fail: Django - static files." >>/home/ubuntu/Deploy_ApplicationStart.log

deactivate # deactivate venv

###########################################################
## restart services
###########################################################
# restart gunicorn
sudo service gunicorn restart &&
    sudo echo -e "$(date +'%Y-%m-%d %H:%M:%S') Gunicorn - restart service." >>/home/ubuntu/Deploy_ApplicationStart.log ||
    sudo echo -e "$(date +'%Y-%m-%d %H:%M:%S') Fail: Gunicorn - restart service." >>/home/ubuntu/Deploy_ApplicationStart.log

# restart nginx
sudo service nginx restart &&
    sudo echo -e "$(date +'%Y-%m-%d %H:%M:%S') Nginx - restart service." >>/home/ubuntu/Deploy_ApplicationStart.log ||
    sudo echo -e "$(date +'%Y-%m-%d %H:%M:%S') Fail: Nginx - restart service." >>/home/ubuntu/Deploy_ApplicationStart.log

# complate logging
sudo echo -e "$(date +'%Y-%m-%d %H:%M:%S') ApplicationStart completed." >>/home/ubuntu/Deploy_ApplicationStart.log