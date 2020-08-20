class ChangeAssigneeToAssigneeId < ActiveRecord::Migration[6.0]
  def change
    rename_column :tickets, :assignee, :assignee_id
  end
end
