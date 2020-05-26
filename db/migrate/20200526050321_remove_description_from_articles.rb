class RemoveDescriptionFromArticles < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :description
  end
end
