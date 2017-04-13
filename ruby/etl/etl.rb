class ETL
  def self.transform(old)

    result = {}

    old.each_pair do |k, v|
      new_ks = v.map(&:downcase)
      new_vs = [k] * v.length
      new_hash = [new_ks, new_vs].transpose.to_h
      result.merge!(new_hash)
    end

    result
  end
end
