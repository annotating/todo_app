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
								.select("COUNT(DATE(created_at)) as num_created, DATE(created_at) as date")
								.group("DATE(created_at)") 
	tasks_entered.each do |task|
		tasks_entered_by_date[task.date] = task.num_created
	end

	tasks_completed= Task.where(user: user.id)
								.select("COUNT(DATE(completed_at)) as num_completed, DATE(completed_at) as date")
								.group("DATE(completed_at)") 
	tasks_completed.each do |task|
		tasks_completed_by_date[task.date] = task.num_completed
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
