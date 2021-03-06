Add-PSSnapin AdminSnapIn -erroraction SilentlyContinue 
Add-PsSnapin Microsoft.SharePoint.PowerShell -erroraction SilentlyContinue 
Add-PSSnapin Microsoft.FASTSearch.PowerShell -erroraction SilentlyContinue 

$NumPassedTests = 0
$NumFailedTests = 0
$NumExpectedFailedTests = 0
$ssa = Get-SPEnterpriseSearchServiceApplication


Function testCP([String]$cpname, [switch]$returnanswer, [switch]$notCheck )
{
    $success = $false
    $cp = Get-FASTSearchMetadataCrawledProperty -name $cpname -ea silentlycontinue
    if( $cp ) 
    {
        if($notCheck)
        {
            $success = $false
        }
        else
        {
            $success = $true
        }
    }
    else
    {
        if($notCheck)
        {
            $success = $true
        }
        else
        {
            $success = $false
        }
    }
    if( !$success ) 
    {
        Write-Host ("FAILED - Test: CrawledProperty: " + $cpname ) -ForegroundColor Red
        $script:NumFailedTests++
    }
    else
    {
        Write-Host ("PASSED - Test: CrawledProperty: " + $cpname ) -ForegroundColor Green
        $script:NumPassedTests++
        $success = $true
    }
    
    if( $returnanswer ) { return $success }
}


Function testMP([String]$mpname, [String]$member="skip", [String]$expectedvalue, [switch]$returnanswer, [switch]$notCheck)
{
    $success = $false
    $mp = Get-FASTSearchMetadataManagedProperty -name $mpname -ea silentlycontinue
    if( !$mp ) 
    {
        Write-Host ("FAILED - Test: ManagedProperty: " + $mpname + " - does not exist.") -ForegroundColor Red
        $script:NumFailedTests++
    }
    elseif( !($mp.$member) -and !($member -eq "skip" ) )
    {
        Write-Host ("FAILED - Test: ManagedProperty: " + $mpname + " : " + $member + " - member does not exist.") -ForegroundColor Red
        $script:NumFailedTests++
    }
    elseif( !($mp.$member -eq $expectedvalue) -and !($member -eq "skip") )	
    {
        Write-Host ("FAILED - Test: ManagedProperty: " + $mpname + " : " + $member + " : " + $mp.$member + " != " + $expectedvalue) -ForegroundColor Red
        $script:NumFailedTests++
    }
    else
    {
       if( $member -eq "skip" )
       {
           Write-Host ("PASSED - Test: ManagedProperty: " + $mpname + " - exists.") -ForegroundColor Green  
       }
       else 
       {
           Write-Host ("PASSED - Test: ManagedProperty: " + $mpname + " : " + $member + " = " + $expectedvalue) -ForegroundColor Green  
       }
       $script:NumPassedTests++
       $success = $true
    }
    if( $returnanswer ) { return $success }
}


Function testMPtoCPMapping([String]$mpname, [String]$cpname, [switch]$returnanswer, [switch]$notCheck)
{

    if( (testMP $mpname -returnanswer) -and (testCP $cpname -returnanswer) )
    {
            
        $mp = Get-FASTSearchMetadataManagedProperty -name $mpname -ea silentlycontinue
        $mappings = $mp.GetCrawledPropertyMappings()
        $count = 0
        foreach ($mapping in $mappings)
        {
            $count++
            if( $mapping.name -eq $cpName ) { $success = $true; break}
            else { $found += " " + $count + ") "+ $mapping.name }
        }
    }


    if( $success )
    {
        Write-Host ("PASSED - Test: CrawledProperty: " + $cpname + " -> ManagedProperty: "  + $mpname + " is mapped correctly.") -ForegroundColor Green
        $script:NumPassedTests++
    }
    else
    {
        Write-Host ("FAILED - Test: CrawledProperty: " + $cpname + " -> ManagedProperty: " + $mpname + " is NOT mapped.") -ForegroundColor Red
        write-HOST ("  Found instead crawled properties:" + $found) -ForegroundColor Red
        $script:NumFailedTests++
    }
    if( $returnanswer ) { return $success }
}


