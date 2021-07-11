require_relative "Hero"

class Player < Hero
    def initialize(name,hitpoint,damage_attack, deflect_ability, heal_point, allies, villains)
        super(name, hitpoint, damage_attack, deflect_ability)
        @heal_point = heal_point
        @allies = allies
        @villains = villains
    end

    def play
        puts "As #{@name} what do you wanna do at this point?"
        puts "\n"
        puts "1. Attack villain \n2. Heal allies"

        number = gets.to_i

        while number != 1 && number != 2
            puts "Invalid option, please try again"
            number = gets.to_i
        end
        case number
        when 1
            attack
        when 2
            heal
        end
    end

    def heal
        puts "Which ally you wanna heal? \n"

        @allies.each_with_index {|ally, index|
            puts "#{index+1}. #{ally.name} \n"
        }
        number = gets.to_i

        target = @allies[number-1]
        target.healed(@heal_point)
        puts "#{@name} has healed #{target.name} with #{@heal_point} damage"

        if target.die?
            remove_party(@allies, target)
        end
    end

    def attack
        puts "Which enemy you wanna attack? \n"

        @villains.each_with_index {|villain, index|
            puts "#{index+1}. #{villain.name} \n"
        }
        number = gets.to_i

        target = @villains[number-1]
        target.got_attacked(@damage_attack)
        puts "#{@name} has attack #{target.name} with #{@damage_attack} damage"

        if target.flee? or target.die?
            remove_party(@villains, target)
        end
    end

    def remove_party(party, person)
        party.delete_at(party.find_index(person))
    end
end
