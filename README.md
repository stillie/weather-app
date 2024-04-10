# weather-app
### Supported Platforms
 - Android
 - iOS (Not confirmed)

## Setup process
### Note: Ensure you are running Flutter version 3.19.0
1. Aquire an [OpenWeatherMap](https://openweathermap.org/current) API Key - I will provide mine in the email 
2. Create a .env file in the root directory by renaming `example.env` to `.env` and update the value to reflect the API key from [OpenWeatherMap](https://openweathermap.org/current)
3. Run the following commands to update project with the required environment variables:

`dart run build_runner clean`

`dart run build_runner build --delete-conflicting-outputs`

4. To run the tests run `flutter test` 

# Rules

- [X] DO NOT USE ChatGPT for code generation
- [X] DO NOT USE FlutterFlow for UI generation
- [X] No no-third parties JSON parsers or HTTP clients (such as json_serializable), just pure vanilla Dart Development, You are allowed to use Dart’s own dart:convert
- [X] Third-party dependencies through pub.dev can be used for cross-cutting concerns (such as logging, linting, dependency injection) and platform resources access (such as location and contact services) not for functional or UI components.
    * No freezed
    * No riverpod
    * No HookConsumerWidget
- [X] Preferably the project has to be in Dart with null safety, If you use a dependency not supporting null safety, please state which one and why?
- [X] Please do not perform dependency override
- [X] The architectures options are: Bloc, Cubit and Provider + ChangeNotifier/StateNotifier
- [X] If you use Bloc or Cubit as your architecture, please use flutter_bloc or your custom solution
- [X] Please provide a comprehensive ReadME which contains:
    - [X] Conventions, architecture, and general considerations
    - [X] Exhaustive list of third-parties alongside their respective purposes
    - [X] How to build the project
    - [X] Any additional notes that can demonstrate your knowledge

* 7 Days to complete

- [X] Please upload the complete solution to a Git repository hosted on either GitHub, Bitbucket or GitLab.

- [X] Send through a public link to the solution and a downloadable app file


# Details

## Architecture

The Architecture I went with was a variation of MVVM minus the ViewModel. All the business logic (In theory) should be sitting in the repositories. All the repositories do the calling of API's such as OpenWeatherMap and the Location API's. 

The screens mostly focus on simply rendering the data received.

## List of 3rd party libraries
Release Dependencies:
  provider: Used to create Objects such as the repositories and have the widgets react based on actions within the objects. Example: When an API call is done, notify all Consumers of the Provided Object that a change has happened
  http: Basic networking library
  envied: Used to retrieve variables from .env files
  google_fonts: To render the Roboto font. I am guessing thats the font used in the screenshots provided
  location: Used to retrieve the devices location

Dev Dependencies:
  envied_generator: Used to generate the classes for the envied library
  mocktail: Used to mock objects for testing purposes
  golden_toolkit: Used to generate screenshots or snapshots of widgets or screens in order to do pixel by pixel testing [See test/home/goldens](https://github.com/stillie/weather-app/tree/main/test/home/goldens)

## Additional Notes

- I wanted to implement better error handling. I started implementing it for the location errors but didn't have enough time to complete that
- I wanted to improve the visual aspect of a loading indicator
- I made some changes to the colours given in the documentation due to the fact that it didnt quite match up to the style of the image (for the sunny screenshot)
- I have implemented GitHub actions which will run the tests and then build the app. It won't build the app if any of the tests have failed.
- When a change is made on the 'Release' branch. A github Action is executed which builds that APK and publishes it to the [Releases](https://github.com/stillie/weather-app/releases) page of the repo. You are able to download the files from there.