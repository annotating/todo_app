class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :default_values

  validates :email, presence: true
  validates :alias, presence: true, length: { maximum: 25 }
  validates :blurb, length: { maximum: 1000 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks, dependent: :destroy

  def default_values
    self.alias ||= 'Unnamed User'
  end
end
