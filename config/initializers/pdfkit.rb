=begin
Mime::Type.register "application/pdf", :pdf

PDFKit.configure do |config|
  config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
  config.default_options = {
    :page_size => 'Legal',
    :print_media_type => true
  }
  config.root_url = "http://localhost"
end
=end