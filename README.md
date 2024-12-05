# Rick-And-Morty

## How to build & run
- Packages are managed with Swift Package Manager (SPM), no special task is required to get packages installed
- Program will build well on simulator, but if you need to run it on a physical device you might need to change the Bundle ID


## Assumptions and Design Decisions:

### 1. Architecture and Design Patterns:
Adopted MVVM (Model-View-ViewModel) architectural pattern
Used dependency injection for service layer to improve testability
Leveraged Swift's modern concurrency features (async/await, Task)
Implemented reactive programming using Combine and @Published properties

### 2. Concurrency and State Management:
Used Task for managing asynchronous operations
Implemented cancellation support for network requests
Added isLoading and error states for comprehensive UI feedback
Utilized AsyncStream for handling status change events

### 3. Service Layer:
Created abstract ICharacterService protocol for service implementation
Allowed easy mocking and testing through dependency injection


## Challenges and Solutions:

### 1. Concurrency Challenge: Managing multiple concurrent network requests
Solution: Implemented task cancellation mechanism
Used fetchTask?.cancel() to prevent multiple simultaneous network calls
Utilized Task.checkCancellation() to provide early exit for cancelled tasks

### 2. Network Error Handling Challenge: Providing user-friendly error management
Solution: Added error and isLoading properties to view models
Allowed views to react to different loading and error states
Printed errors for debugging (would replace with proper logging in production)

### 3. Testability Challenge: Creating loosely coupled components
Solution: Used dependency injection for services
Created protocols for services to enable easy mocking
Designed view models with clear, testable methods