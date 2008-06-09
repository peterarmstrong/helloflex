module RubossController
  private

  # Extract any keys named _metadata from the models in the params hash
  # and put them in the root of the params hash.
  def extract_metadata_from_params
    metadata = {}
    metadata.merge!(params.delete('_metadata')) if params.has_key?('_metadata')
    params.each do |k, v|
      next unless v.respond_to?(:has_key?) and v.has_key?('_metadata')
      metadata.merge!(v.delete('_metadata'))
    end
    params.merge!(metadata) unless metadata.empty?
  end  
end