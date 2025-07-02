# Azure Resource Manager Template Toolkit

## Download and Installation
Download the toolkit from the [GitHub repository](https://github.com/Azure/arm-ttk/releases) and extract it to a folder of your choice.

## Usage
The Azure Resource Manager Template Toolkit (arm-ttk) is a PowerShell module that provides a set of tools to validate and test Azure Resource Manager (ARM) templates. It helps ensure that your ARM templates are compliant with best practices and can be deployed successfully.

### Prerequisites
- PowerShell 5.1 or later
- Azure PowerShell module installed
- Azure CLI installed (optional, for additional functionality)

### Installation
To install the arm-ttk module, open PowerShell and run the following command:
```powershell
#If your execution policy blocks scripts from the Internet, you need to unblock the script files. Make sure you're in the arm-ttk folder
Get-ChildItem *.ps1, *.psd1, *.ps1xml, *.psm1 -Recurse | Unblock-File

#Import the module
Import-Module .\arm-ttk.psd1
```

### Running Tests
To run the tests on an ARM template, use the following command:
```powershell
#To run the tests, use the following command
Test-AzTemplate -TemplatePath \path\to\template
```

### Link to Documentation
For detailed documentation on how to use the arm-ttk module, refer to the [arm-ttk documentation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/test-toolkit).