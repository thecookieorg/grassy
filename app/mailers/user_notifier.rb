class UserNotifier < ApplicationMailer
	default :from => 'hello@grassy.ca'

	# send a signup email to the user, pass in the user object that contains the user email address
	def send_signup_email(user)
		@user = user
		#attachments['grassy_membership_card.pdf'] = File.read('path/to/file.pdf')
		mail( :to => @user.email,
			:subject => 'Thanks for signing up for Grassy'
		)
	end

	def send_signup_email_to_grassy_owner(user)
		@user = user
		grassy_owner = 'hello@grassy.ca'
		mail( :to => grassy_owner,
			:subject => 'New user have registered on Grassy!'
		)
	end

	# send an email when a purchase has been made
	def send_order_confirmation(order)
		#@user = user
		@order = order
		mail(
			:to => @order.user.email,
			:subject => 'Grassy Order Confirmation'
		)  
		
	end

	# send an email when a purchase has been made
	def send_order_confirmation_to_grassy_owner(order)
		#@user = user
		grassy_owner = 'hello@grassy.ca'
		@order = order
		mail(
			:to => grassy_owner,
			:subject => 'New Order on Grassy'
		)  
		
	end

	#def send_purcase_email(user)
	#	@user = user
	#	mail( :to => @user.email,
	#		:subject => 'Order Confirmation'
	#	)
	#end

end
