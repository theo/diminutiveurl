class AddServerAddrToImpression < ActiveRecord::Migration
  def self.up
    add_column :impressions, :server_addr, :string
  end

  def self.down
    remove_column :impressions, :server_addr
  end
end
