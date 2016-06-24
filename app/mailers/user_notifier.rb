class UserNotifier < ApplicationMailer
	default :from => 'marko.manojlovic.bg@gmail.com'

	# send a signup email to the user, pass in the user object that contains the user email address
	def send_signup_email(user)
		@user = user
		mail( :to => @user.email,
			:subject => 'Thanks for signing up for Grassy'
		)
	end

	# send an email when a purchase has been made
	def send_order_confirmation(order)
		#@user = user
		@order = order
		mail(
			:to => @order.user.email,
			:bcc => 'mmanojlovic@cesgroup.ca',
			:subject => 'Grassy Order Confirmation'
		)  
		
	end

	#def send_purcase_email(user)
	#	@user = user
	#	mail( :to => @user.email,
	#		:subject => 'Order Confirmation'
	#	)
	#end

end
