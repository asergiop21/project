class Article < ActiveRecord::Base
    scope :con_nombre_barcode, ->(nombre){where("articles.name ILIKE ? or barcode = ?","#{nombre}%".downcase, nombre)}
    scope :con_nombre,   ->(nombre){joins(:supplier).where("LOWER(articles.name) ILIKE ?", "#{nombre}%".downcase)  }
    scope :con_id, ->(id){ where('id = ?', "#{id}")}
   
has_many :orders


   def label
           [barcode, "$  #{price_total}"].compact.join ' | '
              end

      def as_json options = nil
              default_options = { only: [:id, :price_total], methods: [:label] }
                    super default_options.merge(options || {})
                       end

      end
