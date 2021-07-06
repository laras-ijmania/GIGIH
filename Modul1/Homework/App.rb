require_relative "Person"
  
jin = Person.new('Jin Sakai', 100, 50, 80)
khotun = Person.new('Khotun Khan', 500, 50, 0)

while !jin.die? && !khotun.die?
    jin.attack(khotun)
    if khotun.die? 
        break
    end

    khotun.attack(jin)
    if jin.die? 
        break
    end
end