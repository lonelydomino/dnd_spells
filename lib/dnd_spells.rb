
require 'pry'
require 'httparty'
require 'tty-progressbar'

require_relative "./dnd_spells/version"
require_relative "./dnd_spells/cli"
require_relative "./dnd_spells/api"
require_relative "./dnd_spells/spell"



module DndSpells
  class Error < StandardError; end
  # Your code goes here...
end
