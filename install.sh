#!/bin/bash

# Check if all needed commands are there
which python3 || ( echo 'python3 command does not exist' && exit 1 )
which virtualenv || ( echo 'virtualenv command does not exist' && exit 1 )

if [ ! -f 'django/manage.py' ]; then
    echo './django/manage.py file does not exist.'
    exit 1
fi

cd django

if [[ ! -d 'venv' ]]; then
    virtualenv venv
fi

if [[ -z "$VIRTUAL_ENV" ]]; then
    source venv/bin/activate
fi

pip install -r ../requirements.txt && \
python manage.py migrate

echo 'Do you want to create a superuser [yes/no]'
read ANSWER
if [[ "$ANSWER" -eq 'yes' ]]; then
    python manage.py createsuperuser
fi

python manage.py runserver

exit
