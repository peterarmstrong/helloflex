require 'test/unit'
require 'rubygems'
require 'active_support'
require 'action_controller'
require File.join(File.dirname(__FILE__), '..', 'lib', 'ruboss_helper')

class RubossHelperTest < Test::Unit::TestCase
  
  ActionView::Helpers::AssetTagHelper::ASSETS_DIR = File.dirname(__FILE__) # Make rails_asset_id work
  
  include RubossHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::ActiveRecordHelper
  include ActionView::Helpers::JavascriptHelper
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::TagHelper  
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::TextHelper
  include ActionController
  
  def test_sanity
    assert_nothing_raised {swfobject('test.swf')}
  end
  
  def test_div_is_created_if_asked_for
    swf = swfobject('test.swf', :create_div => true)
    assert_match /<div id=\"flashContent\"/, swf #"
  end
  
  def test_div_name_is_set_properly
    swf = swfobject('test.swf', :create_div => true, :id => 'my_id')
    assert_match /<div id=\"my_id\"/, swf #"    
  end
  
  def test_div_is_not_created_if_not_asked_for
    swf = swfobject('test.swf')
    assert_no_match /<div/, swf
  end
  
  def test_flash_vars_can_be_set_with_a_string
    swf = swfobject('test.swf', :flash_vars => 'myVars' )
    assert_match /,myVars[ )]/, swf
  end
  
  def test_flash_vars_can_be_set_with_a_hash
    hash = {'one' => 1, 'two' => 2, 'string' => 'stringy'}
    swf = swfobject('test.swf', :flash_vars => hash )
    # assert_match /one:\"1\"/, swf #"   
    # assert_match /two:\"2\"/, swf #"
    assert_match hash.to_json, swf
  end
  
  def test_rails_asset_id_is_not_blank
    swf = swfobject('test.swf')
    swf =~ /test.swf\?([^\']*)/
    assert !$1.empty?
  end

end
