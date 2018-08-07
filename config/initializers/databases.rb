require 'sequel'
require 'sqlite3'

Sequel::Model.plugin :json_serializer

DB_UBICACIONES = Sequel.connect('sqlite://db/ubicaciones.db')
