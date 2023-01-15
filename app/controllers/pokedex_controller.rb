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
        photo: response[:sprites][:other][:"official-artwork"][:front_default]
      }
      @pokemons << poki
    end
    puts @pokemons
    @pokemons
  end

  def show
  end

  private

  def get_pokemons

    response = HTTP.get('https://pokeapi.co/api/v2/pokemon?limit=10&offset=0')
    response = JSON.parse response, symbolize_names: true

  end
end
