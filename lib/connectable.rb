require 'active_support/core_ext/object/try'
require 'active_support/core_ext/object/blank'

module GeekGame
  module Connectable
    DIRECTION_PRECISION = 1.degrees

    attr_reader :connection

    def connect_to(facility)
      return connection if connection
      return nil unless can_connect_to?(facility)
      Connection.new bot: self, facility: facility
    end

    def disconnect
      return unless connection
      connection.close
    end

    def connected_facility
      connection.try(:facility)
    end

    def connected_to_facility?
      connection.present?
    end

    def can_connect_to?(facility)
      close_enough_to?(facility) && directed_towards?(facility)
    end

    def close_enough_to?(facility)
      position.distance_to(facility.position) <= facility.connection_distance
    end

    def directed_towards?(facility)
      normalized_movement_vector.angle_with(vector_to(facility)) <= DIRECTION_PRECISION
    end

    # This method is to be called only by Connection
    def connection_established(connection)
      self.connection = connection
    end

    # This method is to be called only by Connection
    def connection_closed
      self.connection = nil
    end

    protected

    attr_writer :connection
  end
end
