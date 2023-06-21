# app/models/concerns/my_concern.rb
module BuscaPorId
    extend ActiveSupport::Concern
  
    ## Cria médodos para instancia do objeto
    # included do
    #   def busca_por_id(id)
    #     self.class.find(id)
    #   end
    # end
  
    ## Cria médodos para a classe ou seja métodos staticos
    # class_methods do
    #     def busca_por_id(id)
    #         self.find(id)
    #     end
    # end
  

    ## Define médodos para instancia do objeto diretamente
    def busca_por_id(id)
        self.class.find(id)
    end
end
  