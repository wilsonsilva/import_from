module World
  VERSION = "1.0.0"
  TOTAL_CONTINENTS = 7

  # World-level methods
  def self.all_continents
    constants.select { |c| const_get(c).is_a?(Module) && c != :VERSION }
  end

  def self.total_countries
    all_continents.sum do |continent|
      const_get(continent).countries.count
    end
  end

  def self.find_country(name)
    all_continents.each do |continent|
      country = const_get(continent).find_country(name)
      return country if country
    end
    nil
  end

  # Base classes used across all levels
  class Continent
    attr_reader :name, :area_km2, :population

    def initialize(name, area_km2, population)
      @name = name
      @area_km2 = area_km2
      @population = population
    end

    def to_s
      "#{name} (Area: #{area_km2} km², Population: #{population})"
    end
  end

  class Country
    attr_reader :name, :capital, :population, :language

    def initialize(name, capital, population, language)
      @name = name
      @capital = capital
      @population = population
      @language = language
    end

    def to_s
      "#{name} - Capital: #{capital}, Population: #{population}, Language: #{language}"
    end
  end

  class City
    attr_reader :name, :population, :is_capital

    def initialize(name, population, is_capital = false)
      @name = name
      @population = population
      @is_capital = is_capital
    end

    def capital?
      @is_capital
    end

    def to_s
      capital_status = capital? ? " (Capital)" : ""
      "#{name}#{capital_status} - Population: #{population}"
    end
  end

  # ============================================================================
  # LEVEL 1: EUROPE (Continent Module)
  # ============================================================================
  module Europe
    CONTINENT_NAME = "Europe"
    AREA_KM2 = 10_180_000
    POPULATION = 748_000_000

    # Europe-level methods
    def self.info
      Continent.new(CONTINENT_NAME, AREA_KM2, POPULATION)
    end

    def self.countries
      constants.select { |c| const_get(c).is_a?(Module) }
    end

    def self.find_country(name)
      countries.find { |c| const_get(c)::COUNTRY_NAME == name }
    end

    def self.total_population
      countries.sum { |country| const_get(country)::POPULATION }
    end

    # --------------------------------------------------------------------------
    # LEVEL 2: PORTUGAL (Country Module within Europe)
    # --------------------------------------------------------------------------
    module Portugal
      COUNTRY_NAME = "Portugal"
      CAPITAL = "Lisbon"
      POPULATION = 10_300_000
      OFFICIAL_LANGUAGE = "Portuguese"
      CURRENCY = "Euro"

      # Portugal-level methods
      def self.info
        Country.new(COUNTRY_NAME, CAPITAL, POPULATION, OFFICIAL_LANGUAGE)
      end

      def self.cities
        constants.select { |c| const_get(c).is_a?(Class) && const_get(c) < City }
      end

      def self.largest_city
        cities.map { |c| const_get(c).new }.max_by(&:population)
      end

      def self.full_path
        "World::Europe::Portugal"
      end

      # ------------------------------------------------------------------------
      # LEVEL 3: Cities (City Classes within Portugal)
      # ------------------------------------------------------------------------
      class Lisbon < City
        def initialize
          super("Lisbon", 504_718, true)
        end

        def attractions
          ["Belém Tower", "Jerónimos Monastery", "São Jorge Castle"]
        end
      end

      class Porto < City
        def initialize
          super("Porto", 231_962, false)
        end

        def attractions
          ["Ribeira District", "Port Wine Cellars", "Clérigos Tower"]
        end
      end

      class Braga < City
        def initialize
          super("Braga", 193_333, false)
        end

        def attractions
          ["Bom Jesus do Monte", "Braga Cathedral"]
        end
      end
    end

    # --------------------------------------------------------------------------
    # LEVEL 2: SPAIN (Country Module within Europe)
    # --------------------------------------------------------------------------
    module Spain
      COUNTRY_NAME = "Spain"
      CAPITAL = "Madrid"
      POPULATION = 47_400_000
      OFFICIAL_LANGUAGE = "Spanish"
      CURRENCY = "Euro"

      def self.info
        Country.new(COUNTRY_NAME, CAPITAL, POPULATION, OFFICIAL_LANGUAGE)
      end

      def self.cities
        constants.select { |c| const_get(c).is_a?(Class) && const_get(c) < City }
      end

      def self.full_path
        "World::Europe::Spain"
      end

      # ------------------------------------------------------------------------
      # LEVEL 3: Cities (City Classes within Spain)
      # ------------------------------------------------------------------------
      class Madrid < City
        def initialize
          super("Madrid", 3_223_334, true)
        end

        def attractions
          ["Prado Museum", "Royal Palace", "Retiro Park"]
        end
      end

      class Barcelona < City
        def initialize
          super("Barcelona", 1_620_343, false)
        end

        def attractions
          ["Sagrada Família", "Park Güell", "La Rambla"]
        end
      end
    end
  end

  # ============================================================================
  # LEVEL 1: ASIA (Continent Module)
  # ============================================================================
  module Asia
    CONTINENT_NAME = "Asia"
    AREA_KM2 = 44_579_000
    POPULATION = 4_700_000_000

    # Asia-level methods
    def self.info
      Continent.new(CONTINENT_NAME, AREA_KM2, POPULATION)
    end

    def self.countries
      constants.select { |c| const_get(c).is_a?(Module) }
    end

    def self.find_country(name)
      countries.find { |c| const_get(c)::COUNTRY_NAME == name }
    end

    def self.total_population
      countries.sum { |country| const_get(country)::POPULATION }
    end

    # --------------------------------------------------------------------------
    # LEVEL 2: JAPAN (Country Module within Asia)
    # --------------------------------------------------------------------------
    module Japan
      COUNTRY_NAME = "Japan"
      CAPITAL = "Tokyo"
      POPULATION = 125_800_000
      OFFICIAL_LANGUAGE = "Japanese"
      CURRENCY = "Yen"

      # Japan-level methods
      def self.info
        Country.new(COUNTRY_NAME, CAPITAL, POPULATION, OFFICIAL_LANGUAGE)
      end

      def self.cities
        constants.select { |c| const_get(c).is_a?(Class) && const_get(c) < City }
      end

      def self.largest_city
        cities.map { |c| const_get(c).new }.max_by(&:population)
      end

      def self.full_path
        "World::Asia::Japan"
      end

      # ------------------------------------------------------------------------
      # LEVEL 3: Cities (City Classes within Japan)
      # ------------------------------------------------------------------------
      class Tokyo < City
        def initialize
          super("Tokyo", 13_960_000, true)
        end

        def attractions
          ["Tokyo Tower", "Senso-ji Temple", "Shibuya Crossing"]
        end
      end

      class Osaka < City
        def initialize
          super("Osaka", 2_750_000, false)
        end

        def attractions
          ["Osaka Castle", "Dotonbori", "Universal Studios Japan"]
        end
      end

      class Kyoto < City
        def initialize
          super("Kyoto", 1_464_000, false)
        end

        def attractions
          ["Fushimi Inari Shrine", "Kinkaku-ji", "Arashiyama Bamboo Grove"]
        end
      end
    end

    # --------------------------------------------------------------------------
    # LEVEL 2: THAILAND (Country Module within Asia)
    # --------------------------------------------------------------------------
    module Thailand
      COUNTRY_NAME = "Thailand"
      CAPITAL = "Bangkok"
      POPULATION = 71_600_000
      OFFICIAL_LANGUAGE = "Thai"
      CURRENCY = "Baht"

      def self.info
        Country.new(COUNTRY_NAME, CAPITAL, POPULATION, OFFICIAL_LANGUAGE)
      end

      def self.cities
        constants.select { |c| const_get(c).is_a?(Class) && const_get(c) < City }
      end

      def self.full_path
        "World::Asia::Thailand"
      end

      # ------------------------------------------------------------------------
      # LEVEL 3: Cities (City Classes within Thailand)
      # ------------------------------------------------------------------------
      class Bangkok < City
        def initialize
          super("Bangkok", 10_700_000, true)
        end

        def attractions
          ["Grand Palace", "Wat Pho", "Chatuchak Market"]
        end
      end

      class ChiangMai < City
        def initialize
          super("Chiang Mai", 1_200_000, false)
        end

        def attractions
          ["Doi Suthep", "Old City Temples", "Night Bazaar"]
        end
      end
    end
  end

  # ============================================================================
  # LEVEL 1: NORTH AMERICA (Continent Module)
  # ============================================================================
  module NorthAmerica
    CONTINENT_NAME = "North America"
    AREA_KM2 = 24_709_000
    POPULATION = 592_000_000

    def self.info
      Continent.new(CONTINENT_NAME, AREA_KM2, POPULATION)
    end

    def self.countries
      constants.select { |c| const_get(c).is_a?(Module) }
    end

    def self.find_country(name)
      countries.find { |c| const_get(c)::COUNTRY_NAME == name }
    end

    # --------------------------------------------------------------------------
    # LEVEL 2: USA (Country Module within North America)
    # --------------------------------------------------------------------------
    module USA
      COUNTRY_NAME = "United States"
      CAPITAL = "Washington, D.C."
      POPULATION = 331_900_000
      OFFICIAL_LANGUAGE = "English"
      CURRENCY = "US Dollar"

      def self.info
        Country.new(COUNTRY_NAME, CAPITAL, POPULATION, OFFICIAL_LANGUAGE)
      end

      def self.cities
        constants.select { |c| const_get(c).is_a?(Class) && const_get(c) < City }
      end

      def self.full_path
        "World::NorthAmerica::USA"
      end

      # ------------------------------------------------------------------------
      # LEVEL 3: Cities (City Classes within USA)
      # ------------------------------------------------------------------------
      class NewYork < City
        def initialize
          super("New York", 8_336_817, false)
        end

        def attractions
          ["Statue of Liberty", "Central Park", "Times Square"]
        end
      end

      class WashingtonDC < City
        def initialize
          super("Washington, D.C.", 689_545, true)
        end

        def attractions
          ["White House", "National Mall", "Smithsonian Museums"]
        end
      end
    end
  end
