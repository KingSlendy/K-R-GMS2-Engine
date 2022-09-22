{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "objIceWater",
  "spriteId": {
    "name": "sprIceWater",
    "path": "sprites/sprIceWater/sprIceWater.yy",
  },
  "solid": false,
  "visible": true,
  "managed": true,
  "spriteMaskId": null,
  "persistent": false,
  "parentObjectId": {
    "name": "objOceanWater",
    "path": "objects/objOceanWater/objOceanWater.yy",
  },
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 1,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":3,"collisionObjectId":null,},
  ],
  "properties": [
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"time","varType":4,"value":"irandom(249)","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],},
  ],
  "overriddenProperties": [
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"slip","path":"objects/objOceanWater/objOceanWater.yy",},"objectId":{"name":"objOceanWater","path":"objects/objOceanWater/objOceanWater.yy",},"value":"0.15",},
  ],
  "parent": {
    "name": "Ice",
    "path": "folders/Objects/Misc/Water/Ocean Wetventure/Ice.yy",
  },
}