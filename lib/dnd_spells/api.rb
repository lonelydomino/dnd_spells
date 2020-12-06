require 'pry'
require 'rubygems'
require 'httparty'

class API

    def self.get_spell_collection
        data = HTTParty.get("https://www.dnd5eapi.co/api/spells")
        spells = data["results"]
        Spell.new_from_spell_collection(spells) 
    end

    def self.get_spell_attributes(spell_index)
        data = HTTParty.get("https://www.dnd5eapi.co/api/spells/#{spell_index}")
        data
    end
    
end