end

# ============================================================================
# DEMONSTRATION CODE
# ============================================================================

puts "=" * 80
puts "GEOGRAPHY DATA MODEL DEMONSTRATION"
puts "=" * 80
puts

# Level 1: World-level operations
puts "WORLD LEVEL (Level 1):"
puts "-" * 80
puts "Total continents: #{World::TOTAL_CONTINENTS}"
puts "Continents in model: #{World.all_continents.join(', ')}"
puts "Total countries in model: #{World.total_countries}"
puts

# Level 2: Continent-level operations
puts "CONTINENT LEVEL (Level 2):"
puts "-" * 80
puts "Europe Info: #{World::Europe.info}"
puts "Europe Countries: #{World::Europe.countries.join(', ')}"
puts "Europe Total Population: #{World::Europe.total_population.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
puts

puts "Asia Info: #{World::Asia.info}"
puts "Asia Countries: #{World::Asia.countries.join(', ')}"
puts

# Level 3: Country-level operations
puts "COUNTRY LEVEL (Level 3):"
puts "-" * 80
puts "Portugal Info: #{World::Europe::Portugal.info}"
puts "Portugal Currency: #{World::Europe::Portugal::CURRENCY}"
puts "Portugal Cities: #{World::Europe::Portugal.cities.join(', ')}"
puts "Portugal Full Path: #{World::Europe::Portugal.full_path}"
puts

