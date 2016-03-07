# Set pin command
class User::Command::PinSetCommand < Core::Command
  attr_accessor :pin

  validates :pin, presence: true
  validates :pin, length: { is: 4 }
  validates :pin, format: { with: /\d{4}/,
                            message: 'has wrong format' }

  # Runs command
  def execute
    user = User::User.get_user_by_token_code(token, User::Token::TYPE_LOGIN)
    user.pin = pin
    user.save
    nil
  end
end