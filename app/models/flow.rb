class Flow < ApplicationRecord
  has_many :expenses, dependent: :destroy


  validates :user_assigned_id, presence: true
  validates :assigned_user_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_cannot_be_before_start_date

  private

  def end_date_cannot_be_before_start_date
    if end_date.present? && start_date.present? && end_date < start_date
      errors.add(:end_date, "cannot be before start date")
    end
  end
  
  # def self.create_default_flow
  #   Flow.create(default: true)
  # end
end
