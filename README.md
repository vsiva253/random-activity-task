

# Random Activity App

This is a Flutter app that fetches and displays random activities using the [Bored API](https://www.boredapi.com/). Users can click the "GET" button to retrieve a new random activity suggestion.

## Features

- Fetches random activities from the Bored API.
- Stores the last fetched activity locally for offline use.
- Provides error handling for failed API requests.



## Installation

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/random-activity-app.git
   ```

2. Navigate to the project folder:

   ```bash
   cd random-activity-app
   ```

3. Install dependencies using Flutter:

   ```bash
   flutter pub get
   ```

4. Run the app on an emulator or physical device:

   ```bash
   flutter run
   ```

## Dependencies

- [http](https://pub.dev/packages/http): For making HTTP requests to the Bored API.
- [shared_preferences](https://pub.dev/packages/shared_preferences): For storing and retrieving data locally.

## Usage

- Click the "GET" button to fetch a random activity.
- The fetched activity will be displayed on the screen.
- If an error occurs during the API request, an error message will be shown.

## Contributing

Contributions are welcome! If you'd like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix: `git checkout -b feature/my-feature` or `git checkout -b bugfix/issue-description`.
3. Make your changes and commit them: `git commit -m 'Add new feature'`.
4. Push to your fork: `git push origin feature/my-feature`.
5. Create a pull request to the `main` branch of the original repository.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to the Bored API for providing random activity suggestions.
- This app was created as a learning exercise in Flutter.
```
