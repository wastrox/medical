# encoding: utf-8
require 'yaml'
##
# Backup Generated: medical_production
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t medical_production [-c <path_to_configuration_file>]
#
Backup::Model.new(:medical_production, 'Description for medical_production') do

  ##
  # MySQL [Database]
  #

	archive :system do |archive|
    archive.add "public/system"
    archive.tar_options '-h'
  end

  dbconfig = YAML::load(ERB.new(IO.read(File.join('config', 'database.yml'))).result)['production']
  database MySQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = dbconfig['database']
    db.username           = dbconfig['username']
    db.password           = dbconfig['password']
    db.host               = dbconfig['host']
    db.port               = 3306
    #db.socket             = "/tmp/mysql.sock"
    # Note: when using `skip_tables` with the `db.name = :all` option,
    # table names should be prefixed with a database name.
    # e.g. ["db_name.table_to_skip", ...]
    # db.skip_tables        = ["skip", "these", "tables"]
    # db.only_tables        = ["only", "these", "tables"]
    # db.additional_options = ["--quick", "--single-transaction"]
  end

  ##
  # Local (Copy) [Storage]
  #
  store_with Local do |local|
    local.path       = "~/backups/"
    local.keep       = 5
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the Wiki for other delivery options.
  # https://github.com/meskyanichi/backup/wiki/Notifiers
  #
  
  # notify_by Mail do |mail|
  #   mail.on_success           = true
  #   mail.on_warning           = true
  #   mail.on_failure           = true

  #   mail.from                 = "sender@email.com"
  #   mail.to                   = "receiver@email.com"
  #   mail.address              = "smtp.gmail.com"
  #   mail.port                 = 587
  #   mail.domain               = "your.host.name"
  #   mail.user_name            = "sender@email.com"
  #   mail.password             = "my_password"
  #   mail.authentication       = "plain"
  #   mail.encryption           = :starttls
  # end

end
