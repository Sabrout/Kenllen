class Admin < ActiveRecord::Base
	self.table_name = 'admins'
has_secure_password
end
