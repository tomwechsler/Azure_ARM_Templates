# Azure ARM Templates
Deploy resources in Azure with Azure ARM and Bicep Templates

## The goal of this repository
This repository contains Azure ARM and Bicep templates to deploy resources in Azure. These templates can be used to deploy resources in Azure using the Azure CLI or Azure PowerShell.
The templates are not intended for the productive environment. They are for training and further education purposes. You assume responsibility when working with these templates.

## Pre-requisites
- Azure subscription
- Azure CLI or Azure PowerShell installed
- Azure account with permissions to deploy resources

## How to use the templates
1. Clone the repository to your local machine.
2. Navigate to the folder containing the template you want to deploy.
3. Use the Azure CLI or Azure PowerShell to deploy the template.

## Azure CLI
To deploy a template using the Azure CLI, use the following command:
```bash
az deployment group create --resource-group <resource-group-name> --template-file <template-file-name> --parameters <parameters-file-name>
```

## Azure PowerShell
To deploy a template using Azure PowerShell, use the following command:
```powershell
New-AzResourceGroupDeployment -ResourceGroupName <resource-group-name> -TemplateFile <template-file-name> -TemplateParameterFile <parameters-file-name>
```

## Bicep
To deploy a Bicep template, you can use the same commands as for ARM templates, but with the `.bicep` file extension:
```bash
az deployment group create --resource-group <resource-group-name> --template-file <template-file-name>.bicep --parameters <parameters-file-name>.json
```

## Contributing
Contributions are welcome! If you have any suggestions or improvements, feel free to create a pull request or open an issue.