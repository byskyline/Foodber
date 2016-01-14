json.array! @articles do |article|

  json.tags                  article.tags.map(&:name)
  json.topic                 article.topic
  json.price                 article.price
  json.photo_original_url    asset_url(article.logo.url)
  json.photo_medium_url      asset_url(article.logo.url(:medium))
  json.photo_thumb_url       asset_url(article.logo.url(:thumb))

end