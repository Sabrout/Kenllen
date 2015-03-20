class Admin < ActiveRecord::Base
	self.table_name = 'admins'
has_secured_password
end
