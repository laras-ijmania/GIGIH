require_relative "Grandfather"

class Father < GrandFather
    def initialize
        puts "in Father method"
    end
end