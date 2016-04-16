require_relative '../block'

module Makai
  module Maps
    class Morgantown
      def initialize
        @tiles = [
          [],
          [nil, nil, nil,                 nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,            'tiles/leaves'],
          [nil, nil, nil,                 nil, nil, nil, nil, nil, nil, nil, nil, nil, 'tiles/leaves', 'tiles/leaves', 'tiles/leaves'],
          [nil, nil, nil,                 nil, nil, nil, nil, nil, nil, nil, nil, nil, 'tiles/leaves', 'tiles/leaves', 'tiles/leaves'],
          [nil, nil, 'tiles/cactus_top',  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 'tiles/trunk_mid'],
          [nil, nil, 'tiles/cactus_side', nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 'tiles/trunk_bottom'],
          ['tiles/dirt_grass'] * 100,
          ['tiles/dirt'] * 100
        ]
      end

      attr_reader :tiles

      def background
        'other/skybox_sidehills'
      end
    end
  end
end
