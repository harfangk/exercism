class ETL
  def self.transform(old)
    old.reduce({}) do |memo, (k, v)|
      ks = v.map(&:downcase)
      vs = [k] * v.length
      hash = [ks, vs].transpose.to_h
      memo.merge!(hash)
    end
  end
end
