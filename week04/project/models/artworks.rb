class Artwork

  attr_reader(:id, :title, :details, :date_created, :artist_id, :category_id)

  require_relative('../db/sql_runner.rb')

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @details = options['details']
    @date_created = options['date_created']
    @artist_id = options['artist_id'].to_i
    @category_id = options['category_id'].to_i
  end

  def save
    sql = 'INSERT INTO artworks (title, details, date_created, artist_id, category_id) VALUES ($1, $2, $3, $4, $5) RETURNING *'
    values = [@title, @details, @date_created, @artist_id, @category_id]
    returned_data = SqlRunner.run(sql, values)
    @id = returned_data[0]['id'].to_i
  end

  def self.delete(id)
    sql = 'DELETE FROM artworks WHERE id = $1'
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = 'DELETE FROM artworks'
    SqlRunner.run(sql)
  end

  def self.show_all
    sql = 'SELECT * FROM artworks ORDER BY artist_id'
    artworks_data = SqlRunner.run(sql)
    return artworks_data.map { |artwork| Artwork.new(artwork) }
  end

  def self.find(id)
    sql = "SELECT * FROM artworks WHERE id = $1"
    values = [id]
    artworks_data = SqlRunner.run(sql, values)
    return Artwork.new(artworks_data.first)
  end

  def self.find_by_artist(id)
    sql = "SELECT * FROM artworks WHERE artist_id = $1"
    values = [id]
    artworks_data = SqlRunner.run(sql, values)
    return artworks_data.map { |artwork| Artwork.new(artwork) }
  end

  def self.find_by_category(id)
    sql = "SELECT * FROM artworks WHERE category_id = $1"
    values = [id]
    artworks_data = SqlRunner.run(sql, values)
    return artworks_data.map { |artwork| Artwork.new(artwork) }
  end

  def self.delete_by_artist(id)
    sql = "DELETE FROM artworks WHERE artist_id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE artworks SET (title, details, date_created, artist_id, category_id) =
    ($1, $2, $3, $4, $5) WHERE id = $6"
    values = [@title, @details, @date_created, @artist_id, @category_id, @id]
    SqlRunner.run(sql, values)
  end

end
