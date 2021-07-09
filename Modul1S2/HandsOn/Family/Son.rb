require_relative "Father"

class Son < Father
    def initialize
        puts "in Son method"
    end
end