class PokeConfig {
  var _listing_url = "https://pokeapi.co/api/v2/pokemon/";
  var _placeholder_url = "https://via.placeholder.com/";
  static int imageWidth = 250;

  static getListingUrl() => PokeConfig()._listing_url;

  static getSingleUrl(pokemon_id) => getListingUrl() + "/$pokemon_id/";

  static placeholderUrl(int width, [int height]) => height == null
      ? PokeConfig()._placeholder_url + width.toString()
      : PokeConfig()._placeholder_url +
          "${width.toString()}x${height.toString()}";
}
