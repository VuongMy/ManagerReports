module UsersHelper
	require 'securerandom'

	def rand
		random_string = SecureRandom.base64(5)
	end
end
