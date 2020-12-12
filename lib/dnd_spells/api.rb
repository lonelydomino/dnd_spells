class DndSpells::API
    def self.get_spell_data
        data = HTTParty.get("https://www.dnd5eapi.co/api/spells")
        spells = data["results"]
        spells
    end

    def self.get_spell_collection(page)
        spells = get_spell_data
        if page == 1
            DndSpells::Spell.new_from_spell_collection(spells[0..100])
        elsif page == 2
            DndSpells::Spell.new_from_spell_collection(spells[101..200])
        elsif page == 3
            DndSpells::Spell.new_from_spell_collection(spells[201..319])
        end
    end

    def self.get_spell_attributes(spell_index)
        data = HTTParty.get("https://www.dnd5eapi.co/api/spells/#{spell_index}")
        data
    end
    
end
