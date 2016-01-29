# path to the app source
$LOAD_PATH.unshift(File.expand_path('../../../lib/application', __FILE__))

# load all dependency gems
require File.expand_path('../boot', __FILE__)


require ::File.expand_path('../../lib/application/app',  __FILE__)

# db
DB = Sequel.connect('postgres://username:password@localhost/seo_development')
