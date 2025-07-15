#Install the Azure PowerShell Module
Install-Module -Name Az -AllowClobber -Verbose -Force

#Connect to Azure
Connect-AzAccount

#List all resource groups
Get-AzResourceGroup

#What if
New-AzResourceGroupDeployment -Name whatifdeploy3 -ResourceGroupName "whatIfrg" -TemplateFile .\05_02_vmWhatIf.bicep -Whatif -Mode Complete
