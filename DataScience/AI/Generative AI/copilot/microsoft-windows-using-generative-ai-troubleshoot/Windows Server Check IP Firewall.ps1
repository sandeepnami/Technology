# Check IP Configuration
$ipConfig = Get-NetIPConfiguration

Write-Host "IP Configuration:"
Write-Host "------------------"
Write-Host "IP Address: $($ipConfig.IPv4Address.IPAddress)"
Write-Host "Subnet Mask: $($ipConfig.IPv4Address.PrefixLength)"
Write-Host "Default Gateway: $($ipConfig.IPv4DefaultGateway.NextHop)"
Write-Host "DNS Servers: $($ipConfig.DNSServer.ServerAddresses)"
Write-Host ""

# Validate Firewall Rules
$firewallRules = Get-NetFirewallRule | Where-Object { $_.Action -eq 'Block' }

Write-Host "Firewall Rules Blocking Traffic:"
Write-Host "-----------------------------"
if ($firewallRules) {
    foreach ($rule in $firewallRules) {
        Write-Host "Name: $($rule.Name)"
        Write-Host "Action: $($rule.Action)"
        Write-Host "Enabled: $($rule.Enabled)"
        Write-Host "Direction: $($rule.Direction)"
        Write-Host "Local Address: $($rule.LocalAddress)"
        Write-Host "Remote Address: $($rule.RemoteAddress)"
        Write-Host "Protocol: $($rule.Protocol)"
        Write-Host ""
    }
} else {
    Write-Host "No firewall rules are blocking necessary traffic."
}

# End of Script
