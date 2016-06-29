class CreateSwiftypeDocumentJob < Struct.new(:pin_id)
  def perform
    pin = Pin.find(pin_id)
    url = Rails.application.routes.url_helpers.pin_url(pin, :host => "0.0.0.0")
    engine = Swiftype::Engine.find('my-awesome-blog')
    type = engine.document_type('pin')
    type.create_document({:external_id => pin.id,
                           :fields => [{:name => 'title', :value => pin.title, :type => 'string'},
                                       {:name => 'body', :value => pin.body, :type => 'text'},
                                       {:name => 'url', :value => url, :type => 'enum'},
                                       {:name => 'created_at', :value => pin.created_at.iso8601, :type => 'date'}]})
  end
end