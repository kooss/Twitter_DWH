import MySQLdb
import _mysql_exceptions

class db_connector:
  def __init__(self, hostname, username, password, databasename):
    self.hostname = hostname
    self.username = username
    self.password = password
    self.databasename = databasename
    self.db = MySQLdb.connect(self.hostname, self.username, self.password, self.databasename)

  def laatste_status_id(self):
    cursor = self.db.cursor()
    cursor.execute("SELECT MAX(id) FROM tweet")
    row = cursor.fetchone()
    cursor.close()
    return row[0]

  def user_exists(self, user):
    cursor = self.db.cursor()
    cursor.execute('SELECT COUNT(1) FROM user WHERE id = ' + str(user.id))
    row = cursor.fetchone()
    cursor.close()
    return row[0] > 0

  def insert_user(self, user):
    sql = '''INSERT INTO user (
      id
      , created_at
      , default_profile
      , default_profile_image
      , description
      , favourites_count
      , follow_request_sent
      , followers_count
      , friends_count
      , geo_enabled
      , is_translator
      , lang
      , listed_count
      , location
      , name
      , profile_background_color
      , profile_background_image_url
      , profile_background_image_url_https
      , profile_background_tile
      , profile_image_url
      , profile_image_url_https
      , profile_link_color
      , profile_sidebar_border_color
      , profile_sidebar_fill_color
      , profile_text_color
      , profile_use_background_image
      , protected
      , screen_name
      , show_all_inline_media
      , statuses_count
      , time_zone
      , url
      , utc_offset
      , verified
    ) VALUES (
      %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
    )'''
    arglist = (
      user.id
      , unicode(user.created_at.isoformat())
      , user.default_profile
      , user.default_profile_image
      , unicode(user.description)
      , user.favourites_count
      , user.follow_request_sent
      , user.followers_count
      , user.friends_count
      , user.geo_enabled
      , user.is_translator
      , unicode(user.lang)
      , user.listed_count
      , unicode(user.location)
      , unicode(user.name)
      , unicode(user.profile_background_color)
      , unicode(user.profile_background_image_url)
      , unicode(user.profile_background_image_url_https)
      , user.profile_background_tile
      , unicode(user.profile_image_url)
      , unicode(user.profile_image_url_https)
      , unicode(user.profile_link_color)
      , unicode(user.profile_sidebar_border_color)
      , unicode(user.profile_sidebar_fill_color)
      , unicode(user.profile_text_color)
      , user.profile_use_background_image
      , user.protected
      , unicode(user.screen_name)
      , user.show_all_inline_media
      , user.statuses_count
      , unicode(user.time_zone)
      , unicode(user.url)
      , user.utc_offset
      , user.verified
    )
    cursor = self.db.cursor()
    try:
      cursor.execute(sql, arglist)
    except _mysql_exceptions.ProgrammingError as (errno, strerror):
      print '''Error!'''
      print strerror
    cursor.close()

  def insert_status(self, status):
    if not self.user_exists(status.user):
      print "User not found, creating..."
      self.insert_user(status.user)
    sql = '''INSERT INTO tweet (
      id
      , created_at
      , favorited
      , in_reply_to_screen_name
      , in_reply_to_status_id
      , in_reply_to_user_id
      , place
      , retweet_count
      , retweeted
      , source
      , text
      , truncated
      , user
    )
    VALUES (
      %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
      , %s
    )'''
    arglist = (status.id
      , str(status.created_at.isoformat())
      , status.favorited
      , str(status.in_reply_to_screen_name)
      , status.in_reply_to_status_id
      , status.in_reply_to_user_id
      , str(status.place)
      , status.retweet_count
      , status.retweeted
      , str(status.source)
      , str(status.text)
      , status.truncated
      , status.user.id)
    #print "Sql:", sql
    #print "Args:", arglist
    #print sql % arglist
    #return
    cursor = self.db.cursor()
    try:
      cursor.execute(sql, arglist)
    except _mysql_exceptions.ProgrammingError as (errno, strerror):
      print '''Error!'''
      print strerror
    cursor.close()
    self.db.commit()
