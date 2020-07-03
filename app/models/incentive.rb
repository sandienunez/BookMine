class Incentive < ActiveRecord::Base 
    has_many :books
    has_secure_password 
end