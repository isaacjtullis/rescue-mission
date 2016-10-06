class AddUserIdToQuestions < ActiveRecord::Migration[5.0]
  def up
    add_column(:questions, :user_id, :integer)
  end

  def down
    remove_column(:questions, :user_id)
  end
end
