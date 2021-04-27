# Pizza Printer Party

This is a really quick, basic Flutter application I threw together to connect to a DIY thermal printer in our house. The printer uses a Particle Photon, so all this app has to do is make requests of their Cloud API.

To use, you'll need to implement a Particle device that provides a single-String "message" function, and create a `lib/secrets.dart` file with the appropriate settings.

See `lib/home.dart` for implementation details.
