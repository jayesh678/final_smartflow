class AddCompanyIdToBusinessPartners < ActiveRecord::Migration[7.1]
  def change
    add_reference :business_partners, :company, null: true, foreign_key: true
  end
end
