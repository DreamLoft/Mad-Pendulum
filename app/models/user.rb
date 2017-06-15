class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :recoverable,
         :trackable, :validatable, :registerable,:rememberable
        # :omniauthable

  # note that this include statement comes AFTER the devise block above
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable , :zxcvbnable
   self.per_page = 10

   def active_for_authentication?
  super && approved?
end

def inactive_message
  if !approved?
    :not_approved
  else
    super # Use whatever other message
  end
end


def self.send_reset_password_instructions(attributes={})
  recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
  if !recoverable.approved?
    recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
  elsif recoverable.persisted?
    recoverable.send_reset_password_instructions
  end
  recoverable
end

validates :username, presence: true
validates :employee_id, presence: true

end
