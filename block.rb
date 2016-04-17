module Makai
  class Block
    BLOCK_ABBREVIATIONS = {
      'll' => 'tiles/leaves',
      'tm' => 'tiles/trunk_mid',
      'tb' => 'tiles/trunk_bottom',
      'ct' => 'tiles/cactus_top',
      'cs' => 'tiles/cactus_side',
      'dg' => 'tiles/dirt_grass',
      'dd' => 'tiles/dirt'
    }.freeze

    def self.get(name)
      @block_images ||= {}
      @block_images[name] || load_block(name)
    end

    def self.load_block(name)
      name = name[0..1] if name.size == 3
      name = BLOCK_ABBREVIATIONS[name] if name.size == 2
      Gosu::Image.new("images/#{name}.png", tileable: true)
    end
  end
end
