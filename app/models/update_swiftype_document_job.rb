class UpdateSwiftypeDocumentJob < Struct.new(:pin_id)
  def perform
    pin = Pin.find(pin_id)
    engine = Swiftype::Engine.find('my-awesome-blog')
    type = engine.document_type('pin')
    type.update_document(:external_id => pin.id,
                         :fields => {:title => pin.title,
                                     :body => pin.body})
  end
end
