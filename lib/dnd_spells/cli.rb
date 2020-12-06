class CLI


    def run
        load_spells
        load_spell_attributes
        #list_spells
        search_for_spell('aid')

        #commenting out list for now
        #list_spells #lists spells from api
        
    end

    def list_spells
        Spell.all.each {|s| puts "#{s.id_num} #{s.name}"}
    end

    def load_spells
        Spell.get_spells
    end

    def load_spell_attributes
        Spell.get_spell_attributes
    end
    def search_for_spell(input)
        Spell.all.detect do |spell|
            if spell.spell_index == input
                puts "Spell found!"
                puts spell.name
                puts spell.desc
                puts spell.range
            end
        end

    end

end