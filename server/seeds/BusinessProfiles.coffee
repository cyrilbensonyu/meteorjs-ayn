currentCount = BusinessProfiles.find({}).count()
createCount = 25 - currentCount

faker = require('Faker')

getRandomServiceLocations = () ->
  numberOfServiceLocations = _.random(1,8)
  serviceLocations = []
  _(numberOfServiceLocations).times(() ->
    serviceLocations.push(faker.Lorem.words().join(" "))
  )
  return Meteor.call('updateServiceLocations',serviceLocations)

getRandomServiceGroup = () ->
  serviceGroups = ServiceGroups.find({}).fetch()
  return if serviceGroups.length then serviceGroups[_.random(0,serviceGroups.length-1)]._id

getRandomSpecialties = () ->
  numberOfSpecialties = _.random(1,8)
  specialties = []
  _(numberOfSpecialties).times(() ->
    specialties.push(faker.Lorem.words().join(" "))
  )
  return Meteor.call('updateSpecialtyTags',specialties)

_(createCount).times(() ->
  businessProfile =
    businessName:faker.Company.companyName()
    firstName:faker.Name["firstName#{_.sample(['Male','Female'])}"]()
    lastName:faker.Name.lastName()
    address:faker.Address.streetAddress()
    serviceLocations:getRandomServiceLocations()
    serviceGroup:getRandomServiceGroup()
    phoneNumber:faker.PhoneNumber.phoneNumber()
    website:faker.Internet.domainName()
    yearsInBusiness:_.random(1,20)
    isInsured:_.random(0,1)
    isBonded:_.random(0,1)
    isLicensed:_.random(0,1)
    businessDescription:faker.Lorem.paragraph()
    specialties:getRandomSpecialties()
    openingHours:
      monday:"08:00 AM - 06:00 PM"
      tuesday:"08:00 AM - 06:00 PM"
      wednesday:"08:00 AM - 06:00 PM"
      thursday:"08:00 AM - 06:00 PM"
      friday:"08:00 AM - 06:00 PM"
      saturday:"closed"
      sunday:"closed"
    step1Complete:true
    step2Complete:true
    userId:null
    personal:
      firstName:faker.Name["firstName#{_.sample(['Male','Female'])}"]()
      lastName:faker.Name.lastName()
      address:faker.Address.streetAddress()
      city:faker.Address.city()
      email:faker.Internet.email()
      zip:faker.Address.zipCode()
      phoneNumber:faker.PhoneNumber.phoneNumber()
    suspended:false
  BusinessProfiles.insert(businessProfile)
)