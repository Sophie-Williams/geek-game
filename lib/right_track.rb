module GeekGame
  class RightTrack < Track
    def position
      axis_unit_vector = Vector(1, 0).rotate(bot.angle)
      bot.position.advance_by(axis_unit_vector * (TrackedBot::AXIS_LENGTH / 2))
    end
  end
end
