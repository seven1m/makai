require 'bundler'
Bundler.require

require_relative './block'
require_relative './kai'
require_relative './maps/morgantown'

module Makai
  class Window < Gosu::Window
    def initialize
      super(640, 512)
      self.caption = 'Makai'
      @block_images = {}
      @player = Kai.new
      @player_x = 5 * 64
      @player_y = 300
      @window_x = 0
      @window_y = 0
      @map = Maps::Morgantown.new
    end

    def update
      if Gosu.button_down?(Gosu::KbLeft)
        if @player_x > 0
          @player_x -= 2
          @player.direction = :left
          @player.walking = true
        end
      elsif Gosu.button_down?(Gosu::KbRight)
        @player_x += 2
        @player.direction = :right
        @player.walking = true
      else
        @player.walking = false
      end
      if @player_x >= (6 * 64)
        @window_x += 2
        @player_x -= 2
      elsif @player_x < (4 * 64)
        if @window_x > 0
          @window_x -= 2
          @player_x += 2
        end
      end
    end

    def draw
      block(@map.background).draw(0, -1, 1, 1.3)
      frame_x = (@window_x / 64).floor
      frame_y = 0
      @map.tiles[frame_y..(frame_y + 512)].each_with_index do |row, y|
        tiles = row[frame_x..(frame_x + 10)]
        next if tiles.nil?
        tiles.each_with_index do |block, x|
          x_real = (x * 64) - (@window_x % 64).floor
          next if block.nil?
          block(block).draw(x_real, y * 64, 2, 0.5, 0.5)
        end
      end
      @player.draw(@player_x, @player_y, 3)
    end

    private

    def draw_block(name, x, y, z)
      x *= 64
      y *= 64
      block(name).draw(x, y, z, 0.5, 0.5)
    end

    def block(name)
      Block.get(name)
    end
  end
end

window = Makai::Window.new
window.show
