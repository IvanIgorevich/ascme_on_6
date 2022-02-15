class AddDefaultColorToUser < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :color, from: nil, to: "#005a55"
  end
end
