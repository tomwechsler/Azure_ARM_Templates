#Install the Azure PowerShell Module
Install-Module -Name Az -AllowClobber -Verbose -Force

#Connect to Azure
Connect-AzAccount

#List all resource groups
Get-AzResourceGroup

#Create a new resource group
New-AzResourceGroup -Name "cttdemorg" -location "westeurope"

#Deploy the armtemplate file
New-AzResourceGroupDeployment -name "armtemplate" -ResourceGroupName "psdemorg" -TemplateFile "./03_01_blanksamplearm.json" -WhatIf

#Delete the resource group
Remove-AzResourceGroup -Name "psdemorg" -Force