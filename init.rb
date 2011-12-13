Mime::Type.register "multipart/mixed; boundary=|||", :mxhr
ActionController::Renderers.add :mxhr do |packets, options|
  boundary = "--|||"
  body = ''

  packets.each do |p|
    body += "%s\nContent-Type: %s\n%s\n" % [boundary, p[:type], p[:body]]
  end

  body += '--|||--'

  self.content_type ||= Mime::MXHR
  self.response_body = body
end
