ConvertFrom-StringData @'
###PSLOC
res_0000 = {2}: Some active databases are not properly indexed or discovered. CountOfActiveDbs:{0}, NumberOfDbsDiscovered:{1}
res_0001 = {1}: Returning '{0}'.
res_0002 = {1}: Now searching for all the Mailbox Databases in DAG '{0}'...
res_0003 = {1}: Could not find mailbox server '{0}'!
res_0004 = {1}: Could not find Exchange server '{0}'!
res_0005 = {3}: Database '{1}' is active on server '{2}'. Mounted='{0}'
res_0006 = {2}: Database '{0}' is passive on server '{1}'
res_0007 = {2}: Server '{0}' is in AD site '{1}'
res_0008 = {1}: Running command: cluster.exe /cluster:{0} node
res_0009 = {0}: cluster.exe failed to contact the cluster. RPC_S_SERVER_UNAVAILABLE. The cluster network name resource may be offline or the cluster may have lost quorum.
res_0010 = {2}: cluster.exe did not succeed. Return value {1}. \nOutput: {0}
res_0011 = {1}: cluster.exe returned the following output:`n {0}
res_0012 = {0}: cluster.exe output returned no regex matches!
res_0013 = {2}: cluster.exe operation completed in {0} ms. Returning '{1}'.
res_0014 = {1}: Found DAG '{0}'.
res_0015 = {1}: Failed to query the cluster using the cluster netname of '{0}'! Querying DAG member servers instead.
res_0016 = {1}: Database availability group '{0}' has no members.
res_0017 = {2}: Enumerating DAG servers starting at index='{1}', server='{0}'.
res_0018 = {1}: Unable to communicate with database availability group '{0}'. Marking all members as 'Down'.
res_0019 = {1}: Overall operation completed in {0} ms.
res_0020 = {1}: Entering: `$serverName={0}
res_0021 = {1}: Leaving (returning '{0}')
res_0022 = {0}: Checking if the local server is the PAM...
res_0023 = {1}: Returning '{0}'.
res_0024 = {0}: No Active Directory sites were found.
res_0025 = Only 1 AD site '{0}' found. Balancing DBs by ActivationPreference instead...
res_0026 = Sites have started off balanced with a maximum difference in active databases of {0}.`n
res_0027 = Sites have started off *UNBALANCED* with a maximum difference in active databases of {0} !`n
res_0028 = Sites are still unbalanced! Now attempting to move some databases to less preferred copies. CurrentMaxDelta={0}, AllowedMaxDelta={1}
res_0029 = {1}: Starting iteration: {0}...
res_0030 = {1}: Descending sorted servers: {0}
res_0031 = {2}: MaxActives={0}, MinActives={1}
res_0032 = {0}: Moving databases to less preferred copies is allowed.
res_0033 = {1}: Considering databases on server {0}...
res_0034 = {2}: Following DBs can possibly be moved off {0}: {1}
res_0035 = {1}: Found no database to move off server {0} !
res_0036 = {1}: Sorted Servers: {0}
res_0037 = {2}: Database '{0}' does NOT have a copy on server '{1}' !
res_0038 = {1}: Database copy '{0}' has already been attempted for move. Skipping this copy.
res_0039 = {2}: Database copy '{0}' (AP={1}) is currently the active copy. Skipping this copy.
res_0040 = {4}: Database copy '{0}' (AP={1}) is NOT more preferred than active copy on '{2}' (AP={3})
res_0041 = {1}: Database '{0}' has not been moved.
res_0042 = Database '{0}' has had no move attempted EVEN THOUGH it is not active on its most preferred copy!
res_0043 = {2}: MaxActives({0}), MinActives({1}). Moving databases off of overloaded server first.
res_0044 = {2}: MaxActives({0}), MinActives({1}). Moving databases off in random order.
res_0045 = {0} `n
res_0046 = Database '{0}' FAILED to move!
res_0047 = Database '{0}' successfully moved from site '{1}' to site '{2}'.
res_0048 = {2}: Entering: `$mdb={0}, `$serverList={1}
res_0049 = {2}: Checking if database '{0}' is still active on the same server '{1}'...
res_0050 = {3}: Database '{0}' was not moved because it has apparently already been moved away from original active server '{1}' to '{2}'.
res_0051 = {1}: Leaving (return '{0}')
res_0052 = {1}: No servers were specified for database '{0}' to move to.
res_0053 = {2}: Database '{0}' is not being moved because the move target is the current active server: '{1}'
res_0054 = Considering move of '{0}' from '{1}' (AP = {2}) to '{3}' (AP = {4})...
res_0055 = Database '{2}' CANNOT be moved to server '{3}' because it would cause the AD sites to become MORE unbalanced. AllowedMaxSiteDelta={4}, CurMax={0}, CurMin={1}
res_0056 = Database '{2}' CANNOT be moved to server '{3}' because it would cause the AD sites to become unbalanced. AllowedMaxSiteDelta={4}, CurMax={0}, CurMin={1}
res_0057 = {2}: Attempting to move database '{0}' to server '{1}'...
res_0058 = {2}: Whatif mode: Hypothetically moved database '{0}' to server '{1}'!
res_0059 = {2}: Successfully moved database '{0}' to server '{1}'!
res_0060 = {4}: 'Move-ActiveMailboxDatabase -Identity '{0}' -ActivateOnServer {1} -Confirm:{2}' FAILED! Returned result: `n{3}
res_0061 = {2}: Mounting DB '{0}' on server '{1}'
res_0062 = {2}: DB '{0}' successfully mounted on server '{1}'
res_0063 = {2}: DB '{0}' *FAILED* to mount on server '{1}'
res_0064 = {4}: Skipping mount for DB '{0}' on server '{1}' since '{2}={3}'
res_0065 = {1}: Database '{0}' *FAILED* to move! Now attempting to perform rollback to prevent a DB outage...
res_0066 = {5}: Attempt 1: Moving DB '{0}' to server '{1}' with command: Move-ActiveMailboxDatabase -Identity {2} -ActivateOnServer {3} -Confirm:{4}
res_0067 = {2}: Attempt 1: DB '{0}' successfully moved back to server '{1}'
res_0068 = {2}: Attempt 1: DB '{0}' *FAILED* to move back to server '{1}'
res_0069 = {5}: Attempt 2: Moving DB '{0}' to server '{1}' with command: Move-ActiveMailboxDatabase -Identity {2} -ActivateOnServer {3} -SkipClientExperienceChecks -Confirm:{4}
res_0070 = {2}: Attempt 2: DB '{0}' successfully moved back to server '{1}'
res_0071 = {2}: Attempt 2: DB '{0}' *FAILED* to move back to server '{1}'
res_0072 = Server {0} is not participating in DB redistribution because it is activation blocked!
res_0073 = Server {0} is not participating in DB redistribution because it is *DOWN* according to clustering!
res_0074 = {1}: {0}
res_0075 = {1}: Target server '{0}' has an activation policy of 'Unrestricted'.
res_0076 = {2}: {1} completed in {0} ms
res_0077 = Compiling code...
res_0078 = Done!
res_0079 = Sleeping for {0} seconds...
res_0080 = Failed at command '{0}' with '{1}'
res_0081 = The local server '{0}' is not the Primary Active Manager! Skipping database balancing on this server.
res_0082 = {0}: A database availability group wasn't specified. Searching the local Mailbox server first...
res_0083 = {1}: Found local mailbox server '{0}'
res_0084 = {1}: Local server is part of DAG '{0}'
res_0085 = The local mailbox server '{0}' is NOT part of a DAG! Please specify the -DagName parameter.
res_0086 = The local server '{0}' is NOT a mailbox server. Please specify the -DagName parameter.
res_0087 = Please specify the -DagName parameter.
res_0088 = {1}: Searching for DAG '{0}'...
res_0089 = Could not find DAG matching '{0}'!
res_0090 = Please use one of the parameters to select what the script should do. Exiting.
res_0091 = Script run with -DotSourceMode. Exiting.
res_0092 = Starting: {0}
res_0093 = {0}: Database lookup
res_0094 = {0}: Server lookup
res_0095 = {0}: Database distribution calculation
res_0096 = {0}: Moving all databases to their preferred copies.
res_0097 = {0}: Shuffling all databases randomly
res_0098 = Target server '{0}' has an activation policy of '{1}'.
res_0099 = Server '{0}' has an activation policy of '{1}', and it is not in the same Active Directory site as server '{2}'.
res_0100 = Moved as part of database redistribution ({0}).
res_0101 = Database '{0}' CANNOT be moved to server '{1}' because it failed validation checks! Error: {2}
res_0102 = Sites are now balanced! CurrentMaxDelta={0}, AllowedMaxDelta={1}
res_0103 = Databases are evenly balanced across non-activation-blocked servers in the DAG.
res_0104 = Database '{2}' successfully moved from '{0}' to '{1}'.
res_0105 = Server '{0}' can't host more active databases because it's reached the configured maximum active databases limit of {1} databases.
res_0106 = Server '{0}' was reported by Windows Failover Clustering as Offline.
res_0107 = Database copy '{0}\{1}' hasn't been assigned an activation preference.
res_0108 = Database '{0}' is being skipped for balancing because its active copy on server '{1}' is in state '{2}'.
res_0109 = Database distribution is not balanced. Server with minimum number of active databases has only {0} databases, while server with the maximum number of active databases has {1}. Maximum delta is {2}.
###PSLOC
'@

