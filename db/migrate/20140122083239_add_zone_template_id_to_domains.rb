class AddZoneTemplateIdToDomains < ActiveRecord::Migration
  def change
    add_column :domains, :zone_template_id, :integer
  end
end
