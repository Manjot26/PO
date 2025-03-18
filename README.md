Pokémon Card Viewer
Pokémon Card Viewer is a Flutter application that fetches and displays Pokémon cards from the Pokémon Trading Card Game API. Users can browse through a list of cards and view larger images by tapping on them.
Features
- Fetches Pokémon card data from the [Pokémon TCG API](https://api.pokemontcg.io/).
- Displays a list of Pokémon cards with their images and names.
- Uses `CachedNetworkImage` for optimized image loading and caching.
- Allows users to view a larger image of a card in a pop-up dialog.
- 
 Steps to Install & Run
1. Clone the repository:
   git clone https://github.com/yourusername/pokemon-card-viewer.git
   cd pokemon-card-viewer
2. Install dependencies:
   flutter pub get
3. Run the app on an emulator or physical device:  flutter run
   Project Structure
pokemon_card_viewer/
│── lib/
│   │── main.dart   # Entry point of the application
│   │── pokemon_card_list.dart  # UI for listing cards
│   │── pokemon_card_model.dart  # Model class for a Pokémon card
│── pubspec.yaml   # Project dependencies
│── README.md  # Documentation
Dependencies
The project uses the following dependencies:
- `flutter`: The framework for building the UI.
- `http`: To fetch data from the Pokémon TCG API.
- `cached_network_image`: To efficiently load and cache images.
 API Integration
The app fetches data from the following API endpoint: GET https://api.pokemontcg.io/v2/cards
The response contains a list of Pokémon cards in JSON format, which is then parsed into `PokemonCard` objects.
How It Works
1. The app starts with `PokemonCardViewer`, which initializes `PokemonCardList`.
2. `PokemonCardList` fetches the card data asynchronously.
3. The data is displayed using a `ListView.builder`.
4. Clicking on a card opens a dialog with an enlarged image.
Acknowledgments
[Pokémon TCG API](https://api.pokemontcg.io/) for providing the card data.
 Flutter & Dart documentation for development guidance.
Cu
