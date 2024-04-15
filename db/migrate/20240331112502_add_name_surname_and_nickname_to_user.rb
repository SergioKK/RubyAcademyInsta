class AddNameSurnameAndNicknameToUser < ActiveRecord::Migration[7.1]
  def change
    change_table :users do |t|
      t.string :name
      t.string :surname
      t.string :nickname
    end
  end
end
