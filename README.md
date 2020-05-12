# search_mvp

A sample Flutter package project representing a Provider listing screen with filter capabilities.

## Getting Started

This project is divided into two packages, app and service_providers.

**App** is a Flutter project which contain the app code. It serves as a route agreggator.

**Service Providers** is a Flutter package which contains the code for the Provider listing screen.
It is divided into `data` and `presentation`.

`data` contains the `Provider` model and a `ProviderManager` which serves as a wrap for the Flutter `AssetBundle`. The manager also serves as a way to scale this project as necessary (we could make it fetch data from the internet and save it on disk as an example).

`presentation` contains the actually screen code. It is subdivided into `route`, `screen` and `bloc`.
 `route` contains the class that creates the `ProvidersScreen` and inject the `ProvidersBloc` and `ProvidersManager` into it. 
 `screen` container the visual widgets of the provider listing screen. Here we have the `ProvidersScreen` which is a container that will show the `ProvidersLoadedPage`, `ProvidersLoadingPage` and the `ProvidersErrorPage` accordingly to the bloc state.
 `bloc` contains the business logic components. I've done a simple bloc implementation in which the events are the one reponsible for returning the state instead of putting all the conversion logic into the bloc.

## How to run

First do a `pub get` on the `service_providers` package.

```
cd packages/service_providers
flutter pub get
```

Then you can run the app project:

```
cd ../app
flutter run
```