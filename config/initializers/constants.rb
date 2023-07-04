# frozen_string_literal: true

class RegexConstant
  PASSWORD_FORMAT = /\A
    (?=.{8,})          # Must contain 8 or more characters
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  YOUTUBE_URL_FORMAT = %r{\Ahttps://?(?:www\.)?youtube\.com/watch\?v=(?<video_id>.+)}
end

class SideKiqQueue
  FETCH_VIDEO_INFO = 'fetch_video_info'
end
