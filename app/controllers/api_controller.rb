class ApiController < ApplicationController
	skip_before_filter :verify_authenticity_token

  def index
  end

  def usarApi #Este metodo reciben los parámetros, y retorna lo pedido por el enunciado
  	tag = params[:tag].to_s
	token = params[:access_token].to_s
	if (tag!=nil && token !=nil)
				render json: {
							metadata: {
								total: obtenerCantidad(tag, token).to_i
								},

							posts: obtenerInformacion(tag, token),
							version: "1.0" #TODO: Cambiar
							}, status: 200

	else
		render json: {Error: "Parámetros mal ingresados"}, status: 400
  	end
  end

  def obtenerCantidad(tag, token)
  	url = "https://api.instagram.com/v1/tags/#{tag}?access_token=#{token}"
  	result = HTTParty.get(url)
  	cantidad = result['data']['media_count']
  	return cantidad
  end

  def obtenerInformacion(tag, token)
  	url = "https://api.instagram.com/v1/tags/#{tag}/media/recent?access_token=#{token}"
  	result = HTTParty.get(url)
  	todaLaInfo = []
    todasLasFotos = result['data']
    todasLasFotos.each do |foto|
    	infoFoto = {
    		tags: foto["tags"],
			username: foto["user"]["username"].to_s,
			likes: foto["likes"]["count"].to_i,
			url: foto["images"]["standard_resolution"]["url"].to_s,
			caption: foto["caption"]["text"].to_s, 
			version: "1.0"
			}
		todaLaInfo.append(infoFoto)
	end
	return todaLaInfo
  end
end
