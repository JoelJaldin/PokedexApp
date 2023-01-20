class PokedexController < ApplicationController
  def home
  end

  def fetch_pokemons(offset)
    @pokemons = []

    @pokemones = get_pokemons(offset)[:results]
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
    @pokemons
  end

  def index
    # Pagination
    if params[:page]
      offset = (params[:page].to_i-1)*9
      @pokemons = fetch_pokemons(offset)
      @pokemons = Kaminari.paginate_array(@pokemons, total_count: 1279).page(params[:page]).per(9)
    else
      @pokemons = fetch_pokemons(0)
      @pokemons = Kaminari.paginate_array(@pokemons, total_count: 1279).page(params[:page]).per(9)

    end
  end

  def show

    id = params[:id]
    response = HTTP.get("https://pokeapi.co/api/v2/pokemon/#{id}")
    response = JSON.parse response, symbolize_names: true
    @poki = {
      name: response[:species][:name],
      photo: response[:sprites][:other][:"official-artwork"][:front_default],
      abilities: response[:abilities],
      types: response[:types],
      weight: response[:weight],
      species_url: response[:species][:url]
    }


    response_species_fetch = HTTP.get(@poki[:species_url])
    species_hash = JSON.parse response_species_fetch, symbolize_names: true

    # Solution to pokemons without description and use the correct language
    if species_hash[:flavor_text_entries] != []
      @poki[:description] = species_hash[:flavor_text_entries].find{ |entry| entry[:language][:name] == "en" }[:flavor_text]
    else
      @poki[:description] = "no description"
    end

    # Solution to pokemons without "evolution"
    if species_hash[:evolution_chain] != nil
    evolution_url = species_hash[:evolution_chain][:url]
    response_evolution_fetch = HTTP.get(evolution_url)
    evolution_hash = JSON.parse response_evolution_fetch, symbolize_names: true
    @poki[:evolution] = evolution_hash
    else
    @poki[:evolution] = ""
    end
  end

  private

  def get_pokemons(offset)
    fetch_api = HTTP.get("https://pokeapi.co/api/v2/pokemon?limit=9&offset=#{offset}")
    api_hash = JSON.parse fetch_api, symbolize_names: true

  end
end
