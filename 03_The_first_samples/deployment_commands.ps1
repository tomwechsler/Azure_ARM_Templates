#Install the Azure PowerShell Module
Install-Module -Name Az -AllowClobber -Verbose -Force

#Connect to Azure
Connect-AzAccount

#Create a new resource group
New-AzResourceGroup -Name "psdemorg" -location "switzerlandnorth"

#Deploy the armtemplate file
New-AzResourceGroupDeployment -name "armtemplate" -ResourceGroupName "psdemorg" -TemplateFile "the file name"