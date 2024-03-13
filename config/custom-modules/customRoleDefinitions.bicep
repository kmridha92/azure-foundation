// This module has been modified from the upstream-releases version 0.17.2

targetScope = 'managementGroup'

metadata name = 'ALZ Bicep - Custom Role Definitions'
metadata description ='Custom Role Definitions for ALZ Bicep'

@sys.description('The management group scope to which the role can be assigned. This management group ID will be used for the assignableScopes property in the role definition.')
param parAssignableScopeManagementGroupId string = 'alz'

@sys.description('Set Parameter to true to Opt-out of deployment telemetry.')
param parTelemetryOptOut bool = false

// // Customer Usage Attribution Id
var varCuaid = '032d0904-3d50-45ef-a6c1-baa9d82e23ff'

module modRolesPlatformOwnerRole 'roleDefinitions/cafAzurePlatformOwnerRole.bicep' = {
  name: 'deploy-platform-owner-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesSubscriptionOwnerRole 'roleDefinitions/cafSubscriptionOwnerRole.bicep' = {
  name: 'deploy-subscription-owner-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesApplicationOwnerRole 'roleDefinitions/cafApplicationOwnerRole.bicep' = {
  name: 'deploy-application-owner-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesNetworkManagementRole 'roleDefinitions/cafNetworkManagementRole.bicep' = {
  name: 'deploy-network-management-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesSecurityOperationsRole 'roleDefinitions/cafSecurityOperationsRole.bicep' = {
  name: 'deploy-security-operations-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

// Optional Deployment for Customer Usage Attribution
module modCustomerUsageAttribution 'customerUsageAttribution/cuaIdManagementGroup.bicep' = if (!parTelemetryOptOut) {
  #disable-next-line no-loc-expr-outside-params //Only to ensure telemetry data is stored in same location as deployment. See https://github.com/Azure/ALZ-Bicep/wiki/FAQ#why-are-some-linter-rules-disabled-via-the-disable-next-line-bicep-function for more information
  name: 'pid-${varCuaid}-${uniqueString(deployment().location)}'
  params: {}
}

output outRolesPlatformOwnerRoleId string = modRolesPlatformOwnerRole.outputs.outRoleDefinitionId 
output outRolesSubscriptionOwnerRoleId string = modRolesSubscriptionOwnerRole.outputs.outRoleDefinitionId
output outRolesApplicationOwnerRoleId string = modRolesApplicationOwnerRole.outputs.outRoleDefinitionId
output outRolesNetworkManagementRoleId string = modRolesNetworkManagementRole.outputs.outRoleDefinitionId
output outRolesSecurityOperationsRoleId string = modRolesSecurityOperationsRole.outputs.outRoleDefinitionId
