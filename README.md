# fetch-ios-coding-exercise
An iOS Native Application to view Recipes

 ## Project Overview
The Fetch Recipes app is an iOS application that allows users to browse, view details, and explore dessert recipes using the MealDB API. The app is developed using SwiftUI and follows the MVVM architecture to ensure clean and maintainable code. The application integrates unit and UI tests to ensure reliability and performance.

### Features
- Browse Recipes: Fetch and display a list of dessert recipes from the MealDB API.
- Recipe Details: View detailed information about each recipe, including ingredients, measurements, and cooking instructions.
- Sorting and Filtering: Alphabetically sort the recipes and filter out any recipes with null or empty values.

### Technical Stack
- Frontend: SwiftUI
- Architecture: MVVM (Model-View-ViewModel)
- Testing: XCTest for unit and UI tests
- CI/CD: GitHub Actions for continuous integration and testing

### Project Structure
The project is organized into the following directories:
- Models: Contains the data models used in the application.
- ViewModels: Contains the view models that handle business logic and data processing.
- Views: Contains the SwiftUI views that make up the user interface.
- Services: Contains the API service that handles network requests.
- Utilities: Contains utility functions and extensions.


### Setting Up the Project
1. Clone the Repository:

```
git clone https://github.com/yourusername/fetch-ios-coding-exercise.git
```

2. Navigate to working directory

```
cd fetch-ios-coding-exercise
cd FetchRecipes
```

3. Open the Project in Xcode:

```
open FetchRecipes.xcodeproj
```
  or you can use XCodes interface

4. Build and Run:
- Select the appropriate scheme and target device (e.g., iPhone 15 with the latest iOS).
- Press Cmd+R to build and run the application.

### Running Tests
The project includes both unit and UI tests to ensure code quality and application performance.

#### Unit Tests:
The unit tests are located in the FetchRecipesTests directory.

Run the unit tests using the Cmd+U shortcut in Xcode or via the CI pipeline.

#### UI Tests:
The UI tests are located in the FetchRecipesUITests directory.

The tests include launch tests and regular UI tests.

Run the UI tests using the Cmd+U shortcut in Xcode or via the CI pipeline.

### Continuous Integration
The project uses GitHub Actions for continuous integration. The CI workflow is defined in the .github/workflows/ci.yml file and includes the following jobs:
- Unit Tests:
  - Runs on every push to the dev branch and every pull request to the main branch.
  - Checks out the code, sets up Xcode, and runs unit tests.
  - Uploads unit test results as artifacts.

- UI Tests:
  - Runs after the unit tests on every push to the dev branch and every pull request to the main branch.
  - Checks out the code, sets up Xcode, and runs UI tests, excluding launch tests.
  - Uploads UI test results as artifacts.

- UI Launch Tests:
  - Runs after the unit tests on every push to the dev branch and every pull request to the main branch.
  - Checks out the code, sets up Xcode, and runs only the UI launch tests.
  - Uploads launch test results as artifacts.
 
### Future Plans
  If I was going to continue working on this app, I would probably incroporate a top tab navigator on the main view so that the user could select categories and view recipes from specific categories. I also would set up an account system so that users create create profiles and eventually save recipes they were interested in for later, even making grocery lists for these recipes, and eventually keep track of recipes they have cooked already. Something that I think would be interesting would be a search feature where users could put in ingredients that they have at home and then recipes would be suggested to them so that they would have to do minimal grocery shopping to cook it.

### Conclusion
  The Fetch Recipes app is a robust and user-friendly application for browsing and exploring dessert recipes. With a well-structured codebase, comprehensive tests, and continuous integration, the project ensures high quality and reliability. The app leverages the latest technologies and best practices in iOS development to deliver an excellent user experience. The app also has the potential to turn into a fun and useful project to continue with someday.
