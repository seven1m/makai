module Makai
  class Kai
    def initialize
      @parts = {}
      @walking = false
      @direction = :right
      @chopping = false
    end

    attr_accessor :walking
    attr_accessor :direction
    attr_accessor :chopping
    attr_accessor :item

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
      part_name = @item && mult == 1 ? "arm_with_#{@item}".to_sym : :arm
      scale_x = 0.5 * (@direction == :left ? -1 : 1)
      part(part_name).draw_rot(x + 16, y + 32, z, angle(:arm, mult), 0.5, 0, scale_x, 0.5)
    end

    def draw_leg(x, y, z, mult)
      part(:leg).draw_rot(x + 16, y + 60, z, angle(:leg, mult), 0.5, 0, 0.5, 0.5)
    end

    def angle(part, mult)
      if chopping && part == :arm
        chopping_angle(mult)
      elsif walking
        walking_angle(mult)
      else
        0
      end
    end

    def chopping_frames
      @chopping_frames ||= (-180..0).to_a
    end

    def chopping_angle(mult)
      return 0 if mult == -1 # background hand does nothing
      frame = (Gosu.milliseconds / 2 % chopping_frames.size).floor
      chopping_frames[frame] * (direction == :right ? 1 : -1)
    end

    def walking_frames
      @walking_frames ||= (-44..45).to_a + (-45..44).to_a.reverse
    end

    def walking_angle(mult)
      frame = (Gosu.milliseconds / 5 % walking_frames.size).floor
      walking_frames[frame] * mult
    end

    def part(name)
      @parts[name] ||= Gosu::Image.new("images/characters/player_male/male_#{name}.png")
    end
  end
end
