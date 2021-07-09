require_relative "Character"

class Hero < Character
    def initialize(name,hitpoint,damage_attack, deflect_ability)
      @name = name
      @hitpoint = hitpoint
      @damage_attack = damage_attack
      @deflect_ability = deflect_ability
    end

    def got_attacked(damage)
      @number = rand(1..100)

      if @number <= @deflect_ability
        puts "#{@name} deflected the attack"
      elsif
        @hitpoint -= damage
      end
      
    end
end