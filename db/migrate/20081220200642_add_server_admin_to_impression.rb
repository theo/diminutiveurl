class AddServerAdminToImpression < ActiveRecord::Migration
  def self.up
    add_column :impressions, :server_admin, :string
  end

  def self.down
    remove_column :impressions, :server_admin
  end
end
