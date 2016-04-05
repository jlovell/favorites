module EmojiHelper
  def self.image_for_rating(number)
    face = case number
    when 1 then "confounded"
    when 2 then "persevere"
    when 3 then "confused"
    when 4 then "smirk"
    when 5 then "yum"
    when 6 then "heart_eyes"
    end
    emojify(":#{face}:")
  end

  def self.emojify(content)
    content.to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img
          alt="#$1"
          src="#{ActionController::Base.helpers.image_path("emoji/#{emoji.image_filename}")}"
          style="vertical-align:middle; height: 2em; width: 2em;"
          class="emoji-icon" />).squish
      else
        match
      end
    end.html_safe if content.present?
  end
end
