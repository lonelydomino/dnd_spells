class DndSpells::CLI

    def call 
        load_spells
        puts "Welcome to Dnd Spells!"
        run
    end
    def run
        input = 0
        puts "What would you like to do?"
        puts "1. List all spells alphabetically"
        puts "2. List all spells by character class"
        puts "3. Quit" 
        check_input
        
       
        
        #load_spell_attributes
        #list_spells
        #search_for_spell('aid')

        #commenting out list for now
        #list_spells #lists spells from api
        
    end

    def check_input
        print "Selection: "
        input = gets.to_i
        case input
        when 1
            puts "Selected: Option 1"
            list_spells
            puts "Please enter a spell's index number to list spell details: "
            choice = 0
            print "Selection: "
            choice = gets.to_i  
            if choice >= 1 && choice <= 319
                puts "Getting details........"
                load_spell_attributes(choice)
                list_spell_attributes(choice)
            else
                puts "Incorrect input!"
            end
        when 2
            puts "Selected: Option 2: List Spells by class"
            list_spells_by_class
        when 3
            #quits program
            puts "Selected: Option 3: Quit"
        else
            puts "Please enter correct input."
            check_input
        end
    end

    def list_spells
        DndSpells::Spell.all.each {|s| puts "#{s.id_num} #{s.name}"}
    end

    def list_spell_attributes(input)
        DndSpells::Spell.all.detect do |spell|
            if spell.id_num == input
                spell.print_spell_attributes
            end
        end
    end

    def list_spells_by_class
        spell_hash = {}
        num_id = 0
        klass_hash = {}

        DndSpells::Spell.all.each do |spell|
            if spell_hash.has_key?(spell.klass)
                spell_hash[spell.klass].push(spell.name)
              else
                spell_hash[spell.klass] = []
                spell_hash[spell.klass].push(spell.name)
            end
        end
        spell_hash.each do |k,v|
         puts "-----#{k}-----"
         v.each do |k|
           puts "#{num_id=num_id+1} #{k}"
           klass_hash[num_id] = k
         end
       end
        puts "-------------------------------------"
        print "Selection: "
        choice = gets.to_i
        klass_hash.each do |k,v|
            if k == choice
                DndSpells::Spell.all.each do |spell|
                    if spell.name == v
                        load_spell_attributes(spell.spell_index)
                        list_spell_attributes(spell.spell_index)
                    end
                end
            end
        end
        
    end

    def load_spells
        DndSpells::Spell.get_spells
    end

    def load_spell_attributes(id_num)
        DndSpells::Spell.get_spell_attributes(id_num)
    end

end

#Wizard
        #Sorcerer
        #Cleric
        #Ranger
        #Bard
        #Druid
        #Paladin
        #Warlock