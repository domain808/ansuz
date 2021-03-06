module Ansuz
  class PluginManager
    attr_accessor :plugins, :plugin_nav, :admin_plugin_nav, :admin_menu, :admin_menu_top_level_entries, :page_types
    ADMIN_MENU_TOP_LEVEL_ENTRIES = ["Create", "Manage", "Ansuz"]

    def initialize
      @plugins = []
      @plugin_nav = []
      @admin_plugin_nav = []
      @admin_menu = {}
      @admin_menu_top_level_entries = ADMIN_MENU_TOP_LEVEL_ENTRIES.clone
      @page_types = []
      setup_admin_menu
    end

    # A plugin can call register_plugin(ClassName) to add itself to the plugins array
    def register_plugin klass
      self.plugins << klass
    end

    # A plugin can call register_plugin_nav(title, link) to add itself to the
    # user-facing navigation menu
    def register_plugin_nav title, link
      self.plugin_nav << [title, link]
    end

    # A plugin can call register_admin_plugin_nav(title, link) to add itself to the
    # admin-facing navigation menu
    def register_admin_plugin_nav title, link
      self.admin_plugin_nav << [title, link]
      # We're going to register plugins that use the old naming convention just underneath 
      # the Add-Ons dropdown.  They can use the register_admin_menu_entry method if they want finer-grained control.
      register_admin_menu_entry "Add-ons", title, link
    end

    def register_admin_menu_entry top_level_menu_name, text, link, options={}
      raise "There was an attempt to add a link to the admin menu with a non-existent top level menu entry as parent." unless admin_menu_top_level_entries.include?(top_level_menu_name)
      self.admin_menu[top_level_menu_name] << [text, link, options]
    end

    def add_top_level_menu_entry name
      @admin_menu_top_level_entries << name unless @admin_menu_top_level_entries.include?(name)
      @admin_menu[name] = []
    end

    # The admin menu is just a hash with an array for sub menus for now.
    def setup_admin_menu
      ADMIN_MENU_TOP_LEVEL_ENTRIES.each do |menu_entry|
        add_top_level_menu_entry menu_entry
      end
    end

    def register_page_type name, modules=[]
      @page_types << [name, modules]
    end
  end
end
