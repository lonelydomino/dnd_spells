class DndSpells::Spell

    attr_accessor :name, :id_num, :spell_index, :desc, :desc, :range, :klass, :attack_type, :duration, :level, :damage_type, :school

    @@all = []

    def initialize(name, index) 
        @id_num = @@all.length + 1
        @name = name
        @spell_index = index
        set_klass(index)
        save
    end

    def self.new_from_spell_collection(data)
        data.each do |item|
            name = item["name"]
            index = item["index"]
            new(name, index)
        end
    end

    def set_klass(index)
        spell_data = DndSpells::API.get_spell_attributes(index)
        @klass = spell_data["classes"][0]["name"]
    end

    def self.all
        @@all
    end

    def self.get_spells
        DndSpells::API.get_spell_collection
    end
    def self.find_spell_by_id_num(input)
        all.detect {|spell| spell.id_num == input}
    end

    def self.get_spell_attributes(spell_obj)
        spell = spell_obj
        
        spell_data = DndSpells::API.get_spell_attributes(spell.spell_index)
        spell.desc = spell_data["desc"][0]
        spell.range = spell_data["range"]
        spell.klass = spell_data["classes"][0]["name"]
        spell.attack_type = spell_data["attack_type"]
        spell.duration = spell_data["duration"]
        spell.damage_type = spell_data["damage"]["damage_type"]["name"] if defined?(spell_data["damage"]["damage_type"]["name"]) && spell_data["damage"]["damage_type"]["name"]
        spell.level = spell_data["level"]
        spell.school = spell_data["school"]["name"]
    end

    def print_spell_attributes
        puts "\nName: #{self.name}"
        puts "Desc: #{self.desc}"
        puts "Range: #{self.range}"
        puts "Attack Type: #{self.attack_type}" if self.attack_type != nil
        puts "Duration: #{self.duration}"
        puts "Damage Type: #{self.damage_type}" if self.damage_type != nil
        puts "Level: #{self.level}"
        puts "Class: #{self.klass}"
        puts "Magic School: #{self.school}"
    end

    def save 
        @@all << self
    end
    
end