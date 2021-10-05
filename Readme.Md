# Example Usage

```
Configuration BaseSetup {
    Import-DscResource -ModuleName PsDscResources
    Import-DscResource -ModuleName cFeature


    Node localhost {

        cFeature singleFeature {
            Ensure      = "Absent"
            FeatureName = "PowerShell-V2"
        }

        cFeatureSet multiFeature {
            Ensure      = "Present"
            FeatureName = "RSAT-AD-PowerShell,Hyper-V-PowerShell"
        }
    }
}
```