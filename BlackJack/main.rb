require_relative 'card'
require_relative 'deck'
require_relative 'game'
require_relative 'interface'
require_relative 'player'
require_relative 'robot'
require_relative 'hand'

interface = Interface.new
Game.new(interface)
