class DndSpells::Spell
    attr_accessor :name, :id_num, :spell_index, :desc, :desc, :range, :klass, :attack_type, :duration, :level, :damage_type

    @@all = []

    def initialize(name, index) 
        @id_num = @@all.length + 1
        @name = name
        @spell_index = index
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
        DndSpells::API.get_spell_collection
    end

    def self.get_spell_attributes(id_num) #modify so this only grabs data for the one spell called
        all.each do |spell|
            if spell.id_num == id_num
                spell_data = DndSpells::API.get_spell_attributes(spell.spell_index)
                spell.desc = spell_data["desc"]
                spell.range = spell_data["range"]
                spell.klass = spell_data["classes"][0]["name"]
                spell.attack_type = spell_data["attack_type"]
                spell.duration = spell_data["duration"]
                spell.damage_type = spell_data["damage"]["damage_type"]["name"]
                spell.level = spell_data["level"]
            end
            #data["material"]
            #data["school"]["name"]
            #data["damage"]["damage_at_slot_level"] gets hash of levels and dice per slot
            #data["duration"]
            #data["higher_level"]
        end
    end

    def print_spell_attributes
        puts "Name: #{self.name}"
        puts "Desc: #{self.desc}"
        puts "Range: #{self.range}"
        puts "Attack Type: #{self.attack_type}"
        puts "Duration: #{self.duration}"
        puts "Damage Type: #{self.damage_type}"
        puts "Level: #{self.level}"
        puts "Class: #{self.klass}"
    end

    def save 
        @@all << self
    end
end