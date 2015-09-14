require 'aws-sdk'
require 'json'

module CloudSearch
  def self.client_config= config
    @client_config = config
  end

  def self.client_config
    @client_config || {}
  end

  def self.client
    @client ||= Aws::CloudSearch::Client.new(client_config)
  end

  def self.client=(client)
    @client = client
  end

  #
  # Send an SDF document to CloudSearch via http post request.
  # Returns parsed JSON response, or raises an exception
  #
  def self.post_sdf endpoint, sdf
    self.post_sdf_list endpoint, [sdf]
  end

  def self.post_sdf_list endpoint, sdf_list
    client = Aws::CloudSearchDomain::Client.new(CloudSearch::client_config.merge(endpoint:"https://#{endpoint}"))
    client.upload_documents(
      documents: JSON.generate(sdf_list),
      content_type: "application/json",
    )
  end
end
