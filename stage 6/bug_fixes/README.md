# Book'n Eat

This is a recipe app that lists and displays recipe of different meals. Currently still in development, I'm working my way up.

## New Implementations

- **Splash Screen** - Animated app intro,
- **Onboarding** - 3-slide Onboarding screens talking about the app,
- **Authentication** - Login & Register with validation - Just empty field error validation for now,
- **Recipe Fetch** - Live data from dummyjson.com API,
- **Bottom Navigation** - 5 tabs - Maintained the layout of the previous task, so the recipies are rendered in the /home,
- **State Management** - Built with GetX.

## How to Run

1. Clone my repository - https://github.com/sudo-thanos/KodeCamp_Flutter/tree/main/stage%205/api_integration
2. Install dependencies:

```bash
   flutter pub get
```

3. Run the app:

```bash
   flutter run
```

4. If you have an android phone connected wirelessly or wired, `flutter run` will detect the device and build and run on it.
5. if not, run

```bash
   flutter run -d linux (if you use linux like me).
```

## UI Design Choice

For my UI design choice, i chose the horizontal layout so as to economize space. I sketched how I want the UI to look on paper first before working on it.
Since there are not so much detail in the initial home page, there's no point making my cards big, so the image to the left, and the contents to the right.

## Screenshots

![Profile Screen](screenshots/profile.png)
![Edit Profile Screen](screenshots/edit_profile.png)

<!-- ![Home Screen](screenshots/home.jpg) -->
