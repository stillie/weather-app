# weather-app
### Supported Platforms
 - Linux
 - Android
 - iOS (Not confirmed)
 - Windows (Not confirmed)

## Setup process
### Note: Ensure you are running Flutter version 3.19.0
1. Aquire an [OpenWeatherMap](https://openweathermap.org/current) API Key
2. Create a .env file in the root directory by renaming `example.env` to `.env` and update the value to reflect the API key from [OpenWeatherMap](https://openweathermap.org/current)
3. Run the following commands to update project with the required environment variables:

`dart run build_runner clean`

`dart run build_runner build --delete-conflicting-outputs`

4. To run the tests run `flutter test` 

# Rules

- [X] DO NOT USE ChatGPT for code generation
- [X] DO NOT USE FlutterFlow for UI generation
- [ ] No no-third parties JSON parsers or HTTP clients (such as json_serializable), just pure vanilla Dart Development, You are allowed to use Dart’own dart:convert
- [ ] Third-party dependencies through pub.dev can be used for cross-cutting concerns (such as logging, linting, dependency injection) and platform resources access (such as location and contact services) not for functional or UI components.
    * No freezed
    * No riverpod
    * No HookConsumerWidget
- [ ] Preferably the project has to be in Dart with null safety, If you use a dependency not supporting null safety, please state which one and why?
- [ ] Please do not perform dependency override
- [ ] The architectures options are: Bloc, Cubit and Provider + ChangeNotifier/StateNotifier
- [ ] If you use Bloc or Cubit as your architecture, please use flutter_bloc or your custom solution
- [ ] Please provide a comprehensive ReadME which contains:
    - [ ] Conventions, architecture, and general considerations
    - [ ] Exhaustive list of third-parties alongside their respective purposes
    - [ ] How to build the project
    - [ ] Any additional notes that can demonstrate your knowledge

* 7 Days to complete

- [X] Please upload the complete solution to a Git repository hosted on either GitHub, Bitbucket or GitLab.

- [ ] Send through a public link to the solution and a downloadable app file