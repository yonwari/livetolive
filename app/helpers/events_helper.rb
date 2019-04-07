module EventsHelper
  # 芸人タグをリンク化
  def render_with_hashtags(content)
    content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/events/comedian/#{word.delete("#")}"}.html_safe
  end 
end
