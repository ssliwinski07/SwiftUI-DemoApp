//
//  README.md
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 10/05/2025.
//

# Swift Demo app

Simple demo app that shows current exchange rates (foreign currency to PLN, -> US Dollar 3.83 PLN etc.).

1.  Data is fetched from NBP API (https://api.nbp.pl/)
2.  Built with MVVM pattern and clean architecture principles - domain + data + presentation layers with separation of concerns.
3.  Used Moya for handling API calls and Swinject to build service locator and for dependency injection. Used built-in Swift Package Manager for packages installation (through Xcode UI), so in case of cloning repositry, there's no need to manually resolving dependencies. 

