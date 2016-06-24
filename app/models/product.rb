class Product < ActiveRecord::Base
	mount_uploader :attachment, AttachmentUploader #tells rails to use this uploader for this model
	belongs_to :category
	validates_presence_of :name, :price, :weight, :sku, :description

	has_many :line_items
	before_destroy :ensure_not_referenced_by_any_line_item

	private

		# ensure that there are no line items referencing this product
		def ensure_not_referenced_by_any_line_item
			if line_items.empty?
				return true
			else
				errors.add(:base, 'Line Items present')
				return false
			end
		end
end
