class DndSpells::Spell

    attr_accessor :name, :spell_index, :desc, :range, :klass, :attack_type, :duration, :level, :damage_type, :school

    @@all = []

    def initialize(name, index) 
        self.name = name
        self.spell_index = index
        self.get_spell_attributes(self)
        save
    end

    def self.new_from_spell_collection(data)
        bar = TTY::ProgressBar.new("Loading [:bar]", total: data.size)
        
        data.each do |item|
            name = item["name"]
            index = item["index"]
            sleep(0.1)
            bar.advance(1)
            new(name, index)
        end
    end

    def self.all
        @@all
    end

    def self.spell_sort(char, page)
        if char == 'k'
            if page == 1
                @@all[0..100] = all[0..100].sort{|a, b| (a.klass == b.klass) ? a.name <=> b.name : a.klass <=> b.klass} 
            elsif page == 2
                @@all[101..200] = all[101..200].sort! {|a, b| (a.klass == b.klass) ? a.name <=> b.name : a.klass <=> b.klass}
            elsif page == 3
                @@all[201..319] = all[201..319].sort! {|a, b| (a.klass == b.klass) ? a.name <=> b.name : a.klass <=> b.klass}
            end
        elsif char == 'a'
            if page == 1
                @@all[0..100] = all[0..100].sort! {|a,b| a.name <=> b.name}
            elsif page == 2
                @@all[101..200] = all[101..200].sort! { |a, b| a.name <=> b.name }
            elsif page == 3
                @@all[201..319] = all[201..319].sort! { |a, b| a.name <=> b.name }
            end
        end
    end

    def self.get_spells(page)
            DndSpells::API.get_spell_collection(page)
    end

    def get_spell_attributes(spell_obj)
        spell = spell_obj
        spell_data = DndSpells::API.get_spell_attributes(spell.spell_index)
        spell.desc = spell_data["desc"][0]
        spell.range = spell_data["range"]
        spell.klass = spell_data["classes"][0]["name"]
        spell.attack_type = spell_data["attack_type"]
        spell.duration = spell_data["duration"]
        spell.damage_type = spell_data["damage"]["damage_type"]["name"] if defined?(spell_data["damage"]["damage_type"]["name"])
        spell.level = spell_data["level"]
        spell.school = spell_data["school"]["name"]
    end

    def save 
        @@all << self
    end


end
