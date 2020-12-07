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
                #get spell details here
                load_spell_attributes(choice)
                list_spell_attributes(choice)
            else
                puts "Incorrect input!"
            end
        when 2
            puts "Selected: Option 2: List Spells by class"
            #list spells by class
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

    end

    def load_spells
        DndSpells::Spell.get_spells
    end

    def load_spell_attributes(id_num)
        DndSpells::Spell.get_spell_attributes(id_num)
    end

end