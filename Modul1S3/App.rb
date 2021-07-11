require_relative "Hero"
require_relative "Character"
require_relative "Villain"
require_relative "MongolArcher"
require_relative "MongolSwordsman"
require_relative "MongolSpearman"
require_relative "Ally"
require_relative "Player"

archer = MongolArcher.new('Mongol Archer', 300, 50)
spearman = MongolSpearman.new("Mongol Spearman", 150,50)
swordswman = MongolSwordsman.new("Mongol Swordsman", 200,50)
villains = [archer, spearman, swordswman]

yuna = Ally.new("Yuna", 100, 50, 80)
ishihara = Ally.new("Sensei Ishihara", 100, 50, 80)
allies = [yuna, ishihara]

jin = Player.new('Jin Sakai', 100, 50, 80, 30, allies, villains)

i = 1

def remove_party(party, person)
    party.delete_at(party.find_index(person))
end

while !jin.die? && !villains.empty?
    puts "========================== Turn #{i} =========================="
    puts "\n"

    puts "#{jin.name} has #{jin.hitpoint} hitpoint and #{jin.damage_attack} damage attack"
    allies.each do |ally|
        puts "#{ally.name} has #{ally.hitpoint} hitpoint and #{ally.damage_attack} damage attack"
    end
    villains.each do |villain|
        puts "#{villain.name} has #{villain.hitpoint} hitpoint and #{villain.damage_attack} damage attack"
    end
    puts "\n"

    jin.play
    allies.each do |ally|
        target = villains[rand(villains.length)]
        ally.play(target)
        if target.die? or target.flee?
            remove_party(villains, target)
        end
        if villains.empty?
            break
        end
    end
    villains.each do |villain|
        target = allies[rand(allies.length)]
        villain.play(target)
        if target.die?
            remove_party(allies, target)
        end
        if jin.die?
            break
        end
    end
    puts "\n"

    i+=1

end
