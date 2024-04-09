targetScope = 'subscription'

param tagObject object = {}

resource applyTags 'Microsoft.Resources/tags@2021-04-01' = {
  name: 'default'
  properties: {
    tags: union(tagObject,{
      iac: 'bicep-${uniqueString(deployment().name)}'
    })
  }
}
