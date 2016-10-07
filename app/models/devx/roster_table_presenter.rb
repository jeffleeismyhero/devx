module Devx
  class RosterTablePresenter
    def self.for
      :roster_table
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
    end

    def content
      @content
    end

    def attributes
      {
        roster: roster
      }
    end


    private

    def roster
      Devx::SportTeam.where(sport_id: @attributes[:id]).order(jersey_number: :asc)
    end
  end
end
