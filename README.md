# Tic Tac Toe - Flutter Game
This is a classic Tic Tac Toe game application on a 3x3 board, built with the Flutter framework. The app allows two players to take turns (X and O), tracks scores, and provides UI customization features.

## 🚀 Key Features
* **3x3 Tic Tac Toe Gameplay:** Basic board with alternating turns between player X and O.
* **Automatic Result Detection:** The game automatically identifies the winner or declares a draw.
* **Winning Animation:** Draws a red line connecting the 3 winning cells using CustomPainter.
* **Scoring System:** Counts X wins, O wins, and draws. These metrics are automatically saved using SharedPreferences so they aren't lost when exiting the app.
* **Light/Dark Theme:** Allows users to switch between day and night interfaces; the theme state is also saved to the device.
* **Robust State Management**: Uses the flutter_riverpod library for scalable and performance-optimized state management architecture.

## 🛠 Technologies & Libraries
* **Framework:** Flutter & Dart
* **State Management:** flutter_riverpod
* **Local Storage:** shared_preferences

## 📁 Project Structure
* `main.dart`: The entry point of the application. Initializes ProviderScope with AppObserver attached and sets up MaterialApp.
* `mainscreen.dart`: The main game screen, displaying scores, turn/result announcements, the board, and action buttons.
* `gamestate.dart`: Contains all core game logic including win/draw condition checking, board updates, and score save/load operations.
* `boardcell.dart`: The UI for each individual cell on the board, handling text display (red X, blue O) and grid borders.
* `themeprovider.dart`: Contains the logic for switching between Dark Mode and Light Mode, and saving settings via SharedPreferences.
* `painter.dart`: Integrates the WinningPainter class (extending CustomPainter) to draw the winning strike-through line.
* `observer.dart`: Provides AppObserver (extending ProviderObserver) to monitor and log Riverpod state changes to the console, highly useful for debugging.
