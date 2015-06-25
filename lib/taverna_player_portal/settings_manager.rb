require 'yaml'

module TavernaPlayerPortal

  class SettingsManager

    attr_accessor :hash

    SETTINGS_PATH = Rails.root.join('config', 'settings.yml')
    DEFAULT_SETTINGS_PATH = Rails.root.join('config', 'settings.yml.example')

    def load
      self.class.copy_defaults unless File.exist?(SETTINGS_PATH)

      @hash = YAML.load_file(SETTINGS_PATH)
      TavernaPlayerPortal.settings = OpenStruct.new(@hash)
    end

    def save
      File.write(SETTINGS_PATH, @hash.to_yaml)
      load
    end

    def reset
      self.class.copy_defaults
      load
    end

    private

    def self.copy_defaults
      FileUtils.cp(DEFAULT_SETTINGS_PATH, SETTINGS_PATH)
    end
  end

end
