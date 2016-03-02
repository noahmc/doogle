class EntryFinder
  def self.locate(word)
    return nil if word.nil?
    Entry.find_by(word: word) || self.dictionary_lookup(word)
  end

  private

  def self.dictionary_lookup(word)
    res = DictionaryWebService.get_definitions_for(word)

    content = Nokogiri.XML(res.body)
    definitions = []
    content.xpath('//entry_list//entry//def//dt').each do |definition|
      definitions << definition.content
    end

    entry = Entry.create!(word: word)

    definitions.each do |definition|
      entry.definitions.create!(description: definition)
    end

    entry
  end
end