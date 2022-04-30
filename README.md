# Objective
A mobile app that uses the Flickr image search API and shows the results in a 3-column scrollable view.

## Installation
To clone the Git repository to your local machine:
```
git clone https://github.com/iamgilbertm/flickr-browser-ios.git
```

## Dependencies

Make sure you have [CocoaPods installed](https://guides.cocoapods.org/using/getting-started.html) and then run:
```sh
pod install
```

## Requirements:
- iOS 15.2
- Xcode 13.2.1
- Swift 5

## Design Pattern
### MVVM
- Maintainability
  - It is easier to go into one or several of those more granular and focused parts and make changes without worrying.
- Testability
  - That makes it a lot easier to write unit tests against a core logic.
- Extensibility
  - You have a better chance of making any of those parts more reusable.

## Approach
### Alamofire
- Elegant and composable interface to HTTP network requests
### RxSwift
- Enables building apps in a declarative way
### R.swift
- Fully typed, less casting and guessing what a method will return

## TODOs
- [ ] Display more info in gallery viewer
- [ ] Enhance UI/UX
- [ ] Theming

## Meta
Gilbert Mendoza – [@iamgilbertm](https://www.facebook.com/iamgilbertm) – gcm_online@yahoo.com

[https://github.com/iamgilbertm/](https://github.com/iamgilbertm/)
