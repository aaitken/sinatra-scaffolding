$: << '.' #need to do this to get load path working

require 'app'
require 'lib/sinatra/assets'

use Assets
run Sinatra::Application