Function testURL([String]$testname, [String]$theurl, [String]$expectedtext, [switch]$notCheck)
{

    # sleep loop until co
    $tempdir = $Env:temp  
    $tempfile = "$tempdir\smoketest.htm" 
    $client = (new-object Net.WebClient) 

    $cred = [System.Net.CredentialCache]::DefaultCredentials
    $client.Credentials = $cred

    #$client.Credentials = New-Object System.Net.NetworkCredential("pkmacct", "???","redmond")
    
    While ($client.isBusy) { Start-Sleep -Seconds 1 }             
    
    $client.DownloadFile($theurl,$tempfile) 
    $client.dispose() 
     
    try 
    { 
        $docHtml = [io.file]::ReadAllText($tempfile) 
        #Remove-Item $tempfile 
 
        if ($docHtml.indexOf("$($expectedtext)") -gt 0) 
        { 
            Write-Host ("PASSED - Test: " + $testname) -ForegroundColor Green
            $script:NumPassedTests++
        } 
        else
        {
            Write-Host ("FAILED - Test: " + $testname) -ForegroundColor Red
            $script:NumFailedTests++
            #TODO on error write full details to a log file
        }
    }
    catch
    {
        Write-Error "There was error reading the url:$($theurl)" 
        $_ 
        return 
    }
}



""
"--------------Display Global Variables Properties-------------"
""
$env:hellobrent

""
"--------------Test Crawled Properties-------------"
""

testCP cpe
testCP cpv
testCP cpp
"Should not exist..."
testCP xxa -notCheck

""
"--------------Test Managed Properties-------------"
""
testMP pbjmpe RefinementEnabled $true
testMP pbjmpp RefinementEnabled $true
testMP pbjmpv RefinementEnabled $true

""
"--------------Test Managed Properties to Crawled Property Mappings -------------"
""
testMPtoCPMapping pbjmpp cpp 
testMPtoCPMapping pbjmpe cpe 
testMPtoCPMapping pbjmpv cpv



#$searchcenterquery = "http://intranet.contoso.com/search/Pages/results.aspx"
$searchcenterquery = "http://intranet.contoso.com/search/Pages/results.aspx?k="

<#
""
"--------------Test Synonyms---------------"
""
# note synonyms unlike fast synonyms, only act as an additional trigger for a best bet, does not affect query terms or search results.
testURL "One Way Synonym: picture --> image" ($searchcenterquery + "image") "SharePoint Images"
testURL "Two Way Synonym; group <--> team" ($searchcenterquery + "team") "Team Foundation Server"
"Should not exist..."
testURL "Keyword 'home' should not have a synonym" ($searchcenterquery + "home") "xxyxx"
$NumExpectedFailedTests += 1
#>

""
"--------------Test Page Content---------------"
""
testURL "Refine By: v1" ($searchcenterquery + "pbj") "Refine By: v1"
testURL "Refine By: e1" ($searchcenterquery + "pbj") "Refine By: e1"
testURL "Refine By: p1" ($searchcenterquery + "pbj") "Refine By: p1"
testURL "Search for document: xml1.xml" ($searchcenterquery + "pbj") "xml1.xml"
testURL "Search for document: xml2.xml" ($searchcenterquery + "pbj") "xml2.xml"
#"Should not exist..."
#testURL "Result should not contain 'xxyxx'" ($searchcenterquery + "a") "xxyxx"

#TODO Add two tests to check for refiner values

Write-Host ("") -ForegroundColor Yellow
Write-Host ("") -ForegroundColor Yellow
Write-Host ("-----------------------------------------") -ForegroundColor Yellow
Write-Host ("--------    Smoke Test Summary   --------") -ForegroundColor Yellow
Write-Host ("-----------------------------------------") -ForegroundColor Yellow
Write-Host ("Total tests Executed: $($script:NumPassedTests + $script:NumFailedTests)") -ForegroundColor Yellow
Write-Host ("Total tests Passed: $($script:NumPassedTests)") -ForegroundColor Green
Write-Host ("Total tests Failed: $($script:NumFailedTests)") -ForegroundColor Red
Write-Host ("Total expected Failure: $($script:NumExpectedFailedTests)") -ForegroundColor Red


#

