require 'bundler'
Bundler.require

require_relative './kai'

module Makai
  class Window < Gosu::Window
    def initialize
      super(640, 512)
      self.caption = 'Makai'
      @block_images = {}
      @player = Kai.new
      @player_x = 250
      @player_y = 300
    end

    def update
      if Gosu.button_down?(Gosu::KbLeft)
        @player_x -= 1
        @player.direction = :left
        @player.walking = true
      elsif Gosu.button_down?(Gosu::KbRight)
        @player_x += 1
        @player.direction = :right
        @player.walking = true
      else
        @player.walking = false
      end
    end

    def draw
      block('other/skybox_sidehills').draw(0, -1, 1, 1.3)
      (0..9).each do |x|
        draw_block('tiles/dirt_grass', x, 6, 2)
        draw_block('tiles/dirt',       x, 7, 2)
        draw_block('tiles/dirt',       x, 8, 2)
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
      @block_images[name] || load_block(name)
    end

    def load_block(name)
      Gosu::Image.new("images/#{name}.png", tileable: true)
    end
  end
end

window = Makai::Window.new
window.show
