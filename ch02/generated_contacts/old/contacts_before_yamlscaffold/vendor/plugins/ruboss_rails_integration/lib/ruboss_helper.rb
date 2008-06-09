module RubossHelper
  
  # Creates a swfObject Javascript call.  You must include swfobject.js to use this.
  # See http://code.google.com/p/swfobject/wiki/documentation for full details and documentation
  # of the swfobject js library.
  def swfobject(swf_url, params = {})
    params.reverse_merge!({:width => '100%',
                           :height => '100%',
                           :id => 'flashContent',
                           :version => nil,
                           :express_install_swf => nil,
                           :flash_vars => nil,
                           :params => nil,
                           :attributes => nil,
                           :create_div => false
                          })                       
    arg_order = [:id, :width, :height, :version, :express_install_swf]
    js_params = ["'#{swf_url}?#{rails_asset_id(swf_url)}'"]
    js_params += arg_order.collect {|arg| "'#{params[arg]}'" }
    js_params += [params[:flash_vars], params[:params], params[:attributes]].collect do |possible_hash|
      if possible_hash.is_a?(Hash)
        possible_hash.to_json
      else # If it's not a hash, then it should be a string giving the name of the Javascript variable to use
        possible_hash
      end
    end.compact


    swf_tag = javascript_tag do 
      "swfobject.embedSWF(#{js_params.join(',')})"
    end 
    swf_tag += content_tag(:div, nil, :id => params[:id]) if params[:create_div]    
    swf_tag
  end
  
end
