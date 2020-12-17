require_relative "./dnd_spells/version"

module DndSpells
  class Error < StandardError; end
  # Your code goes here...
end

require 'pry'
require 'httparty'
require 'tty-progressbar'
require 'tty-prompt'
require 'tty-table'
require 'pastel'

require_relative "./dnd_spells/cli"
require_relative "./dnd_spells/api"
require_relative "./dnd_spells/spell"

