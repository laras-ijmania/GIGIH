class Person
    attr_reader :name, :hitpoint, :attack , :die
    
    def initialize(name,hitpoint,damage_attack, deflect_ability)
      @name = name
      @hitpoint = hitpoint
      @damage_attack = damage_attack
      @deflect_ability = deflect_ability
    end
    
    def attack(other_player)
      other_player.got_attacked(@damage_attack)
      puts "#{@name} has attack #{other_player.name} with #{@damage_attack} damage"
    end
    
    def got_attacked(damage)
      @number = rand(1..100)

      if @number <= @deflect_ability
        puts "#{@name} deflected the attack"
      elsif
        @hitpoint -= damage
      end
      
    end
    
    def die?
      if @hitpoint <= 0
        puts "#{@name} is die"
        return true
      end
    end
end