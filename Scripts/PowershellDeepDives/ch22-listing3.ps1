# listing 3 - adding the PackageZip task

# Remember - psake is just PowerShell, so you can use any PowerShell features you need in your build

# for example, this PackageZip psake build task uses the PSCX PowerShell module to zip up the build artifacts
task -name PackageZip –depends Build -action {        
    import-module pscx;                                               
    dir ./MyProject/bin/debug | write-zip -output ./MyProject.zip;                                    
}        

task –name Build –action { 
    exec { 
        msbuild ./MyProject/MyProject.csproj /t:Build 
    }
}

task –name Clean –action { 
    exec { 
        msbuild ./MyProject/MyProject.csproj /t:Clean
    }
}

task –name Rebuild -depends Clean,Build; 
task –name Default -depends Build;
