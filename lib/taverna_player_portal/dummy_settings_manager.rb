# For testing

module TavernaPlayerPortal

  class DummySettingsManager

    attr_accessor :hash

    DEFAULT_SETTINGS_PATH = Rails.root.join('config', 'settings.yml.example')

    def load
      @hash ||= YAML.load_file(DEFAULT_SETTINGS_PATH)
      TavernaPlayerPortal.settings = OpenStruct.new(@hash)
    end

    def save
      load
    end

    def reset
      @hash = nil
      load
    end

  end

end
