module ApplicationHelper

  def gravatar_for(user, options = {size: 80})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "profile-pic")
  end

  def edit_button
    if logged_in? && (@user == current_user || current_user.admin?)
      link_to 'Edit', edit_article_path, class: "btn btn-orange float-left ml-5 my-3"
    end
  end

  def delete_button
    if logged_in? && (@user == current_user || current_user.admin?)
      link_to 'Delete', article_path, class: "btn btn-red float-right mr-5 my-3", method: :delete, data: {confirm: "Are you sure?"}
    end
  end

end
