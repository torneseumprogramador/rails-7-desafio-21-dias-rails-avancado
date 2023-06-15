class ClienteServico {
    static async todos(paginaCorrente = 1){
        const clientesData = await (await fetch(`http://localhost:3000/clientes.json?pagina=${paginaCorrente}`)).json();
        const clientes = clientesData.map(clienteData => new Cliente(clienteData));
        return clientes;
    }

    static async delete(id, authenticity_token) {
        const payload = {
            authenticity_token: authenticity_token
        };

        const requestOptions = {
            method: 'DELETE',
            body: JSON.stringify(payload),
            headers: { 'Content-Type': 'application/json' }
        };
        const url = `http://localhost:3000/clientes/${id}.json`;
        await fetch(url, requestOptions);
    }

    static async salvar(cliente, authenticity_token) {
        const payload = {
            cliente: cliente,
            authenticity_token: authenticity_token
        };
    
        const requestOptions = {
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        };
    
        let url = 'http://localhost:3000/clientes.json';
        
        if(cliente.id < 1)
            requestOptions.method = 'POST'
        else{
            requestOptions.method = 'PUT'
            url = `http://localhost:3000/clientes/${cliente.id}.json`;
        }
    
        await (await fetch(url, requestOptions)).json();
    }
}