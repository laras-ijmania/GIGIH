require_relative "Hero"

class Player 
    def initialize(name,hitpoint,damage_attack, deflect_ability, heal_point, allies, villains)
      @name = name
      @hitpoint = hitpoint
      @damage_attack = damage_attack
      @deflect_ability = deflect_ability
      @heal_point = heal_point
      @allies = allies
      @villains = villains
    end

    def play
        puts "As #{@name} what do you wanna do at this point?"
        puts "\n"
        puts "1. Attack villain \n 2. Heal allies"

        number = gets

        if number == 1
            
    end

    def heal
        puts "Which ally you wanna heal? \n"
        
        i = 1
        picked_alive = false
        until picked_alive = true
            @allies.each do |ally|
                puts "#{1}. #{ally.name} \n"
                i+=1
            end
            number = gets

            if allies[number-1].die? == true
                puts "pick anoter ally"
            end
        end

        picked = allies[number-1]

        picked.heal(@heal_point)
        puts "#{@name} has attack #{picked.name} with #{@damage_attack} damage"
    end

    def attack
        puts "Which enemy you wanna attack? \n"
        
        i = 1
        picked_alive = false
        until picked_alive = true
            @villains.each do |villain|
                puts "#{1}. #{villain.name} \n"
                i+=1
            end
            number = gets

            if villains[number-1].die? == true
                puts "pick anoter enemy"
            end
        end

        picked = villains[number-1]

        picked.got_attacked(@damage_attack)
        puts "#{@name} has attack #{picked.name} with #{@damage_attack} damage"
    end