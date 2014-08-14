node(:env) { Rails.env }
child :config do
  node(:site_name) { @config.site_name }
  node(:logo) { @config.logo }
  node(:facebook_app_id) { ENV['FACEBOOK_APP_ID'] }
end
node(:templates) { @templates }
