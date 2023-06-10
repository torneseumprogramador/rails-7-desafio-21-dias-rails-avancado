import { Controller } from "@hotwired/stimulus";
import renderClientesTable from "../templates/clientes/index";
import renderClientesForm from "../templates/clientes/new";

export default class extends Controller {
  connect() {
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
    
    this.cliente = {id: 0, nome: "", telefone: "", endereco: ""}
    const clientes = await (await fetch(`http://localhost:3000/clientes.json?pagina=${this.paginaCorrente}`)).json();
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
      const payload = {
        authenticity_token: csrfToken
      };

      const requestOptions = {
        method: 'DELETE',
        body: JSON.stringify(payload),
        headers: { 'Content-Type': 'application/json' }
      };
      const url = `http://localhost:3000/clientes/${cliente.id}.json`;
      await fetch(url, requestOptions);

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
    const payload = {
      cliente: this.cliente,
      authenticity_token: authenticity_token
    };

    const requestOptions = {
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    };

    let url = 'http://localhost:3000/clientes.json';
    
    if(this.cliente.id < 1)
      requestOptions.method = 'POST'
    else{
      requestOptions.method = 'PUT'
      url = `http://localhost:3000/clientes/${this.cliente.id}.json`;
    }
  
    await (await fetch(url, requestOptions)).json();

    this.loadClientes();
  }  
}
