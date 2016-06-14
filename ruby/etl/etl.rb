module ETL
  def self.transform(data)
    data.each_with_object(Hash.new) do |key_value_pair, out|
      key, value = key_value_pair
      value.each { |str| out[str.downcase] = key }
    end
  end
end
