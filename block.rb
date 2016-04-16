module Makai
  class Block
    def self.get(name)
      @block_images ||= {}
      @block_images[name] || load_block(name)
    end

    def self.load_block(name)
      Gosu::Image.new("images/#{name}.png", tileable: true)
    end
  end
end
