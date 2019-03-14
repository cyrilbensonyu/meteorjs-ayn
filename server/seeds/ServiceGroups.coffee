serviceGroups = [
  {name: "Plumbing"}
  {name: "Roofing"}
  {name: "Heating and Air"}
  {name: "Handymen"}
  {name: "Electrical"}
  {name: "Power Washing"}
  {name: "Painting"}
  {name: "Kitchen and Bath"}
  {name: "Junk Removal and Hauling"}
  {name: "Moving"}
  {name: "House Cleaning"}
  {name: "Tree Work"}
  {name: "Carpet Cleaning"}
  {name: "Fencing"}
  {name: "Deck Maintenance"}
  {name: "Auto Insurance"}
  {name: "Auto Detailers and Car Washes"}
  {name: "Mobile Car Detailing"}
  {name: "Tire Stores"}
  {name: "Oil Change Stores"}
  {name: "Mobile Mechanic"}
  {name: "Body Work"}
  {name: "Classic Car Services"}
  {name: "General Mechanic"}
  {name: "Used Car Sales"}
]

_.each(serviceGroups, (serviceGroup) ->
  if not ServiceGroups.findOne({name: serviceGroup.name}) then ServiceGroups.insert(serviceGroup)
)