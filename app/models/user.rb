class User < ActiveRecord::Base

  before_save :downcase_email
  before_save :capitalize_name

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, length: { minimum: 6 }, presence: true, unless: :password_digest
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }
  has_secure_password

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def capitalize_name
    if name
      names = []
      name.split.each do |name_part|
        names << name_part.capitalize
      end
      self.name = names.join(" ")
    end
  end
end
