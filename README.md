# LA-demo

- Create widget extension
- In Info.plist Add NSSupportsLiveActivities key to yes 
- Add ActivitityAttributes structure to describe static and dynamic data for live activity
- Use ActivitityAttributes to create ActivityConfiguration
- Set ur start, update and end live activity

# Preview
<img width="475" alt="image" src="https://user-images.githubusercontent.com/41714182/220251050-e4de50a3-a99e-456f-bcf9-6d2a52a2e62c.png">
<img width="473" alt="image" src="https://user-images.githubusercontent.com/41714182/220681767-e18b1f94-1a4d-47a5-bb4d-fc24c35ee9d4.png">

# Notes
* im moving model file from hosts apps to widget due to circular dependency 
* on final for update the widget only move from any status to landed
* preview crash due to unknown sources
