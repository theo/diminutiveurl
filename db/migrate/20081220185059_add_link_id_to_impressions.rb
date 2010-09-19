class AddLinkIdToImpressions < ActiveRecord::Migration
  def self.up
    add_column :impressions, :link_id, :integer
  end

  def self.down
    remove_column :impressions, :link_id
  end
end