# SIG # Begin signature block
# MIINGAYJKoZIhvcNAQcCoIINCTCCDQUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUtD17zTvoQREFbyozoeRmPsgh
# aQOgggpaMIIFIjCCBAqgAwIBAgIQBg4i3l65iHFvsYhyMrxXATANBgkqhkiG9w0B
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
# NwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFPXIJ5e0Ai+yKBhZ
# 1iXV/yZH3CAmMA0GCSqGSIb3DQEBAQUABIIBAMT2vJlbvCgNaJOWgx6xZKXIm1YD
# iYDFjKVbFlcKSfZ1k9FL6WYGa6N47SevFW/c7SFolAqU5g7mfi1WuXBzH/yFzeNe
# varqrWNyXqtz+GHxpC9xLVSAU8a/ZodonTxmCy6DKakfAdyu/+H0ETkDX25vQOXu
# KQ8j7uTmQI4dlXlYj6Kn4e1rULLTWrGyqFLi/n7Ua7mWx2Uv8cGAjik1hcWDXadI
# B58A1kOgmkfaa//5jpAcXU1V/Wiut4cY1gvgbKb+eCY3Ws3Hbjn/v9nXdRiv7ATe
# CGQzZ8q6qCIgVjpl/EXUDxqhVCmibxNOjVd+yjH6EQs7HRHY6nSCeS5lA4k=
# SIG # End signature block
