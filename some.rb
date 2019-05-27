require 'json'
require 'pry'

def checker(data_source, data_client)
  source_keys = data_source.keys.sort
  client_keys = data_client.keys.sort
  

  unless source_keys == client_keys
    if !source_keys.empty? # do not show empty structures
      puts '=============='
      puts 'WATCH TO DIFF!'
      puts source_keys - client_keys | client_keys - source_keys
    end
  end

  # search inner structure
  data_source.each do |key, value|
    if value.is_a?(Hash)
      checker(data_source[key], data_client[key]) if data_client.key?(key)
    end
  end

end

def data_master
  f1 = File.read('./master.json')
  JSON.parse(f1)
end

def data_slave
  f2 = File.read('./slave.json')
  JSON.parse(f2)
end

checker(data_master, data_slave)