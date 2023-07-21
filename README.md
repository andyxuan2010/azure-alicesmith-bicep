# azure-alicesmith-bicep

## Quickstart: Create an Game XR Server for PlayFab by BICEP

### Overview
Zero-code API server and gamification toolkit for PlayFab with Twitch and Unreal Engine support
XR server for Playfab by Alice and Smith drastically cuts down on the number of resources required to develop and manage your live ops, leaving more time for you to focus on what matters most: your product and your community. --- Quickly integrate Microsoft Playfab, Twitch API, Microsoft Teams, Unreal Engine, and other tools under a compliant on-premise solution. Key features include Full access to all Microsoft PlayFab APIs, Player progression, XP, badges, leaderboard, advanced store engine, segmentation management, crafting, loot table, multiple currencies, loyalty mechanics, mission system, community objective, vote, poll, and more. XRServer is compatible with Azure FrontDoor firewall security, Azure Events Stream, Playstream, and Azure Synapse Analytics. --- Pre-built third-party integration with Twitch, Twitch Extension, Twitch API, Unity, Google AI DialogFlow, Authentication service (AD B2B, AD B2C, MS Teams, JWT, Auth0, Custom ID ...) --- Build various products and solutions for Triple-A Console, PC, and Mobile game with Unreal Engine, Loyalty Program, gamified store, interactive products, Corporate Training, Coaching platform, and many more... --- Advanced Analytics and Security: Play stream ingestion for Microsoft Events Hub, Integration with Azure Data Factory and Azure Synapse Analytics, Websocket Subscription with SignalR, PowerBI, SQL and Datawarehouse support. On-Premise compliance for Azure Front Door, Azure Load Balancer, Backup & Restore, etc. --- To set up your instance, visit: https://azuremarketplace.microsoft.com/en/marketplace/apps/asdivertissementinc1617837708654.playfab_xr

to create a virtual machine on console:
https://portal.azure.com/#create/asdivertissementinc1617837708654.playfab_xrxr-server-v03


![Alt text](image-1.png)
![Alt text](image-2.png)
![Alt text](image-3.png)

Want to deploy programmatically? Get started


### Prerequisites
An Azure subscription. If you don't have an Azure subscription, create a free account before you begin.


### Review the Bicep file

code xr-core-server.bicep



### Deploy the Bicep file
az group create --name rg-alicesmith --location eastus

or to create resourcegroup by bicep instead of CLI

az deployment sub create --template-file modules/rg-alicesmith.bicep --location eastus

az deployment group create --resource-group rg-alicesmith --template-file xr-core-server.bicep


### Review deployed resources

az resource list --resource-group rg-alicesmith

for demo purpose a test public dns zone was created:   dev.argentiacapital.com
We can access the VM on the port HTTP/80 
http://demo.dev.argentiacapital.com
![Alt text](image-4.png)
![Alt text](image-5.png)

### Clean up resources
az group delete --name rg-alicesmith


## Github action CI/CD pipeline integration


name: Azure BICEP Preview & Deploy
jobs:
  preview-bicep-changes:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@main
    - name: Login to Azure
      uses: azure/login@v1
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}
    - name: Create Azure Resource Group
      uses: Azure/cli@v1.0.6
      with:
        inlineScript: |
          az version
          az group create -n $RESOURCE_GROUP -l eastus
    - name: Preview Changes fron Bicep
      uses: Azure/deployment-what-if-action@v1.0.0
      with:
        subscription: ${{ secrets.AZURE_SUBSCRIPTION }} # Subscription ID
        resourceGroup: $RESOURCE_GROUP # Resource group name
        templateFile: xr-core-server.bicep # ARM template or Bicep file
  deploy-azure-bicep:
    needs: [preview-bicep-changes]
    runs-on: ubuntu-latest
    steps:    
      - uses: actions/checkout@main
      - name: Login to Azure
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
      - name: Deploy Bicep to Azure
        uses: azure/arm-deploy@v1
        with:
          subscriptionId: ${{ secrets.AZURE_SUBSCRIPTION }}
          #resourceGroupName: ${{ vars.AZURE_RG_ALICESMITH }}
          resourceGroupName: ${{ env.RESOURCE_GROUP }}
          template: xr-core-server.bicep
          failOnStdErr: false
          scope: resourcegroup



![Alt text](image-6.png)




### Resource diagram
![Alt text](image.png)