class User < ActiveRecord::Base
  before_save { email.downcase! }
  validates :name, length: { maximum: 128 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false}
  has_secure_password
  validates :password, length: { minimum: 6 }
  before_create :create_remember_token, :create_web_page
  has_one :web_page

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

    def create_web_page
      build_web_page
    end
end
