function Add-AzureArcTag {
    <#
    .SYNOPSIS
    Adds tags to an Azure resource by resource ID.
    .DESCRIPTION
    The Add-AzureArcTag function adds tags to an Azure resource.
    .PARAMETER ResourceId
    The ID of the Azure resource to add tags to.
    .PARAMETER Tags
    A hashtable of tags to add to the Azure resource.
    .EXAMPLE
    Add-AzureArcTag -ResourceId "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/MyResourceGroup/providers/Microsoft.Compute/virtualMachines/MyVM" -Tags @{ Environment = "Production"; Department = "IT" }
    This example adds two tags to a virtual machine resource.
    .NOTES
    Add Error handling
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [string]$ResourceId,
        [Parameter(Mandatory)]
        [hashtable]$Tags
    )
    begin {
        Write-Verbose -Message "Adding tags to $ResourceId"
    }
    process {
        try {
            if ($PSCmdlet.ShouldProcess("$ResourceId")) {
                New-AzTag -ResourceId $ResourceId -Tag $Tags -ErrorAction Stop
            }
        }
        catch [Microsoft.Azure.Commands.Common.Authentication.AuthenticationFailedException] {
            Write-Error -Message "Failed to authenticate to Azure. Please check your credentials and try again."
        }
        catch {
            Write-Error -Message "An error occurred while adding tags to $ResourceId. Error message: $($_.Exception.Message)"
        }
    }
    end {
    }
}

function Update-AzureArcTag {
    <#
    .SYNOPSIS
    Adds tags to an Azure resource by resource ID.
    .DESCRIPTION
    The Update-AzureArcTag function updates tags to an Azure resource.
    .PARAMETER ResourceId
    The ID of the Azure resource to add tags to.
    .PARAMETER Tags
    A hashtable of tags to add to the Azure resource.
    .PARAMETER TagOperation
    Specifies the operation to perform on the tags. The acceptable values for this parameter are: Replace and Merge. The default value is Replace.
    Replace: Replaces the existing tags with the tags specified in the Tags parameter.
    Merge: Merges the existing tags with the tags specified in the Tags parameter. If a tag already exists, the value is replaced with the value specified in the Tags parameter.
    .EXAMPLE
    Update-AzureArcTag -ResourceId "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/MyResourceGroup/providers/Microsoft.Compute/virtualMachines/MyVM" -Tags @{ Environment = "Production"; Department = "IT" }
    This example adds two tags to a virtual machine resource.
    .NOTES
    Add Error handling
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [string]$ResourceId,
        [Parameter(Mandatory)]
        [hashtable]$Tags,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Replace", "Merge")]
        [string]$TagOperation = "Replace"
    )
    begin {
        Write-Verbose -Message "Updating tags on $ResourceId"
    }
    process {
        try {
            if ($PSCmdlet.ShouldProcess("$ResourceId")) {
                Update-AzTag -ResourceId $ResourceId -Tag $Tags -ErrorAction Stop -Operation $TagOperation
            }
        }
        catch [Microsoft.Azure.Commands.Common.Authentication.AuthenticationFailedException] {
            Write-Error -Message "Failed to authenticate to Azure. Please check your credentials and try again."
        }
        catch {
            Write-Error -Message "An error occurred while adding tags to $ResourceId. Error message: $($_.Exception.Message)"
        }
    }
    end {
    }
}

