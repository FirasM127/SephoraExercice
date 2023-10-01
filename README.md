# SephoraExercice

# Architecture:
The app’s architecture is based on the clean architecture and the MVVM pattern. It has 3 layers:
- Domain Layer: Entities + Use Cases
- Platform Layer: API (Network) and CoreData (Local data)
- Presentation Layer: ViewModels + Views + Navigator

The layers are 3 separate targets in the app to enforce modularity.

## Domain Layer: 
Basically defines what the app does. (Defines the models and all the use cases)

## Platform Layer: 
Concrete implementation of the Domain use cases, it hides all the implementation detail and only exposes the UseCaseProvider.

## Presentation Layer: 
Responsible for displaying information to the user and handling user input.
- Combine is used for binding
- ViewModel perform the transformation of user input to output.
- Navigator is responsible for the navigation and for dependency injection. 
