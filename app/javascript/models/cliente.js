export class Cliente {
    constructor(obj = {id: 0}) {
        this.id = obj.id
        this.nome = obj?.nome
        this.telefone = obj?.telefone
        this.endereco = obj?.endereco
    }
}
