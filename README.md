# hackathon_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Project Overview
Hackathon Manager is a cross-platform application built with Flutter to streamline the organization, registration, and tracking of hackathons. Designed for hackathon hosts and participants, it provides tools to manage event details, team formation, submission tracking, and judging workflows. The app ensures a responsive UI, offline accessibility, and secure user management via Firebase.

Technology Stack
Frontend
Framework: Flutter (Material Design 3)

State Management: Provider

UI Features:

Responsive multi-device layout

Dark/Light mode

Smooth and minimal interface

Backend & Data Storage
Authentication: Firebase Authentication (Email/Password & Google Sign-In)

Database: Firebase Firestore (cloud data sync)

Local Storage (for offline support):

Mobile/Desktop: SQLite

Web: SharedPreferences

Cross-Platform Support
Android

iOS

Web

Windows/macOS (Desktop)

Core Dependencies
firebase_auth: User authentication

cloud_firestore: Event and participant data storage

google_sign_in: Google authentication

provider: State management

sqflite: Local offline database

shared_preferences: Web local storage

flutter_svg: Icons and branding

Architecture & Code Structure
bash
Copy
Edit
lib/
├── models/              # Models (Hackathon, Team, Submission, etc.)
├── providers/           # State management (UserProvider, EventProvider)
├── screens/             # Login, Dashboard, Hackathon details, Judging, etc.
├── services/            # Firebase interactions, file upload
├── utils/               # Validators, date/time helpers
assets/images/           # App logos, banners
Key Decisions:

Role-Based Access: Separate flows for Organizers, Participants, and Judges.

Offline Readiness: Data is cached locally for offline use.

Cloud Sync: Automatic sync with Firebase for real-time collaboration.

Feature Breakdown
1. User Authentication
Sign-up/login with Email/Password

Google Sign-In

Password recovery via Firebase

Role assignment (Organizer, Participant, Judge)

2. Hackathon Management (Organizer)
Create/Edit/Delete hackathons

Set registration dates, themes, rules

Invite judges or co-organizers

Track participant/team registrations

3. Team and Participant Registration
Form or join teams

Submit project ideas or descriptions

View event details, deadlines, resources

4. Submission Tracking
Upload project files (images, code links, etc.)

Edit or update submissions before deadlines

Real-time status of judging and feedback

5. Judging Panel
Assigned judges view submissions

Score entries using custom criteria

Add feedback or comments

View score summaries

6. Dashboard & Analytics
Participant stats

Hackathon registrations

Submission counts

Winner announcement

7. User Experience
Light/Dark theme

Smooth UI transitions

Responsive on mobile, tablet, desktop

Offline caching and usability

Setup & Installation
Prerequisites:
Flutter SDK

Firebase Project

Steps:
bash
Copy
Edit
git clone https://github.com/yourusername/hackathon_manager.git
cd hackathon_manager
flutter pub get
Add google-services.json and GoogleService-Info.plist for Firebase.

Enable Firebase Auth (Email/Google) and Firestore.

Run the app:

bash
Copy
Edit
flutter run
Usage Instructions
Organizers: Create hackathons, manage entries

Participants: Join events, form teams, submit projects

Judges: Review and score submissions

Future Enhancements
In-app chat for team communication

QR check-ins at physical events

Notifications for deadlines

Public leaderboard and voting

Certificate generator

Localization for multi-language support

Output:

![image](https://github.com/user-attachments/assets/c45cdcc1-de2c-47ed-a014-7d6038fdfd4d)

![image](https://github.com/user-attachments/assets/cbad5653-8f0e-4f86-ac49-740eac27c2ca)

![image](https://github.com/user-attachments/assets/d0d83b37-54bb-4998-bc5d-839f201e27d7)


Conclusion
The Hackathon Management App simplifies the experience of organizing and participating in hackathons. With offline readiness, Firebase integration, and a modular Flutter architecture, it offers a robust and scalable solution for both small and large-scale events.
