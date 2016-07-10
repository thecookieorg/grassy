module AnalyticsHelper
	def stats_dashboard_index 
		if Rails.env.production?
			line_chart @users.group_by_day(:created_at).count, label: "Visits", colors: ["#18bc9c"]
		else
			line_chart @users.group(:created_at).count, label: "Visits", colors: ["#18bc9c"]
		end
	end
end