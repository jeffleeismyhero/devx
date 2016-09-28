class ActsAsTaggableOn::Tag
  has_many :taggings
  has_many :children, class_name: 'Tag', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Tag', foreign_key: 'parent_id'
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category', foreign_key: 'parent_id'

  accepts_nested_attributes_for :taggings, allow_destroy: true,
    reject_if: proc {|a| a['taggable_type'].blank?}

  scope :primary, -> { where("tags.parent_id IS NULL") }

  remove_unused_tags = true
end

class Tag < ActsAsTaggableOn::Tag
  remove_unused_tags = true
end
