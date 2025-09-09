# NYT Top Stories - Flutter Application Documentation

## Overview

This Flutter application displays top stories from the New York Times API with a clean, responsive interface that supports both list and grid views.

## Project Structure

```
lib/
├── core/
│   ├── network/
│   │   ├── api_endpoints.dart
│   │   └── dio_client.dart
│   └── error/
│       ├── api_exception.dart
│       ├── base_exceptions.dart
│       ├── data_parsing_exceptions.dart
│       ├── network_exceptions.dart
│       └── unknown_excetpion.dart
├── features/
│   └── nyt/
│       ├── data/
│       │   ├── datasource/
│       │   │   └── nyt_remote_datasource.dart
│       │   ├── models/
│       │   │   └── article_model.dart
│       │   └── repositories/
│       │       └── nyt_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── article_entities.dart
│       │   ├── repositories/
│       │   │   └── nyt_repository.dart
│       │   └── usecases/
│       │       └── get_top_stories.dart
│       └── presentation/
│           ├── cubit/
│           │   ├── nyt_cubit.dart
│           │   └── nyt_state.dart
│           ├── di/
│           │   └── injection.dart
│           ├── pages/
│           │   ├── article_detail_page.dart
│           │   ├── article_webview_page.dart
│           │   └── top_stories_page.dart
│           └── widgets/
│               ├── article_card.dart
│               ├── article_list_tile.dart
│               ├── layout_toggle_button.dart
│               ├── search_field.dart
│               ├── section_filter_menu.dart
│               └── shimmer_place_holder.dart
├── routes/
│   └── app_routes.dart
├── app.dart
└── main.dart
```

## Core Components

### Network Layer

**ApiEndpoints** (`core/network/api_endpoints.dart`)
```dart
class ApiEndpoints {
  static const topStories = "/svc/topstories/v2";
  static String topStoriesSection(String section) => "$topStories/$section.json";
}
```

**DioClient** (`core/network/dio_client.dart`)
- Handles HTTP requests with Dio
- Includes request/response logging
- Manages timeouts and errors
- Validates responses and converts Dio errors to application-specific exceptions

### Error Handling

**BaseException** (`core/error/base_exceptions.dart`)
- Base class for all custom exceptions

**Specialized Exceptions:**
- `ApiException`: For HTTP API errors
- `DataParsingException`: For JSON parsing errors
- `NetworkException`: For network connectivity issues
- `UnknownException`: For unexpected errors

## Feature Implementation

### Data Layer

**NYTRemoteDataSource** (`features/nyt/data/datasource/nyt_remote_datasource.dart`)
- Fetches data from NYT API
- Handles environment variables for API keys
- Parses JSON responses into ArticleModel objects

**ArticleModel** (`features/nyt/data/models/article_model.dart`)
- Data model representing NYT articles
- Extends ArticleEntity
- Handles parsing of multimedia content (images)

### Domain Layer

**ArticleEntity** (`features/nyt/domain/entities/article_entities.dart`)
- Core entity class using Equatable for value comparison
- Contains article properties: title, author, description, images, URL

**NYTRepository** (`features/nyt/domain/repositories/nyt_repository.dart`)
- Abstract repository interface

**GetTopStories** (`features/nyt/domain/usecases/get_top_stories.dart`)
- Use case for retrieving top stories

### Presentation Layer

**NYTCubit** (`features/nyt/presentation/cubit/nyt_cubit.dart`)
- Manages application state
- Handles:
  - Fetching stories from repository
  - Error handling
  - Search functionality
  - Layout switching
  - Section filtering

**NYTState** (`features/nyt/presentation/cubit/nyt_state.dart`)
- Contains:
  - Loading state
  - Error messages
  - Current section
  - Search query
  - Layout preference
  - Article list

**Pages:**
- `TopStoriesPage`: Main listing page with search and filtering
- `ArticleDetailPage`: Detailed view of a single article
- `ArticleWebviewPage`: Web view for full article content

**Widgets:**
- `ArticleCard`: Grid view item
- `ArticleListItem`: List view item
- `LayoutToggleButton`: Switches between list/grid views
- `SearchField`: Search input field
- `SectionFilterMenu`: Dropdown for section selection
- `ShimmerPlaceholder`: Loading animation

## Dependency Injection

**Injection** (`features/nyt/presentation/di/injection.dart`)
- Uses GetIt for service location
- Sets up dependencies in proper order:
  1. DioClient
  2. NYTRemoteDataSource
  3. NYTRepository
  4. NYTCubit

## Routing

**AppRouter** (`routes/app_routes.dart`)
- Uses GoRouter for navigation
- Routes:
  - `/`: Splash screen
  - `/top-stories`: Main articles list
  - `/article-detail`: Article detail view
  - `/article-webview`: Web view (commented out)

## App Configuration

**MyApp** (`app.dart`)
- Sets up BlocProvider for state management
- Configures MaterialApp with router
- App theme with white primary color

**main.dart** 
- Initializes Flutter binding
- Loads environment variables
- Sets up dependency injection
- Runs the application

## Environment Variables

Create a `.env` file with:
```
BASE_URL=https://api.nytimes.com/svc/topstories/v2
API_KEY=your_nyt_api_key_here
```

## Key Features

1. **Responsive Design**: Adapts to different screen sizes
2. **Multiple Layouts**: List and grid views
3. **Search Functionality**: Filter articles by title or author
4. **Section Filtering**: Browse different NYT sections
5. **Error Handling**: Comprehensive error management
6. **Image Caching**: Uses cached_network_image for efficient loading
7. **Web Integration**: In-app browser for full articles
8. **Pull-to-Refresh**: Update content with swipe gesture

## Error Handling Strategy

The application uses a layered error handling approach:
1. Network level: Dio exceptions converted to app-specific exceptions
2. Data layer: API and parsing exceptions
3. Presentation layer: User-friendly error messages

## State Management

Uses BLoC (Cubit) pattern with:
- Clear separation of business logic and UI
- Immutable state management
- Reactive UI updates

## API Integration

Integrates with NYT Top Stories API v2:
- Endpoint: `https://api.nytimes.com/svc/topstories/v2/{section}.json`
- Requires API key parameter
- Returns JSON with article data and multimedia content