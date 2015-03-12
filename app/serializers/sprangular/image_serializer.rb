module Sprangular
  class ImageSerializer < BaseSerializer
    attributes :id, :position, :attachment_content_type, :attachment_file_name,
               :type, :attachment_updated_at, :attachment_width,
               :attachment_height, :alt, :viewable_type, :viewable_id


    def attributes
      super.tap do |attrs|
        image_styles.each_key do |style|
          attrs["#{style}_url"] = object.attachment.url(style)
        end
      end
    end

    private

    def image_styles
      Spree::Image.attachment_definitions[:attachment][:styles]
    end
  end
end
