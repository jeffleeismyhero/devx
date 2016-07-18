@schedules = Devx::Schedule.all

@schedules.try(:each) do |schedule|
  @duplicates = Devx::Schedule.where('start_time = ?', schedule.start_time)
  @duplicates.try(:each) do |duplicate|
    if schedule.event.name == duplicate.event.name
      if schedule.id != duplicate.id
        # duplicate.event.destroy
      end
    end
  end
end


## RESTORE
@restore = Devx::Schedule.with_deleted.each do |s|
  s.restore
end