puts "Japan Info: #{World::Asia::Japan.info}"
puts "Japan Currency: #{World::Asia::Japan::CURRENCY}"
puts "Japan Cities: #{World::Asia::Japan.cities.join(', ')}"
puts "Japan Largest City: #{World::Asia::Japan.largest_city}"
puts

# Level 4: City-level operations (instances of classes)
puts "CITY LEVEL (Level 4 - Class Instances):"
puts "-" * 80
lisbon = World::Europe::Portugal::Lisbon.new
puts "Lisbon: #{lisbon}"
puts "Is Lisbon a capital? #{lisbon.capital?}"
puts "Lisbon Attractions: #{lisbon.attractions.join(', ')}"
puts

tokyo = World::Asia::Japan::Tokyo.new
puts "Tokyo: #{tokyo}"
puts "Tokyo Attractions: #{tokyo.attractions.join(', ')}"
puts

# Cross-level operations
puts "CROSS-LEVEL OPERATIONS:"
puts "-" * 80
country = World.find_country("Japan")
if country
  puts "Found Japan in: #{World::Asia::Japan.full_path}"
  puts "Info: #{World::Asia::Japan.info}"
end
puts

# Demonstrating clear hierarchy
puts "HIERARCHY DEMONSTRATION:"
puts "-" * 80
puts "World::Europe::Portugal::Lisbon"
puts "  └─ World (Module)"
puts "      └─ Europe (Module) - Continent"
puts "          └─ Portugal (Module) - Country"
puts "              └─ Lisbon (Class < City) - City Instance"
puts

# Show all paths
puts "ALL AVAILABLE PATHS:"
puts "-" * 80
[
  "World::Europe::Portugal::Lisbon",
  "World::Europe::Portugal::Porto",
  "World::Europe::Spain::Madrid",
  "World::Europe::Spain::Barcelona",
  "World::Asia::Japan::Tokyo",
  "World::Asia::Japan::Osaka",
  "World::Asia::Japan::Kyoto",
  "World::Asia::Thailand::Bangkok",
  "World::NorthAmerica::USA::NewYork",
  "World::NorthAmerica::USA::WashingtonDC"
].each { |path| puts "  • #{path}" }
