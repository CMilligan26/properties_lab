require('pg')

class Property

  attr_accessor :address, :value, :number_of_bedrooms, :build
  attr_reader :id

  def initialize( options )
    @address = options['address']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @build = options['build']
  end

  def save
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "INSERT INTO properties (address, value, number_of_bedrooms, build) VALUES ($1, $2, $3, $4) RETURNING *;"
    values = [@address, @value, @number_of_bedrooms, @build]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close()
  end

  def Property.all
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = 'SELECT * FROM properties;'
    db.prepare("all", sql)
    order_hashes = db.exec_prepared("all")
    db.close()
    return order_hashes.map{ | order_hash | Property.new(order_hash) }
  end

  def Property.delete_all
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "DELETE FROM properties;"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def delete
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = 'DELETE FROM properties WHERE id = $1;'
    value = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", value)
    db.close()
  end

  def update
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "UPDATE properties SET (address, value, number_of_bedrooms, build) = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@address, @value, @number_of_bedrooms, @build, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Property.find(id_to_find)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = 'SELECT * FROM properties WHERE id = $1;'
    value = [id_to_find]
    db.prepare("find", sql)
    property_to_find = db.exec_prepared("find", value)
    db.close()
    return property_to_find.map{ | order_hash | order_hash }
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = 'SELECT * FROM properties WHERE address = $1;'
    value = [address]
    db.prepare("find", sql)
    property_to_find = db.exec_prepared("find", value)
    db.close()
    return property_to_find.map{ | order_hash | order_hash }
  end



end
