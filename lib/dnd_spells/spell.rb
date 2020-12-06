class Spell
    attr_accessor :name, :id_num, :spell_index, :desc, :higher_level, :desc, :range

    @@all = []

    def initialize(name, index) 
        @id_num = @@all.length + 1
        @name = name
        @spell_index = index
        #get_spell_details(spell_index) GET SPELL DETAILS SOMEWHERE ELSE, DRASITCALLY INCREASES LOADING TIME
        #spell_attributes_from_collection(data)
        save
    end
    def self.new_from_spell_collection(data)
        data.each do |item|
            name = item["name"]
            index = item["index"]
            new(name, index)
        end
    end

    def self.all
        @@all
    end
    def self.get_spells
        API.get_spell_collection
    end

    def self.get_spell_attributes
        puts "this"
        all.each do |spell|
            spell_data = API.get_spell_attributes(spell.spell_index)
            spell.desc = spell_data["desc"]
            spell.range = spell_data["range"]
            #puts data["duration"]
            #data["material"]
            #data["damage"]["damage_type"]["name"] goes into hash and retrieves spell damage type
            #data["school"]["name"]
            #data["damage"]["damage_at_slot_level"] gets hash of levels and dice per slot
            #puts data["attack_type"]
            #data["duration"]
            #data["higher_level"]
    #data["level"]
        end
    end

    def save 
        @@all << self
    end
end