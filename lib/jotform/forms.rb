require 'ostruct'

module JotForm
  class Form < OpenStruct
    def questions
      @questions ||= ::JotForm::API.getFormQuestions(id).values.map do |v|
        v.keys.each do |key|
          v[(key.to_sym rescue key) || key] = v.delete(key)
        end
        v
      end.sort{|a, b| a[:order].to_i <=> b[:order].to_i}
    end
  end
end