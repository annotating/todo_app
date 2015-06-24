module TasksHelper

def tasks_completed(user)
	@tasks_completed = {};
	today =  DateTime.now.utc.in_time_zone('Pacific Time (US & Canada)').to_date

	num_days_entered = 0
	num_days_completed = 0

	date_statuses = {}
	tasks_entered_by_date = {}
	tasks_completed_by_date = {}

	# couldn't get postgre group query to work
	# so will do this the pleb way of manually summing counts

	tasks_entered = Task.where(user: user.id).select(:created_at, :completed_at)

	tasks_entered.each do |t| 
		d_created = t.created_at.to_date
		if (tasks_entered_by_date[d_created].blank?)
			tasks_entered_by_date[d_created] = 0;
		end;
		tasks_entered_by_date[d_created] += 1;
	end

	tasks_entered.each do |t| 
		if (t.completed_at.present?)
			d_completed = t.completed_at.to_date
			if (tasks_completed_by_date[d_completed].blank?)
				tasks_completed_by_date[d_completed] = 0;
			end;
			tasks_completed_by_date[d_completed] += 1;
		end
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