function Build-AzureArcTagList {
    <#
    .SYNOPSIS
    Builds a hashtable of tags for Azure.
    .DESCRIPTION
    Builds a hashtable of tags for Azure specified by the parameters.
    .PARAMETER SiteName
    The name of the location.
    .PARAMETER Region
    The azure region of the location.
    .PARAMETER Environment
    The environment of the location. Valid values are p, np, and qa. The default value is p.
    .PARAMETER City
    The city of the location.
    .PARAMETER StateorDistrict
    The state of the location.
    .PARAMETER CountryOrRegion
    The country or region of the location.
    .PARAMETER Owner
    The owner of the location.
    .PARAMETER ITSMGroup
    The ITSM group of the location.
    .PARAMETER WorkloadName
    The workload name of the location.
    .PARAMETER TimeZone
    The time zone of the location.
    .EXAMPLE
    Build-AzureArcTagList -SiteName "New York" -Region EastUS -Environment p -City New York -State NY -CountryOrRegion US -Owner "AzureTeam" -ITSMGroup "AzureTeam" -WorkloadName "Azure Stack HCI Cluster Object" -TimeZone "US-Eastern"
    .NOTES
    Add Error handling
    .OUTPUTS
    Hashtable
    #>
    [OutputType([System.Collections.Hashtable])]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [string]$SiteName,
        [Parameter(Mandatory)]
        [ValidateSet("EastUS", "WestUS", "CentralUS", "NorthCentralUS", "SouthCentralUS", "NorthEurope", "WestEurope", "EastAsia", "SoutheastAsia", "JapanEast", "JapanWest", "AustraliaEast", "AustraliaSoutheast", "CentralIndia", "SouthIndia", "WestIndia", "CanadaCentral", "CanadaEast", "UKSouth", "UKWest", "WestCentralUS", "WestUS2", "KoreaCentral", "KoreaSouth", "FranceCentral", "FranceSouth", "SouthAfricaNorth", "SouthAfricaWest", "UAECentral", "UAENorth", "BrazilSouth", "EastUS2", "WestUS3", "NorthCentralUS", "SouthCentralUS", "WestCentralUS", "WestUS2", "EastAsia", "SoutheastAsia", "AustraliaEast", "AustraliaSoutheast", "CentralIndia", "SouthIndia", "WestIndia", "CanadaCentral", "CanadaEast", "WestEurope", "NorthEurope", "UKSouth", "UKWest", "WestCentralUS", "WestUS2", "KoreaCentral", "KoreaSouth", "FranceCentral", "FranceSouth", "SouthAfricaNorth", "SouthAfricaWest", "UAECentral", "UAENorth", "BrazilSouth")]
        [string]$Region,
        [Parameter(Mandatory = $false )]
        [ValidateSet('p', 'np', 'qa')]
        [string]$Environment = "p",
        [Parameter(Mandatory)]
        [string]$City,
        [Parameter(Mandatory)]
        [ValidateSet('AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY')]
        [string]$StateorDistrict,
        [Parameter(Mandatory = $false)]
        [ValidateSet('US', 'CA', 'CN')]
        [System.Globalization.RegionInfo]$CountryOrRegion = "US",
        [Parameter(Mandatory = $false)]
        [string]$Owner = "AzureTeam",
        [Parameter(Mandatory = $false)]
        [string]$ITSMGroup = "AzureTeam",
        [Parameter(Mandatory = $false)]
        [string]$WorkloadName = "Azure Stack HCI Cluster",
        [Parameter(Mandatory)]
        [ValidateSet('US-Eastern', 'US-Central', 'US-Mountain', 'US-Pacific')]
        [string]$TimeZone
    )
    begin {
    }
    process {
        try {
            if ($PSCmdlet.ShouldProcess("$SiteName")) {
                Write-verbose -Message "Building Azure Arc Tag List for Site: $SiteName"
                $countryOrRegionName = [System.Globalization.RegionInfo]::new($CountryOrRegion).Name

                $tags = @{"SiteName" = $SiteName; "Region" = $Region; "Environment" = $Environment; "City" = $City; "StateOrDistrict" = $StateorDistrict; "CountryOrRegion" = $countryOrRegionName; "Owner" = $Owner; "ITSMGroup" = $ITSMGroup; "WorkloadName" = $WorkloadName; "TimeZone" = $TimeZone }
                return $tags
            }
            else {
                Write-Error "Failed to process SiteName: $SiteName"
            }
        }
        catch {
            Write-Error "An error occurred while building the Azure Arc Tag List: $_"
        }
    }
    end {
    }
}

function Get-AzureArcResourceID {
    <#
    .SYNOPSIS
    Gets the resource ID for an Azure Arc resource.
    .DESCRIPTION
    This function gets the resource ID for an Azure Arc resource by name and resource group.
    .PARAMETER Name
    Specifies the name of the Azure Arc resource.
    .PARAMETER ResourceGroup
    Specifies the name of the resource group that the Azure Arc resource is in.
    .EXAMPLE
    PS C:\> Get-StoreAzureArcResourceID -Name "myAzureArcResource" -ResourceGroup "myResourceGroup"
    Returns the resource ID for the Azure Arc resource named "myAzureArcResource" in the resource group "myResourceGroup".
    #>
    [OutputType([string])]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [string]$Name,
        [Parameter(Mandatory)]
        [string]$ResourceGroup
    )
    begin {
    }
    process {
        try {
            if ($PSCmdlet.ShouldProcess("$Name")) {
                Write-Verbose -Message "Getting resource ID for $Name in resource group $ResourceGroup"
                $resource = Get-AzResource -Name $Name -ResourceGroup $ResourceGroup -ErrorAction Stop 
                if ($resource) {
                    Write-Verbose -Message "Found resource: $($resource.id)"
                    return $resource.id
                }
                else {
                    Write-Error -Message "Failed to find resource: $Name"
                }
            }
        }
        catch [Microsoft.Azure.Commands.Common.Authentication.AuthenticationFailedException] {
            Write-Error -Message "Failed to authenticate to Azure. Please check your credentials and try again."
        }
        catch {
            Write-Error -Message "An error occurred while getting the resource ID for $Name. Error message: $($_.Exception.Message)"
        }
    }
    end {
    }
}
