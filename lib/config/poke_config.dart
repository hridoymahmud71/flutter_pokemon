class PokeConfig {
  var _listing_url = "//pokeapi.co/api/v2/pokemon/";
  var _placeholder_url = "//via.placeholder.com/";

  static getListingUrl() => PokeConfig()._listing_url;

  static getSingleUrl(pokemon_id) => getListingUrl() + "/$pokemon_id/";

  static placeholderUrl(int width, [int height]) => height == null
      ? PokeConfig()._placeholder_url + width.toString()
      : PokeConfig()._placeholder_url +
          "${width.toString()}x${height.toString()}";
}
