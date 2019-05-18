# Map
Map is a collection of samples using the map for iOS.

## How to build
- Install cocoapods and cocoapods-keys.
  - Run `$ bundle install`.
- Get google maps API key. [https://developers.google.com/maps/documentation/ios-sdk/get-api-key](https://developers.google.com/maps/documentation/ios-sdk/get-api-key)
- Set the keys.
  - Run `$ cp .env.sample .env`.
  - Set the your API key in the `.env`.
  - Run `$ ./scripts/generate-keys.sh`.
- Open Xcode and run.