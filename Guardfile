# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'process', :name => 'http://localhost:9093/rom_manual', :command => 'ruby -run -e httpd output -p 9093' do
end

guard 'nanoc' do
  watch('nanoc.yaml') # Change this to config.yaml if you use the old config file name
  watch('Rules')
  watch(%r{^(content|layouts|lib)/.*$})
end
