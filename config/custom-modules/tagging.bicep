targetScope = 'subscription'

param tagObject object = {
  env: 'production'
  owner: 'Kathak'
  tenanttechnicalcontact: 'kathak.mridha@au.ey.com'
  costcentre: '000'
  notifyemail: 'kathak.mridha@au.ey.com'
  apmid: 'NA'
  apmname: 'NA'
  datarating: 'private'
  iac: 'bicep'
}

param managementSubID string = 'c57a9a06-e36a-452a-a1ab-16b99eb747bf'

module tagManagementSub 'tagSubscription/management.bicep' = {
  scope: subscription(managementSubID)
  name: 'deploy-tags-to-management-sub'
  params: {
    tagObject: tagObject
  }
}

param identitySubID string = '5f6f76b7-e6a2-4de8-9f9e-8547c1549883'

module tagIdentitySub 'tagSubscription/identity.bicep' = {
  scope: subscription(identitySubID)
  name: 'deploy-tags-to-identity-sub'
  params: {
    tagObject: tagObject
  }
}

param connectivitySubID string = '40b00656-92a1-428a-8bd2-aa0c8346e9b5'

module tagConnectivitySub 'tagSubscription/connectivity.bicep' = {
  scope: subscription(connectivitySubID)
  name: 'deploy-tags-to-connectivity-sub'
  params: {
    tagObject: tagObject
  }
}
