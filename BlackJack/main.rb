require_relative 'card'
require_relative 'deck'
require_relative 'game'
require_relative 'interface'
require_relative 'player'
require_relative 'robot'

interface = Interface.new
Game.new(interface)
