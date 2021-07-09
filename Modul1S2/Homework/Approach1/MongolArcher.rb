require_relative "Villain"

class MongolArcher < Villain
    def attack(other_player)
      other_player.got_attacked(@damage_attack)
      puts "#{@name} shoots an arrow at #{other_player.name} with #{@damage_attack} damage"
    end
end