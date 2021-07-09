require_relative "Hero"

class Ally < Hero
    def healed(heal_point)
        puts "#{name} is healed. Restored #{heal_point} point"
        @hitpoint+=heal_point
    end
end