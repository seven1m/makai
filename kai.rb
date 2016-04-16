module Makai
  class Kai
    def initialize
      @parts = {}
      @walking = false
      @direction = :right
    end

    attr_accessor :walking
    attr_accessor :direction

    def draw(x, y, z)
      draw_head(x, y, z + 3)
      draw_body(x, y, z + 2)
      draw_arm(x, y, z + 1, -1)
      draw_arm(x, y, z + 4, 1)
      draw_leg(x, y, z + 1, 1)
      draw_leg(x, y, z + 3, -1)
    end

    private

    def draw_head(x, y, z)
      if direction == :left
        part(:head).draw(x, y, z, 0.5, 0.5)
      else
        part(:head).draw(x + 32, y, z, -0.5, 0.5)
      end
    end

    def draw_body(x, y, z)
      part(:body).draw(x + 5, y + 32, z, 0.5, 0.5)
    end

    def draw_arm(x, y, z, mult)
      part(:arm).draw_rot(x + 16, y + 32, z, angle(mult), 0.5, 0, 0.5, 0.5)
    end

    def draw_leg(x, y, z, mult)
      part(:leg).draw_rot(x + 16, y + 60, z, angle(mult), 0.5, 0, 0.5, 0.5)
    end

    def angle_frames
      @angle_frames ||= (-44..45).to_a + (-45..44).to_a.reverse
    end

    def angle(mult)
      return 0 unless walking
      frame = (Gosu.milliseconds / 5 % 180).floor
      angle_frames[frame] * mult
    end

    def part(name)
      @parts[name] ||= Gosu::Image.new("images/characters/player_male/male_#{name}.png")
    end
  end
end
