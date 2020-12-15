require_relative "./dnd_spells/version"

module DndSpells
  class Error < StandardError; end
  # Your code goes here...
end


require_relative "./dnd_spells/cli"
require_relative "./dnd_spells/api"
require_relative "./dnd_spells/spell"

require 'pry'
require 'httparty'
require 'tty-progressbar'
require 'tty-prompt'