# abc_banking

A new Flutter project.

## Getting Started

This Project is a basic banking application worked developed as part school assignment

The included Functionalitie are:
Creating an account
Using firebase phone Authentication 
depositing and withdrawal functionalities with updates on the database
Updating account details
Admin login with crud functionalities
WEB interface for ATM mock view
CRUD capabilities on ATM interface
provider sate management



Software and hardware used:
[✓] Flutter (Channel stable, 3.16.5, on macOS 13.0 22A380 darwin-x64)
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0)
[✓] Xcode - develop for iOS and macOS (Xcode 14.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2020.3)
[✓] Network connection

How to run:
Open Android studio and open imported project folder
Connect physical IOS device on a mac book or open an ios simulator from xcode.
Select platform to run on
Type “flutter run” in the terminal or click on the build play button to run.
Additional resources.

Application flow (Mobile):
For the ABC Banking system the main flow is handled by the mobile application first.
i. User signs up or signs in on the app. If user signs in but doesn’t have an account
associated with their phone number yet, they are redirected to the account creation
screen.
ii. Once the user has created the account, they are directed to the homepage where
they choose what transactions to carry out
iii. Available transactions include (Withdrawal, Deposit, and Money transfer or send)
iv. Recent transactions are displayed in a list on the homepage but the user can still
click on the Summary button to see a detailed list and define the summary period.
v. On the top of the page (APPBAR) there is a user avatar Icon ( ) which opens the
account settings page when tapped.
vi. On the account settings page the user can edit and update their details.
vii. On the homepage appbar there is also a log-out Icon ( ) which when tapped , logs
the user out of the app.







