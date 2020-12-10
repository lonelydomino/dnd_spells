class DndSpells::CLI

    def call 
        
        puts "\nWelcome to Dnd Spells!\n\n"
        run
    end

    def run
        input = 0
        puts "What would you like to do?\n\n"
        puts "1. List all spells alphabetically"
        puts "2. List all spells by character class"
        puts "3. Quit\n\n" 
        print "Selection: "
        input = gets.strip.to_i
        check_command_input(input)
        run_choice(input)

    end

    def quit
        puts "\n\nExiting program..."
        puts "\nThanks for using this program!\n\n\n"
    end
    def check_command_input(input)
        if input >= 1 && input <= 3
        #fix later, nothing needs to be here
        else
            puts "\n\nPlease enter correct input.\n\n"
            run
        end
    end

    def check_spell_input
        puts "Please enter a spell's index number to list spell details: "
        input = 0
        print "Selection: "
        input = gets.strip.to_i  
        if input >= 1 && input <= 319
            return input
        else
            puts "\n\nPlease enter correct input."
            check_spell_input
        end
    end

    def run_choice(input)
        case input
        when 1
            puts "\nListing spells alphabetically....\n"
            load_spells
            list_spells
            spell_obj = DndSpells::Spell.find_spell_by_id_num(check_spell_input)
            load_spell_attributes(spell_obj)
            puts "Getting details........"
            list_spell_attributes(spell_obj)
            search_again?
        when 2
            puts "Selected: Option 2: List Spells by class"
            load_spells
            puts "\nGetting details........\n"
            list_spells_by_class
            search_again?
        when 3
            quit
        end
    end

    def search_again?
        puts "What would you like to do?"
        puts "1. Search again."
        puts "2. Quit"
        print "Selection: "

        input = gets.strip.to_i
        if input == 1
            run
        elsif input == 2
            quit
        else
            puts "\n\nPlease enter correct input!\n\n"
            search_again?
        end

    end

    def load_spells
        DndSpells::Spell.get_spells
    end

    def load_spell_attributes(spell_obj)
        DndSpells::Spell.get_spell_attributes(spell_obj)
    end

    def list_spells
        DndSpells::Spell.all.each {|s| puts "#{s.id_num} #{s.name}"}
    end

    def list_spell_attributes(spell_obj)
        spell_obj.print_spell_attributes
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
           puts "#{num_id=num_id+1}. #{k}"
           klass_hash[num_id] = k
         end
       end
        puts "-------------------------------------"
        print "Selection: "
        choice = gets.strip.to_i
        klass_hash.each do |k,v|
            if k == choice
                spell = DndSpells::Spell.all.detect{|spell| spell.name == v}
                load_spell_attributes(spell)
                list_spell_attributes(spell)
            end
        end
        
    end


end