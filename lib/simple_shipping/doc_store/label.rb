module SimpleShipping
  module DocStore
    class Label < ActiveResource::Base
      self.site = defined?(Settings) ? Settings.doc_store.site : "http://localhost:8080/"
      self.element_name = "document"
    end
  end
end
