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

while !jin.die? || !villains.empty?
    puts "========================== Turn #{i} =========================="
    puts "\n"

    puts jin.name
    villains.each do |villain|
        puts villain.name
    end
    puts "\n"

    jin.play
    villains.each do |villain|
        villains.delete(villain) if villain.die? || villain.flee?
    end
    puts "\n"

    allies.each do |ally|
        ally.play
    end
    puts "\n"

    villains.each do |villain|
        villain.play
    end
    puts "\n"

    i+=1

end