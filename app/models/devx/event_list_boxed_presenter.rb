module Devx
  class EventListBoxedPresenter
    def self.for
      :event_list_boxed
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
        calendar: calendar,
        events: get_events,
        limit: @attributes[:limit]
      }
    end


    private

    def calendar
      Devx::Calendar.find_by(id: @attributes[:id])
    end

    def get_events
      schedules = Devx::Schedule.upcoming.ordered
      schedules = resequence_schedules(schedules)
      schedules = schedules.sort_by{ |s| s.start_time }
      schedules = schedules.try(:first, @attributes[:limit])
      return schedules
    end

    # Advances all `start_time` values to the current date or the next
    # occurrence of `days` unless the end date has passed
    def resequence_schedules(schedules)
      schedules.collect do |schedule|
        current_date = Time.zone.now.to_date
        next_occurrence = nil
        days = schedule.days.reject(&:blank?)
        if days.any?
          day_indexes = days.collect{ |d| Date::DAYNAMES.index(d) }
          current_day = current_date.strftime("%A")
          current_day_index = Date::DAYNAMES.index(current_day)
          until next_occurrence
            if day_indexes.index(current_day_index)
              next_occurrence = current_date
            else
              current_day_index = (current_day_index + 1 > 6) ? 0 : current_day_index + 1
              current_date = Time.zone.now.to_date + 1.day
            end
          end
        else
          next_occurrence = current_date
        end

        if schedule.start_time.to_date < next_occurrence
          advance = (Time.zone.now.to_date - schedule.start_time.to_date).to_i
          schedule.start_time = schedule.start_time.advance(days: advance)
        end

        # Do not return any schedules where the next time would be past the
        # `end_time` value.
        (schedule.start_time < schedule.end_time) ? schedule : nil
      end.compact
    end
  end
end
