require_relative('property')

Property.delete_all()

property1 = Property.new({'address' => '125 Mainstreet', 'value' => '12500', 'number_of_bedrooms' => '3', 'build' => 'flat'})

property2 = Property.new({'address' => '12 Mainstreet', 'value' => '12500', 'number_of_bedrooms' => '3', 'build' => 'flat'})

property1.save()
property2.save

# property1.delete
# property2.value = '24600'
# property2.update
#
# properties = Property.all()

puts Property.find(property2.id)
puts Property.find_by_address('125 Mainstreet')
