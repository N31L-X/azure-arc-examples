# Azure Arc & Related Stuff

## Introduction

[Azure Arc](https://azure.microsoft.com/en-us/services/azure-arc/) is a service that allows you to manage resources outside of Azure. It's a great way to manage resources in a hybrid cloud environment. If you're not familiar with Azure Arc, I recommend you check out the [Azure Arc Jumpstart](https://azurearcjumpstart.io/) as it has a lot of great information. There is also a [GitHub repo](https://github.com/microsoft/azure_arc).

## Getting Started

I'm going to assume you have an Azure subscription. Beyond that you can use the code in the basic bicep files folder to get started. You'll need to create a resource group and then deploy the bicep files.

This repo will serves as my catch all for all the code I write on my personal time for Azure Arc & other Azure Services. I'll try to keep it organized but no promises. I'll also try to keep it up to date with the latest versions of the various services.

## Structure

The repo is broken down into folders based on the service. Each folder will have a README.md file that will have more information about the code in that folder. I'll try to keep the README.md files up to date with the latest information.

Here are a few things I will be adding to this repo:

- Prepare AD for Azure Stack HCI in a hybrid environment. Specifically leveraging Azure Automation with a Hybrid Worker to run the commands.
- Powershell to edit certain Azure Stack HCI settings
- Azure Arc and Azure Stack HCI Bicep files
- Update Management
- Azure Arc Automanage Machine Configuration and Azure Policy
- Azure Monitor for VMs, HCI, and Kubernetes
