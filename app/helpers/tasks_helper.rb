module TasksHelper

def tasks_completed(user)
	@tasks_completed = {};
	today =  Date.today.to_formatted_s(:db)

	num_days_entered = 0
	num_days_completed = 0

	date_statuses = {}
	tasks_entered_by_date = {}
	tasks_completed_by_date = {}

	tasks_entered = Task.where(user: user.id)
								.select("DATE(created_at) as date")
								.group(:created_at)
	# couldn't get postgre query to work...
	# so we will do this the ultra pleb way
	tasks_entered.each do |t| 
		if (tasks_entered_by_date[t.date].blank?)
			tasks_entered_by_date[t.date] = 0;
		end;
		tasks_entered_by_date[t.date] += 1;
	end

	tasks_completed= Task.where(user: user.id)
								.select("DATE(completed_at) as date")
								.group(:completed_at) 
	tasks_completed.each do |t|
		if (tasks_completed_by_date[t.date].blank?)
			tasks_completed_by_date[t.date] = 0;
		end;
		tasks_completed_by_date[t.date] += 1;
	end

	if (!tasks_entered_by_date.blank?)
		tasks_entered_by_date.each do |date, count|
			next if date == today
			num_days_entered += 1
			
			if (count == tasks_completed_by_date[date])
				num_days_completed += 1
				date_statuses[date] = true
			else
				date_statuses[date] = false
			end
		end
	end

	@tasks_completed[:date_statuses] = date_statuses;
	@tasks_completed[:days_count] = num_days_completed.to_s + "/" + num_days_entered.to_s 

	@tasks_completed
end

end
