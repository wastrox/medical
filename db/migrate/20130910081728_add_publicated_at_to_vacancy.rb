class AddPublicatedAtToVacancy < ActiveRecord::Migration
  def change
    add_column :vacancies, :publicated_at, :datetime, :default => Time.now
  end
end
