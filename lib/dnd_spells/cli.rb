class DndSpells::CLI
    @@current_page = 0

    def call 
        puts "\nWelcome to Dnd Spells!\n\n"     
        run
    end

    def run
        input = 0
        puts "\nWhat would you like to do?\n\n"
        puts "1. List all spells alphabetically"
        puts "2. List all spells by character class"
        puts "3. Quit\n\n" 
        print "Selection: "
        input = gets.strip.to_i
        check_command_input(input)
        menu_choice(input)
    end

    def quit
        puts "\n\nExiting program..."
        puts "\n\nThanks for using this program!\n\n\n"
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
        puts "\nPlease enter a spell's index number to list spell details: "
        input = 0
        print "Spell Selection: "
        input = gets.strip.to_i  
        input -= 1
        if input >= 0 && input <= 100 && @@current_page == 1
            spell_obj = DndSpells::Spell.all[input]   # DndSpells::Spell.find_spell_by_id_num(input)
            load_spell_attributes(spell_obj)
            list_spell_attributes(spell_obj)
            print "\nPress any key to continue..."                                                                                                    
            STDIN.getch                                                                                                              
            print "            \r"
            page1_commands
        elsif input >= 101 && input <= 200 && @@current_page == 2
            spell_obj = DndSpells::Spell.all[input]  # DndSpells::Spell.find_spell_by_id_num(input)
            load_spell_attributes(spell_obj)
            list_spell_attributes(spell_obj)
            print "\nPress any key to continue..."                                                                                                    
            STDIN.getch                                                                                                              
            print "            \r"
            page2_commands
        elsif input >= 201 && input <= 318 && @@current_page == 3
            spell_obj = DndSpells::Spell.all[input]   # DndSpells::Spell.find_spell_by_id_num(input)
            load_spell_attributes(spell_obj)
            list_spell_attributes(spell_obj)
            print "\nPress any key to continue..."                                                                                                    
            STDIN.getch                                                                                                              
            print "            \r"
            page3_commands
        else
            puts "\n\nPlease enter correct input."
            check_spell_input
        end
    end

    def menu_choice(input)
        case input
        when 1
            puts "\nListing spells alphabetically....\n"
            @@klass_sort = false
            @@current_page = 1
            page1_commands
        when 2
            puts "Selected: Option 2: List Spells by class"
            puts "\nGetting details........\n"
            @@klass_sort = true
            @@current_page = 1
            page1_commands
        when 3
            quit
        end
    end

    def page1_commands
        load_spells(1)  if DndSpells::Spell.all[0] == nil
        @@current_page = 1
        list_spells(1)
        puts "\n\nWhat would you like to do?"
        puts "1. Select Spell"
        puts "2. Next Page"
        puts "3. Menu"
        puts "4. Quit\n"
        print "Selection: "

        input = gets.strip.to_i
        if input == 1
            check_spell_input
        elsif input == 2
            page2_commands
        elsif input == 3
            run
        elsif input == 4
            quit
        else
            puts "\n\nPlease enter correct input!\n\n"
            page1_commands
        end

    end

    def page2_commands
        load_spells(2) if DndSpells::Spell.all[101] == nil
        @@current_page = 2
        list_spells(2)
        puts "\n\nWhat would you like to do?"
        puts "1. Select Spell"
        puts "2. Next Page"
        puts "3. Previous Page"
        puts "4. Menu"
        puts "5. Quit"
        print "Selection: "
    
            input = gets.strip.to_i
            if input == 1
                check_spell_input
            elsif input == 2
                page3_commands
            elsif input == 3
                page1_commands
            elsif input == 4
                run
            elsif input == 5
                quit
            else
                puts "\n\nPlease enter correct input!\n\n"
                page2_commands
            end
    end

    def page3_commands
        load_spells(3) if DndSpells::Spell.all[201] == nil
        @@current_page = 3
        list_spells(3)
        puts "\n\nWhat would you like to do?"
        puts "1. Select Spell"
        puts "2. Previous Page"
        puts "3. Menu"
        puts "4. Quit"
        print "Selection: "
    
            input = gets.strip.to_i
            if input == 1
                check_spell_input
            elsif input == 2
                page2_commands
            elsif input == 3
                run
            elsif input == 4
                quit
            else
                puts "\n\nPlease enter correct input!\n\n"
                page3_commands
            end
    end

    def load_spells(page)
        DndSpells::Spell.get_spells(page)
    end

    def load_spell_attributes(spell_obj)
        DndSpells::Spell.get_spell_attributes(spell_obj)
    end

    def list_spells(page)
        if @@klass_sort == true
            if page == 1
                DndSpells::Spell.spell_sort('k', 1)
                DndSpells::Spell.all[0..100].each_with_index {|a, i| puts "#{a.klass} --- #{i+1} --- #{a.name}"}
            elsif page == 2
                DndSpells::Spell.spell_sort('k', 2)
                DndSpells::Spell.all[101..200].each_with_index {|a, i| puts "#{a.klass} --- #{i+102} --- #{a.name}"}
            elsif page == 3
                DndSpells::Spell.spell_sort('k', 3)
                DndSpells::Spell.all[201..319].each_with_index {|a, i| puts "#{a.klass} --- #{i+202} --- #{a.name}"}
            end
        elsif @@klass_sort == false
            if page == 1
                DndSpells::Spell.spell_sort('a',1)
                DndSpells::Spell.all[0..100].each_with_index {|a, i| puts "#{a.klass} --- #{i+1} --- #{a.name}"}
            elsif page == 2
                DndSpells::Spell.spell_sort('a',2)
                DndSpells::Spell.all[101..200].each_with_index {|a, i| puts "#{a.klass} --- #{i+102} --- #{a.name}"}
            elsif page == 3
                DndSpells::Spell.spell_sort('a',3)
                DndSpells::Spell.all[201..319].each_with_index {|a, i| puts "#{a.klass} --- #{i+202} --- #{a.name}"}
            end
        end
    end

    def list_spell_attributes(spell_obj)
        spell_obj.print_spell_attributes
    end

end