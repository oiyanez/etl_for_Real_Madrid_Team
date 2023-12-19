# etl_script.py
import configparser
import os

config = configparser.ConfigParser()
config.read('config/config.ini')

redshift_credentials = {
    'dbname': config['Redshift']['dbname'],
    'user': config['Redshift']['user'],
    'password': config['Redshift']['password'],
    'host': config['Redshift']['host'],
    'port': int(config['Redshift']['port'])
}

s3_credentials = {
    'aws_access_key_id': config['AWS']['aws_access_key_id'],
    'aws_secret_access_key': config['AWS']['aws_secret_access_key']
}