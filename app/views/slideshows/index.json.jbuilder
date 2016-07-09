json.array!(@slideshows) do |slideshow|
  json.extract! slideshow, :id, :image_1, :image_2, :image_3, :image_4
  json.url slideshow_url(slideshow, format: :json)
end
