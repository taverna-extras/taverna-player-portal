# Paperclip doesn't recognize t2flow files (obviously) and complains when you try and upload one
# https://github.com/thoughtbot/paperclip/issues/1429

require 'paperclip/media_type_spoof_detector'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end