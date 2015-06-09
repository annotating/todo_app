module TasksHelper

def tasks_completed(user)
	@tasks_completed = {};
	today =  Date.today.to_formatted_s(:db)

	num_days_entered = 0;
	num_days_completed = 0;

	date_statuses = {};

	tasks_entered_by_date = 	Task.where(user: user.id).group("DATE(created_at)").count
	tasks_completed_by_date = 	Task.where(user: user.id).group("DATE(completed_at)").count 

	if (!tasks_entered_by_date.blank?)
		tasks_entered_by_date.each do |date,count|
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
