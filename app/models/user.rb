class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  with_options presence: true do
    validates :channel_name
    validates :subscribers_num
    validates :channel_url
    validates :what_channel
  end

  validates :subscribers_num, numericality: {
    less_than_or_equal_to: 9999,
    message: 'が10000人以上の方はご利用いただけません'
  }

  validates :subscribers_num, numericality: {
    with: /\A[0-9]+\z/, message: 'は半角数字のみ入力可能です'
  }
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は文字と数字の両方を含めてください', :on => :create

#  with_options if: 'password || new_record?' do |user|
#    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
#    validates_format_of :password, with: PASSWORD_REGEX, message: 'は文字と数字の両方を含めてください'
#  end
  
  def update_without_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    
    result = update_attributes(params, *options)
    result = self.save(validate: false)
    clean_up_passwords
    result
  end


end
