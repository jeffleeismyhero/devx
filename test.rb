@schedules = Devx::Schedule.all

@schedules.try(:each) do |schedule|
  @duplicates = Devx::Schedule.where('start_time = ?', schedule.start_time)
  @duplicates.try(:each) do |duplicate|
    if schedule.event.name == duplicate.event.name
      if schedule != duplicate
        puts "deleting #{schedule.inspect} for #{duplicate.inspect}"
      end
    end
  end
end