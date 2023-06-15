class Cliente {
    constructor(obj = {id: 0, nome: "", telefone: "", endereco: ""}) {
        this.id = obj.id
        this.nome = obj?.nome
        this.telefone = obj?.telefone
        this.endereco = obj?.endereco
    }
}
