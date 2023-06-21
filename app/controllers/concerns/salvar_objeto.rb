# app/models/concerns/my_concern.rb
module SalvarObjeto
    extend ActiveSupport::Concern
  
    def salvar(obj)
        obj.save
    end
end
  