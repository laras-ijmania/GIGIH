class Character
    attr_reader :name, :hitpoint, :attack , :die
    
    def initialize(name,hitpoint,damage_attack)
      @name = name
      @hitpoint = hitpoint
      @damage_attack = damage_attack
    end
    
    def play 
      attack(other_player)
    end

    def attack(other_player)
      other_player.got_attacked(@damage_attack)
      puts "#{@name} has attack #{other_player.name} with #{@damage_attack} damage"
    end
    
    def got_attacked(damage)
        @hitpoint -= damage      
    end
    
    def die?
      if @hitpoint <= 0
        puts "#{@name} dies"
        return true
      end
    end
end