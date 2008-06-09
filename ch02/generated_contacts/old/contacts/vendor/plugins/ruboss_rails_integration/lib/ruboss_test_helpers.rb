module RubossTestHelpers
  
  # Make xml functional testing work.
  # From http://weblog.jamisbuck.org/2007/1/4/assert_xml_select
  def xml_document
    @xml_document ||= HTML::Document.new(@response.body, false, true)
  end  
  
  def assert_xml_select(*args, &block)
    @html_document = xml_document
    assert_select(*args, &block)
  end   
  
end