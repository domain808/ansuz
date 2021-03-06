module Ansuz
  module JAdams
    class FormFieldTextArea < ActiveRecord::Base
      has_one :form_field, :as => :field, :class_name => "Ansuz::JAdams::FormField"
      before_create :ensure_label
      has_settings

      protected
      def ensure_label
        self.label = "Field Label" unless self.label
      end
    end
  end
end
