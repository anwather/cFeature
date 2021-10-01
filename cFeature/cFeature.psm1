enum Ensure {
    Absent
    Present
}

[DscResource()]
class cFeature {


    [DscProperty(Key)]
    [string] $FeatureName

    [DscProperty()]
    [Ensure] $Ensure
    
    # Gets the resource's current state.
    [cFeature] Get() {
        $this.SetPath()
        $status = Get-WindowsFeature -Name $this.FeatureName
        switch ($status.InstallState) {
            "Installed" { $this.Ensure = [Ensure]::Present }
            default { $this.Ensure = [Ensure]::Absent }
        }
        return $this
    }
    
    # Sets the desired state of the resource.
    [void] Set() {
        $this.SetPath()
        if ($this.Ensure -eq "Present") {
            Install-WindowsFeature -Name $this.FeatureName -Verbose
        }
        else {
            Uninstall-WindowsFeature -Name $this.FeatureName -Remove -Verbose
        }
    }
    
    # Tests if the resource is in the desired state.
    [bool] Test() {
        $this.SetPath()
        $status = Get-WindowsFeature -Name $this.FeatureName
        if ($status.Installed) {
            return $true
        }
        else { 
            return $false 
        }
    }

    [void] SetPath() {
        $env:PSModulePath += ";C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules"
    }
}