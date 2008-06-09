require 'ruboss_rails_integration'

ActionView::Base.send :include, RubossHelper

# temporarily disable forgery protection site-wise
ActionController::Base.allow_forgery_protection = false

ActionController::Base.send :include, RubossController
ActionController::Base.send :prepend_before_filter, :extract_metadata_from_params  
Test::Unit::TestCase.send :include, RubossTestHelpers
