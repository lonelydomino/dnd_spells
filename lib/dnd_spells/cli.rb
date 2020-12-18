class DndSpells::CLI
    @@current_page = 0
    
    def call 
        puts "\nWelcome to Dnd Spells!\n\n"     
        run
    end

    def run
        prompt = TTY::Prompt.new
        input = prompt.select("\nWhat would you like to do?\n\n", cycle: true) do |menu|
            menu.enum "."
            menu.choice "List all spells alphabetically\n", 1
            menu.choice "List all spells by character class\n", 2
            menu.choice "Quit\n\n", 3
        end
        menu_choice(input)
    end

    def quit
        puts "\n\nExiting program..."
        puts "\n\nThanks for using this program!\n\n\n"
    end

    def check_spell_input
        puts "\nPlease enter a spell's index number to list spell details: "
        input = 0
        print "Spell Selection: "
        input = gets.strip.to_i  
        input -= 1

        if input >= 0 && input <= 100 && @@current_page == 1
            spell_obj = DndSpells::Spell.all[input]
            list_spell_attributes(spell_obj)
            print "\nPress any key to continue..."                                                                                                    
            STDIN.getch                                                                                                              
            print "            \r"
            page1_commands
        elsif input >= 101 && input <= 200 && @@current_page == 2
            spell_obj = DndSpells::Spell.all[input]
            list_spell_attributes(spell_obj)
            print "\nPress any key to continue..."                                                                                                    
            STDIN.getch                                                                                                              
            print "            \r"
            page2_commands
        elsif input >= 201 && input <= 318 && @@current_page == 3
            spell_obj = DndSpells::Spell.all[input]
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
            puts "\nGetting spells........\n"
            @@sort = 'a'
            @@current_page = 1
            page1_commands
        when 2
            puts "\nGetting spells........\n"
            @@sort = 'k'
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

        prompt = TTY::Prompt.new
        input = prompt.select("\n\nWhat would you like to do?\n", cycle: true) do |menu|
            menu.enum "."
            menu.choice "Select Spell\n", 1
            menu.choice "Next Page\n", 2
            menu.choice "Menu\n", 3
            menu.choice "Quit\n\n", 4
        end

        if input == 1
            check_spell_input
        elsif input == 2
            page2_commands
        elsif input == 3
            run
        elsif input == 4
            quit
        end
    end

    def page2_commands
        load_spells(2) if DndSpells::Spell.all[101] == nil
        @@current_page = 2
        list_spells(2)

        prompt = TTY::Prompt.new
        input = prompt.select("\n\nWhat would you like to do?\n", cycle: true) do |menu|
            menu.enum "."
            menu.choice "Select Spell\n", 1
            menu.choice "Next Page\n", 2
            menu.choice "Previous Page\n", 3
            menu.choice "Menu\n", 4
            menu.choice "Quit\n\n", 5
        end
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
        @@current_page = 3
        load_spells(@@current_page) if DndSpells::Spell.all[201] == nil
        list_spells(@@current_page)
        prompt = TTY::Prompt.new
        input = prompt.select("\n\n What would you like to do?\n", cycle: true) do |menu|
            menu.enum "."
            menu.choice "Select Spell\n", 1
            menu.choice "Previous Page\n", 2
            menu.choice "Menu\n", 3
            menu.choice "Quit\n\n", 4
        end

        if input == 1
            check_spell_input
        elsif input == 2
            page2_commands
        elsif input == 3
            run
        elsif input == 4
            quit
        end
    end

    def load_spells(page)
        DndSpells::Spell.get_spells(page)
    end

    def list_spells(page)
        table = TTY::Table.new(header: ["Class", "Spell Name", "ID"])
        if page == 1
            startNum = 0
            endNum = 100
        elsif page == 2
            startNum = 101
            endNum = 200
        elsif page == 3
            startNum = 201
            endNum = 319
        end

        DndSpells::Spell.spell_sort(@@sort, page)
        DndSpells::Spell.all[startNum..endNum].each_with_index do |a, i|
            i += startNum
            i = i + 1
            table << [a.klass, a.name, i]
        end
        puts table.render(:unicode,alignments: [:left, :center, :center])
    end

    def list_spell_attributes(spell_obj)
        spell_obj.print_spell_attributes
    end

end