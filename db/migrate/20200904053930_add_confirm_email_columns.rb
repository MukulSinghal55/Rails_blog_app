class AddConfirmEmailColumns < ActiveRecord::Migration[5.0]
  def change
      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
  end
end
