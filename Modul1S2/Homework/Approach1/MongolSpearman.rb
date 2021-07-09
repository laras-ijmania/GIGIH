require_relative "Villain"

class MongolSpearman < Villain

    def attack(other_player)
      other_player.got_attacked(@damage_attack)
      puts "#{@name} thrusts #{other_player.name} with #{@damage_attack} damage"
    end
end
    
