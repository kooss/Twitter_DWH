import tweepy
import sys
from db_connector import db_connector
from twitter_ETL_connector import Twitter_ETL_Connector
import os

config_filename = 'settings.cfg'

etl_connector = Twitter_ETL_Connector(config_filename)

def fatal(*message):
  print '[ERROR]', message
  print 'Aborting...'
  sys.exit(1)

try:
  if etl_connector.read_config_file():
    pass
  elif etl_connector.write_config_file():
    fatal('Config file has been created. Please enter connection',\
      ' information inside ', config_filename)
  else:
    fatal('Exceptional condition: configuration file ', config_filename,\
      'could not be read, but also could not be written to')
except ConfigParser.NoSectionError as e:
  fatal('One or more sections in the config file are missing')

'Config file read'

if not etl_connector.connect():
  'Authorization key not yet set'
  try:
    authorization_url = etl_connector.get_authorization_url()
  except tweepy.TweepError:
    fatal('Failed to get request token')

  print 'please go to this url :', authorization_url 
  verifier = raw_input('Enter the PIN you are given at the above url : ')
  print 'you entered PIN :', verifier
  
  if not etl_connector.get_access_token(verifier):
    fatal('Failed to get access token')
 
  if not etl_connector.write_config_file():
    fatal('Config file could not be written')

print 'access token : key :', etl_connector.auth.access_token.key,\
  ', secret :', etl_connector.auth.access_token.secret

'Verbinden met Twitter'
api_connector = tweepy.API(etl_connector.auth)

'Verbinden met database'
db_connector = db_connector(
  etl_connector.db_conn_info['db_host']
  , etl_connector.db_conn_info['db_login']
  , etl_connector.db_conn_info['db_password']
  , etl_connector.db_conn_info['db_defaultdb']
)

laatste_id = db_connector.laatste_status_id()
print 'Laatste id voor uitvoer:', laatste_id

'uitlezen'
home_timeline = api_connector.home_timeline(since_id = db_connector.laatste_status_id(), count = 1)

'Wegschrijven'
for status in home_timeline:
  db_connector.insert_status(status)

laatste_id = db_connector.laatste_status_id()
print 'Laatste id na uitvoer:', laatste_id
