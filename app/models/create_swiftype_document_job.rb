class CreateSwiftypeDocumentJob < Struct.new(:pin_id)
  def perform
    pin = Pin.find(pin_id)
    url = Rails.application.routes.url_helpers.pin_url(pin)
    client = Swiftype::Client.new
    client.create_or_update_document(ENV['my-awesome-blog'],
                                     Post.model_name.downcase,
                                     {:external_id => pin.id,
                                       :fields => [{:name => 'title', :value => pin.title, :type => 'string'},
                                                   {:name => 'body', :value => pin.body, :type => 'text'},
                                                   {:name => 'url', :value => url, :type => 'enum'},
                                                   {:name => 'created_at', :value => pin.created_at.iso8601, :type => 'date'}]})
  end
end