# SIG # Begin signature block
# MIINGAYJKoZIhvcNAQcCoIINCTCCDQUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU2IKFg4r70U2drz6YyXYX2/Av
# elagggpaMIIFIjCCBAqgAwIBAgIQBg4i3l65iHFvsYhyMrxXATANBgkqhkiG9w0B
# AQsFADByMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYD
# VQQLExB3d3cuZGlnaWNlcnQuY29tMTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFz
# c3VyZWQgSUQgQ29kZSBTaWduaW5nIENBMB4XDTE0MDcxNzAwMDAwMFoXDTE1MDcy
# MjEyMDAwMFowaTELMAkGA1UEBhMCQ0ExCzAJBgNVBAgTAk9OMREwDwYDVQQHEwhI
# YW1pbHRvbjEcMBoGA1UEChMTRGF2aWQgV2F5bmUgSm9obnNvbjEcMBoGA1UEAxMT
# RGF2aWQgV2F5bmUgSm9obnNvbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
# ggEBAN0ZOWCIOEyhtxA/koB0azqKK40Pw3fa8GLif/ZM0cXJWGawkVgxOMbejeJW
# YCqXgEHF2MX/cJY8svCmLlX8M7AdjXYgtAS+C+cEHxrGAMMzj3/9EOu6DjzxIcwL
# l1GKoUwy8X3/GRGk3sBWT5CwKYRJdh9goWy74ltZN+sTKKeDHqpfuvxye6c++PC7
# 86wzm4MwfOIuPE9StFeo/0nKheEukfK9cpthlE5dUHpW0OjmJdX/g0mEdIjm2/Q2
# 50fzQyLQXOuMVIJ4Qk2comMDNRvZZvSPOBwWZ6fAR4tXfZwlpUcLv3wBbIjslhT7
# XasCm73TdBj+ZFDx2tUtpWguP/0CAwEAAaOCAbswggG3MB8GA1UdIwQYMBaAFFrE
# uXsqCqOl6nEDwGD5LfZldQ5YMB0GA1UdDgQWBBS+FASXsrRle2tLXdkVyoT1Dbw7
# QDAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMwdwYDVR0fBHAw
# bjA1oDOgMYYvaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL3NoYTItYXNzdXJlZC1j
# cy1nMS5jcmwwNaAzoDGGL2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNvbS9zaGEyLWFz
# c3VyZWQtY3MtZzEuY3JsMEIGA1UdIAQ7MDkwNwYJYIZIAYb9bAMBMCowKAYIKwYB
# BQUHAgEWHGh0dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwgYQGCCsGAQUFBwEB
# BHgwdjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tME4GCCsG
# AQUFBzAChkJodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRTSEEy
# QXNzdXJlZElEQ29kZVNpZ25pbmdDQS5jcnQwDAYDVR0TAQH/BAIwADANBgkqhkiG
# 9w0BAQsFAAOCAQEAbhjcmv+WCZwWCIYQwiEsH94SesBr0cPqWjEtJrBefqU9zFdB
# u5oc/WytxdCkEj5bxkoN9aJmuDAZnHNHBwIYeUz0vNByZRz6HsPzNPxLxThajJTe
# YOHlSTMI/XzBhJ7VzCb3YFhkD5f9gcJ5n+Z94ebd/1SoIvc9iwC3tTf5x2O7aHPN
# iyoWLTV4+PgDntCy/YDj11+uviI9sUUjAajYPEDvoiWinyT+7RlbStlcEuBwqvqT
# nLaiRsK17rjawW87Nkq/jB8rymUR/fzluIpHmPA4P0NazH4v5f62mpMFqdk0osMU
# QJ/qqACQ+2+/eAw7Gr6igNvlsxQpPfxsPNtUkTCCBTAwggQYoAMCAQICEAQJGBtf
# 1btmdVNDtW+VUAgwDQYJKoZIhvcNAQELBQAwZTELMAkGA1UEBhMCVVMxFTATBgNV
# BAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTEkMCIG
# A1UEAxMbRGlnaUNlcnQgQXNzdXJlZCBJRCBSb290IENBMB4XDTEzMTAyMjEyMDAw
# MFoXDTI4MTAyMjEyMDAwMFowcjELMAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lD
# ZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTExMC8GA1UEAxMoRGln
# aUNlcnQgU0hBMiBBc3N1cmVkIElEIENvZGUgU2lnbmluZyBDQTCCASIwDQYJKoZI
# hvcNAQEBBQADggEPADCCAQoCggEBAPjTsxx/DhGvZ3cH0wsxSRnP0PtFmbE620T1
# f+Wondsy13Hqdp0FLreP+pJDwKX5idQ3Gde2qvCchqXYJawOeSg6funRZ9PG+ykn
# x9N7I5TkkSOWkHeC+aGEI2YSVDNQdLEoJrskacLCUvIUZ4qJRdQtoaPpiCwgla4c
# SocI3wz14k1gGL6qxLKucDFmM3E+rHCiq85/6XzLkqHlOzEcz+ryCuRXu0q16XTm
# K/5sy350OTYNkO/ktU6kqepqCquE86xnTrXE94zRICUj6whkPlKWwfIPEvTFjg/B
# ougsUfdzvL2FsWKDc0GCB+Q4i2pzINAPZHM8np+mM6n9Gd8lk9ECAwEAAaOCAc0w
# ggHJMBIGA1UdEwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgGGMBMGA1UdJQQM
# MAoGCCsGAQUFBwMDMHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDov
# L29jc3AuZGlnaWNlcnQuY29tMEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5k
# aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3J0MIGBBgNVHR8E
# ejB4MDqgOKA2hjRodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
# cmVkSURSb290Q0EuY3JsMDqgOKA2hjRodHRwOi8vY3JsMy5kaWdpY2VydC5jb20v
# RGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3JsME8GA1UdIARIMEYwOAYKYIZIAYb9
# bAACBDAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5kaWdpY2VydC5jb20vQ1BT
# MAoGCGCGSAGG/WwDMB0GA1UdDgQWBBRaxLl7KgqjpepxA8Bg+S32ZXUOWDAfBgNV
# HSMEGDAWgBRF66Kv9JLLgjEtUYunpyGd823IDzANBgkqhkiG9w0BAQsFAAOCAQEA
# PuwNWiSz8yLRFcgsfCUpdqgdXRwtOhrE7zBh134LYP3DPQ/Er4v97yrfIFU3sOH2
# 0ZJ1D1G0bqWOWuJeJIFOEKTuP3GOYw4TS63XX0R58zYUBor3nEZOXP+QsRsHDpEV
# +7qvtVHCjSSuJMbHJyqhKSgaOnEoAjwukaPAJRHinBRHoXpoaK+bp1wgXNlxsQyP
# u6j4xRJon89Ay0BEpRPw5mQMJQhCMrI2iiQC/i9yfhzXSUWW6Fkd6fp0ZGuy62ZD
# 2rOwjNXpDd32ASDOmTFjPQgaGLOBm0/GkxAG/AeB+ova+YJJ92JuoVP6EpQYhS6S
# kepobEQysmah5xikmmRR7zGCAigwggIkAgEBMIGGMHIxCzAJBgNVBAYTAlVTMRUw
# EwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20x
# MTAvBgNVBAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJRCBDb2RlIFNpZ25pbmcg
# Q0ECEAYOIt5euYhxb7GIcjK8VwEwCQYFKw4DAhoFAKB4MBgGCisGAQQBgjcCAQwx
# CjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGC
# NwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFJL5P/NZmfrrt5bY
# wPercv+vce9kMA0GCSqGSIb3DQEBAQUABIIBAIhYetqxId3p62kTVl6qR1FaEff8
# XHnvzgtXizhB8rmEC4HHfeECVyWbMcZH3dXF2wq4IbD+sXoG6BS0Ge6eQq5rPXaI
# CnqCgTQ4d+ShKOPTBxzihfpU8Bc74XyLjFc3LQSUxt7GJrHSMsgnT8q5sPrMFQjh
# lMG6WWcO+C4mZa0dsoP2U3ouTAfIgg0qH6fMAftlTDxZdaTU8LVL8fxHRsvLWFnp
# mp9Rb/Ceh3gXVJM1zyn60cAQ/uXBBYp7aRpV9DAVOfbLU1GNlEfuSssk4Ag9Q+OP
# cKhxe8RLNBzk/2JwqXxC1orZALjO+u/Aj997oelCulHAjKzwtW6JwtZ7T8U=
# SIG # End signature block
