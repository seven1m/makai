# rubocop:disable Style/LineLength

module Makai
  module Maps
    class Morgantown
      def initialize
        @tiles = [
          %w(),
          %w(.   .   .   .   .   .   .   .   .   .   .   .   .   ll                                                                                                                                                                    ),
          %w(.   .   .   .   .   .   .   .   .   .   .   .   ll  ll  ll                                                                                                                                                                ),
          %w(.   .   .   .   .   .   .   .   .   .   .   .   ll  ll  ll                                                                                                                                                                ),
          %w(.   .   ct  .   .   .   .   .   .   .   .   .   .   tm1                                                                                                                                                                   ),
          %w(.   .   cs  .   .   .   .   .   .   .   .   .   .   tb                                                                                                                                                                    ),
          %w(dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg  dg),
          %w(dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd  dd)
        ]
        @damage = {}
      end

      attr_reader :tiles

      def background
        'other/skybox_sidehills'
      end

      def item(id)
        {
          '1' => :pickaxe
        }[id]
      end

      BREAK_AMOUNT = 50

      def damage(x, y)
        y -= 1 if @tiles[y][x] == '.' && !['.', nil].include?(@tiles[y - 1][x])
        @damage[[x, y]] ||= 0
        @damage[[x, y]] += 1
        return if @damage[[x, y]] < BREAK_AMOUNT
        block = @tiles[y][x]
        @tiles[y][x] = '.'
        @damage[[x, y]] = 0
        if block && block.size == 3
          item(block[-1])
        end
      end
    end
  end
end
