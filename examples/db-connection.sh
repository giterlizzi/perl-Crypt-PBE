#!/bin/sh

# Access to MySQL/MariaDB database using pkcs5-tool(1)

export PKCS5_PASSWORD="PASSWORD"
export PKCS5_INPUT="IiQyzT6uJ78y7Cq05etsAhi2LWv9IKdqP+mBbLRcieye7zkRNMxBwvJ8cfJNXu74"

# Store the password and or input in Kernel Keyring
# 
#   keyctl(1) mini-HOWTO
#
#   Store new data in user keyring and return the key ID
#       keyctl add user app_secret "PASSWORD" @u
#
#   Display key content
#       keyctl print <ID>
#
# export PKCS5_PASSWORD=$(keyctl print $(keyctl id %user:app_secret))
# export PKCS5_INPUT=$(keyctl print $(keyctl id %user:app_enc_password))

DB_PASSWORD=$(pkcs5-tool --algorithm PBEWithHmacSHA256AndAES_256 --password env:PKCS5_PASSWORD --input env:PKCS5_INPUT --decrypt)
DB_USERNAME=APP_USER
DB_NAME=APP_DB

export MYSQL_PWD=$DB_PASSWORD
echo 'SHOW TABLES' | mysql -u $DB_USERNAME $DB_NAME
