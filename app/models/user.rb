class User < ActiveRecord::Base
  # validates :username, presence: true, length: { minimum: 3, maximum: 16 }
  has_attached_file :avatar, styles: { medium: '152x152#' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :comments, dependent: :destroy
end
