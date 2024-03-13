class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  before_create :generate_company_code
  before_create :generate_uniqueid
  has_many :business_partners
  # attr_accessor :company_code

  private

  def generate_company_code
    self.company_code = SecureRandom.hex(4).upcase # Generates a random hexadecimal code of length 4
  end

  def generate_uniqueid
    self.company_uniqueid = SecureRandom.hex(4) 
  end
end
