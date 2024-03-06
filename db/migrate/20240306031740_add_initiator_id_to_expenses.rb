class AddInitiatorIdToExpenses < ActiveRecord::Migration[7.1]
  
  def change
    add_reference :expenses, :initiator, foreign_key: { to_table: :users }
  end
end
