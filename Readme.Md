# Example Usage

```
Configuration BaseSetup {
    Import-DscResource -ModuleName PsDscResources
    Import-DscResource -ModuleName cFeature


    Node localhost {

        cFeature ps2 {
            Ensure      = "Absent"
            FeatureName = "PowerShell-V2"
        }
    }
}
```