import tweepy
import ConfigParser

class Twitter_ETL_Connector(object):
  def __init__(self, config_filename):
    self.twitter_conn_info = {
      'consumer_token': ''
      , 'consumer_secret': ''
      , 'token_filepath': './twitter_tokens'
    }
  
    self.db_conn_info = {
      'db_host': 'localhost'
      , 'db_login': ''
      , 'db_password': ''
      , 'db_defaultdb': ''
    }

    self.twitter_auth_info = {
      'auth_key': ''
      , 'auth_secret': ''
    }

    self.config = ConfigParser.ConfigParser()
    self.config_sections = {
        'Database': self.db_conn_info
        , 'Twitter API': self.twitter_conn_info 
        , 'Twitter Authentication (do not alter manually!)': 
          self.twitter_auth_info
    }
    self.config_filename = config_filename

  def read_config_file(self):
    try:
      settingsfp = open(self.config_filename, 'r')
      self.config.readfp(settingsfp)
      settingsfp.close()
      for section in self.config_sections:
        settings = self.config_sections[section]
        for key in settings:
          settings[key] = self.config.get(section, key, 0)
      return True
    except IOError as e:
      return False

  def write_config_file(self):
    for section in self.config_sections:
      settings = self.config_sections[section]
      if not self.config.has_section(section):
        self.config.add_section(section)
      for key in settings:
        print 'Setting section', section, 'key', key, 'value', settings[key]
        self.config.set(section, key, settings[key])
    try:
      print 'Opening', self.config_filename
      configfile = open(self.config_filename, 'w')
      self.config.write(configfile)
      configfile.close()
      return True
    except IOError as e:
      return False

  def connect(self):
    self.auth = tweepy.OAuthHandler(
      self.twitter_conn_info['consumer_token'], 
      self.twitter_conn_info['consumer_secret'])
    if self.twitter_auth_info['auth_key'] == '':
      return False
    else:
      self.auth.set_access_token(
        self.twitter_auth_info['auth_key']
        , self.twitter_auth_info['auth_secret'])
      return True

  def get_authorization_url(self):
    redirect_url = self.auth.get_authorization_url()
    return redirect_url

  def get_access_token(self, verifier):
    try:
      self.auth.get_access_token(verifier)
      self.twitter_auth_info['auth_key'] = self.auth.access_token.key
      self.twitter_auth_info['auth_secret'] = self.auth.access_token.secret
      return True
    except tweepy.TweepError:
      return False
