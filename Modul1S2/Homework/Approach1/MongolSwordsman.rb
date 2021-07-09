require_relative "Villain"
    
class MongolSwordsman < Villain
    def attack(other_player)
      other_player.got_attacked(@damage_attack)
      puts "#{@name} slashes #{other_player.name} with #{@damage_attack} damage"
    end
end