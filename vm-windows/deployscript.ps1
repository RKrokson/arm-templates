Param(
	[Parameter(
		Mandatory=$True,
		HelpMessage='Error: Please enter a file path to the template file.'
    )]$templateFile,
    [Parameter(
        Mandatory=$True,
        HelpMessage='Error: Plase enter a file path to the parameter file.'
    )]$TemplateParameterFile,
    [Parameter(
        Mandatory=$true,
        HelpMessage='Error: Please enter a VM User Name.'
    )]$adminUsername,
    [Parameter(
        Mandatory=$true,
        HelpMessage='Error: Please enter a VM password.'
    )][SecureString] $adminPassword,
    [Parameter(
        Mandatory=$true,
        HelpMessage='Error: Please enter a name for the VM.'
    )]$vmName,
    [Parameter(
        Mandatory=$true,
        HelpMessage='Error: Please enter a location for the VM.'
    )]$vmLocation,
    [Parameter(
        Mandatory=$true,
        HelpMessage='Error" Please enter if the vNet is new or existing.'
    )]$vnetNewOrExisting,
    [Parameter(
        Mandatory=$true,
        HelpMessage='Error: Please enter the name of an existing or new vNet.'
    )]$vnetName,
    [Parameter(
        Mandatory=$true,
        HelpMessage='Error: Please enter the name of an existing or new RG for a vNet.'
    )]$vnetRgName,
    [Parameter(
        Mandatory=$true,
        HelpMessage='Error: Please enter the name of an existing or new subnet.'
    )]$vnetSubnet
)

$vmRG = "vm-" + "$vmName" + "-rg"

New-AzResourceGroup `
  -Name $vmRG `
  -Location $vmLocation

Write-Host "Resouce Group named $vmRG has been created in $vmLocation."

New-AzResourceGroupDeployment `
    -ResourceGroupName $vmRG `
    -TemplateFile $templateFile `
    -TemplateParameterFile $TemplateParameterFile `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
    -vmName $vmName `
    -virtualNetworkName $vnetName `
    -subnetName $vnetSubnet `
    -virtualNetworkResourceGroupName $vnetRgName `
    -virtualNetworkNewOrExisting $vnetNewOrExisting