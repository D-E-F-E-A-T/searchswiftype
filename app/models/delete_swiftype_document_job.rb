class DeleteSwiftypeDocumentJob < Struct.new(:pin_id)
  def perform
    client = Swiftype::Client.new
    client.destroy_document(ENV['my-awesome-blog'], Pin.model_name.downcase, pin_id)
  end
end