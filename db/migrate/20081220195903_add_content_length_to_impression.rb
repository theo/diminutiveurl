class AddContentLengthToImpression < ActiveRecord::Migration
  def self.up
    add_column :impressions, :content_length, :string
  end

  def self.down
    remove_column :impressions, :content_length
  end
end
