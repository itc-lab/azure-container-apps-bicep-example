param containerAppName string
param location string 
param environmentName string 
param containerImage string
param containerPort int
param isExternalIngress bool
param containerRegistry string
param containerRegistryUsername string
param isPrivateRegistry bool
param enableIngress bool = true
@secure()
param registryPassword string
param minReplicas int = 0
param secrets array = []
param env array = []
param revisionMode string = 'Single'

resource environment 'Microsoft.App/managedEnvironments@2022-03-01' existing = {
  name: environmentName
}

var resources = [
  {
    cpu: '0.25'
    memory: '0.5Gi'
  }
  {
    cpu: '0.5'
    memory: '1.0Gi'
  }
  {
    cpu: '0.75'
    memory: '1.5Gi'
  }
  {
    cpu: '1.0'
    memory: '2.0Gi'
  }
  {
    cpu: '1.25'
    memory: '2.5Gi'
  }
  {
    cpu: '1.5'
    memory: '3.0Gi'
  }
  {
    cpu: '1.75'
    memory: '3.5Gi'
  }
  {
    cpu: '2.0'
    memory: '4.0Gi'
  }
]

resource containerApp 'Microsoft.App/containerApps@2022-03-01' = {
  name: containerAppName
  location: location
  properties: {
    managedEnvironmentId: environment.id
    configuration: {
      activeRevisionsMode: revisionMode
      secrets: secrets
      registries: isPrivateRegistry ? [
        {
          server: containerRegistry
          username: containerRegistryUsername
          passwordSecretRef: registryPassword
        }
      ] : null
      ingress: enableIngress ? {
        allowInsecure: false
        external: isExternalIngress
        targetPort: containerPort
        transport: 'auto'
        traffic: [
          {
            latestRevision: true
            weight: 100
          }
        ]
      } : null
      dapr: {
        enabled: false
      }
    }
    template: {
      containers: [
        {
          image: containerImage
          name: containerAppName
          env: env
          resources: resources[0]
          probes: [
            {
              httpGet: {
                path: '/'
                port: 3000
                scheme: 'HTTP'
              }
              initialDelaySeconds: 60
              periodSeconds: 30
              timeoutSeconds: 10
              type: 'Startup'
            }
          ]
        }
      ]
      scale: {
        minReplicas: minReplicas
        maxReplicas: 1
      }
    }
  }
}

output fqdn string = enableIngress ? containerApp.properties.configuration.ingress.fqdn : 'Ingress not enabled'
