class CreateTicketTags < ActiveRecord::Migration[6.0]
  def change
    create_table :ticket_tags do |t|
      t.references :ticket, :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
