module JotForm
  class API
    def initialize(key)
      @@jotform ||= JotForm.new(key)
    end

    def self.method_missing(name, *args, &blk)
      @@jotform.send name, *args, &blk
    end

    def method_missing(name, *args, &blk)
      @@jotform.send name, *args, &blk
    end
  end
end