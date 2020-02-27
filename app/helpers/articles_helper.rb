module ArticlesHelper

  def find_article_last_version article
    if article.versions.length > 0
      version = article.versions.last.reify
      article = [version.price_cost, version.updated_at.strftime("%d/%m/%Y")].join(" - ") 
    else
      article = ''
    end
    article
  end
end
