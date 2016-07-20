events = Devx::Event.all

events.try(:each) do |event|
  if !event.check_for_duplicates
    duplicates = Devx::Event.where(name: event.name)

    duplicates.try(:each) do |duplicate|
      if event != duplicate
        duplicate.schedules.try(:each) do |dup_schedule|
          event.schedules.try(:each) do |schedule|
            if schedule.start_time == dup_schedule.start_time
              duplicate.destroy
            end
          end
        end
      end
    end
  end
end