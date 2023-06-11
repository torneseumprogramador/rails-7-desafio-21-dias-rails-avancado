import { Controller } from "@hotwired/stimulus";
import { Cliente } from "../models/cliente";
import { ClienteServico } from "../servicos/clientes_servico";
import renderClientesTable from "../templates/clientes/index";
import renderClientesForm from "../templates/clientes/new";

export default class extends Controller {
  connect() {
    this.cliente = new Cliente()
    this.paginaCorrente = 1
    this.loadClientes();
  }

  proximo(){
    this.paginaCorrente += 1
    this.loadClientes();
  }

  anterior(){
    this.paginaCorrente -= 1
    if(this.paginaCorrente < 1) this.paginaCorrente = 1
    this.loadClientes();
  }
  
  async loadClientes(event) {
    if(event) event.preventDefault();
    
    this.cliente = new Cliente()
    const clientes = await ClienteServico.todos(this.paginaCorrente);
    this.element.innerHTML = renderClientesTable(clientes, this.paginaCorrente);
  }

  async alterar(event) {
    event.preventDefault();
    this.cliente = JSON.parse(event.currentTarget.dataset.cliente);
    this.formClientes();
  }

  async excluir(event) {
    event.preventDefault();
    const cliente = JSON.parse(event.currentTarget.dataset.cliente);
    if(confirm("Deseja realmente excluir ?")){
      
      const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      await ClienteServico.delete(cliente.id, csrfToken)

      this.loadClientes();
    }
  }

  formClientes(event) {
    if(event) event.preventDefault();
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    this.element.innerHTML = renderClientesForm(this.cliente, csrfToken);
  }

  valido(){
    if(document.getElementById("cliente_nome").value == ""){
      alert("Nome é obrigatório")
      document.getElementById("cliente_nome").focus();
      return false
    }

    return true
  }

  async salvar(event) {
    if(event) event.preventDefault();

    if(!this.valido()) return;
  
    this.cliente.nome = document.getElementById("cliente_nome").value;
    this.cliente.telefone = document.getElementById("cliente_telefone").value;
    this.cliente.endereco = document.getElementById("cliente_endereco").value;
  
    const authenticity_token = document.querySelector('input[name="authenticity_token"]').value
    await ClienteServico.salvar(this.cliente, authenticity_token)
    this.loadClientes();
  }  
}
