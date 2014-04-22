name             'corsis_create_users'
maintainer       'Anthony Tonns'
maintainer_email 'atonns@corsis.com'
license          'Apache 2.0'
description      'Installs/Configures corsis_create_users'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.2'
recipe            "corsis_create_users", "Creates users, sets authorized_keys for them from S3"
depends          "s3_file"
