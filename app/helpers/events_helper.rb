module EventsHelper
  # 芸人タグをリンク化
  def render_with_hashtags(content)
    content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, { controller: :events, action: :index, q:{ comedianlist_cont: :"#{word}" }} }.html_safe
  end
end
