require_relative "Character"

class Villain < Character
    attr_reader :name , :hitpoint , :damage_attack
    
    def initialize(name, hitpoint, damage_attack)
        @name = name
        @hitpoint = hitpoint
        @damage_attack = damage_attack
    end

    def flee?
        @number = rand(1..2)
        
        if @number == 1 && hitpoint == 50
            puts "#{@name} has fled with #{@hitpoint} hitpoint"
            return true
        end
    end
end