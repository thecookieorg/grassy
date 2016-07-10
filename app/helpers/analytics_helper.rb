module AnalyticsHelper
	def stats_dashboard_index
		if Rails.env.production?
			line_chart @users.group_by_day(:created_at).count
		else
			line_chart @users.group(:created_at).count
		end
	end
end