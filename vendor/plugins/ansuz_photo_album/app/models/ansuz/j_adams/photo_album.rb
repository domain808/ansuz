module Ansuz
  module JAdams
    class PhotoAlbum < ActiveRecord::Base
      validates_presence_of :name
      validates_uniqueness_of :name

      has_many :photos, :class_name => "Ansuz::JAdams::PhotoAlbumPhoto", :dependent => :destroy

      def edit_path
        "/admin/photo_albums/#{id}"
      end

      def self.view_partial
        "/photo_albums/photo_album"
      end

      def self.admin_partial
        "/admin/photo_albums/photo_album"
      end
    end
  end
end
