class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :timeoutable, :timeout_in => 2.hours


  has_many :shared_files, as: :fileable
  has_many :notices, as: :owner

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :actions
  has_many :shared_files, as: :fileable
  has_many :notices 
end
