class Article < ActiveRecord::Base

  has_attached_file :image, styles: {medium: '200x200>', small: '100x100' , thumb:'48x48>'}
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  scope :con_nombre_barcode, ->(nombre){where("articles.name ILIKE ? or barcode = ?","#{nombre}%".downcase, nombre)}
  scope :con_nombre, ->(nombre){joins(:supplier).where("LOWER(articles.name) ILIKE ?", "#{nombre}%".downcase) }
  scope :con_id, ->(id){ where('id = ?', "#{id}")}


  has_many :orders
  has_many :stocks
  has_many :deadlines
  belongs_to :category
  belongs_to :supplier

  delegate :name, to: :supplier, prefix: true, allow_nil: true
  accepts_nested_attributes_for :deadlines, :allow_destroy => true 

  def self.quantity_order(id)
    id.each do |b|
      stock_current = Article.find(b.article_id).quantity
      quantity = b.quantity
      stock_current = 0 if stock_current.nil?
      stock = stock_current - quantity
      Article.find_by_id(b.article_id).update_attribute(:quantity, stock)
    end
  end

  def lab
    [name]
  end

  def label
    [barcode, name,supplier.try(:name),"$  #{price_total}"].compact.join ' | '
  end
  def as_json options = nil
    default_options = { only: [:id, :price_total, :quantity, :price_cost, :allow_negative, :allow_change_price, :quantity], methods: [:label] }
    super default_options.merge(options || {})
  end
  def to_s
    name
  end

  def self.current_due_date
    @articles = Deadline.where(due_date: (Time.now.midnight)..(Time.now.midnight + 15.day)).order(due_date: :asc)
  end

  def self.to_csv

    CSV.generate do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end
end
