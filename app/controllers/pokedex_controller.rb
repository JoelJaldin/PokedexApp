class PokedexController < ApplicationController
  def home

  end

  def index
    @pokemons = []
    @pokemones = get_pokemons[:results]
    @pokemones.each do |poke|
      response = HTTP.get(poke[:url])
      response = JSON.parse response, symbolize_names: true
      poki = {
        name: poke[:name],
        abilities: response[:abilities],
        types: response[:types],
        weight: response[:weight],
        photo: response[:sprites][:other][:"official-artwork"][:front_default],
        id: response[:id]
      }
      @pokemons << poki
    end
    puts @pokemons
    @pokemons = Kaminari.paginate_array(@pokemons).page(params[:page]).per(9)
  end

  def show

    id = params[:id]
    response = HTTP.get("https://pokeapi.co/api/v2/pokemon/#{id}")
    response = JSON.parse response, symbolize_names: true
    @poki = {
      name: response[:species][:name],
      photo: response[:sprites][:other][:dream_world][:front_default],
      abilities: response[:abilities],
      types: response[:types],
      weight: response[:weight],
      species_url: response[:species][:url]
    }


    response2 = HTTP.get(@poki[:species_url])
    response2 = JSON.parse response2, symbolize_names: true
    @poki[:description] = response2[:flavor_text_entries][0][:flavor_text]

    evolution_url = response2[:evolution_chain][:url]
    response3 = HTTP.get(evolution_url)
    response3 = JSON.parse response3, symbolize_names: true
    @poki[:evolution] = response3[:chain][:evolves_to]

  end

  private

  def get_pokemons
    response = HTTP.get('https://pokeapi.co/api/v2/pokemon?limit=27&offset=0')
    response = JSON.parse response, symbolize_names: true

  end
end
