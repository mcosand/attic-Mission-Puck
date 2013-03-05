module UUIDTools
  class UUID
    def as_json(options = nil)
      self.to_s
    end

    def self.from_json(j)
      self.parse(j)
    end
  end
end
