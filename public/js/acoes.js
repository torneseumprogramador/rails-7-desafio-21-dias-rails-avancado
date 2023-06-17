const verificarCarregamento = () => {
  deletePorDataAnotation();
  putPorDataAnotation();
}

// Adiciona um evento ao carregamento da página
document.addEventListener("DOMContentLoaded", verificarCarregamento);

const deletePorDataAnotation = () => {
  const elementos = document.querySelectorAll('[data-excluir]');
  if(!elementos || elementos.length === 0) return;
  
  for(const elemento of elementos) {
    elemento.onclick = (event) =>{
      event.preventDefault();
      const elen = event.target
      const url = elen.getAttribute("data-excluir")
      excluir(url)
    }
  }
}

const putPorDataAnotation = () => {
  const form = document.querySelector('[data-put-com-redirect]');
  if (!form) return;
  form.onsubmit = (event) =>{
    event.preventDefault();
    alterar(event.target)
  }
}

const alterar = async (form) => {
  const url_redirect = form.getAttribute("data-put-com-redirect");
  const action = form.getAttribute("action");
  const formObj = transformarObjeto(serialize(form));

  try {
    const response = await fetch(`${action}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(formObj),
    });

    window.location.href = url_redirect;
  } catch (error) {
    console.error(error);
  }
};


const excluir = async (url, url_redirect) => {
  if(confirm("Confirma ?")){
    try {
      const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      const response = await fetch(`${url}?authenticity_token=${encodeURIComponent(csrfToken)}`, {
        method: 'DELETE'
      });

      if (response.ok) {
        if(url_redirect) window.location.href = url_redirect
        else window.location.reload()
      } else {
        mensagem = await response.json()
        throw new Error('Erro ao excluir o fornecedor ' + JSON.stringify(mensagem));
      }
    } catch (error) {
      console.error(error);
      alert(error.message)
      window.location.reload()
    }
  }
}

function transformarObjeto(formObj) {
  const novoObjeto = {};

  for (const key in formObj) {
    if (formObj.hasOwnProperty(key)) {
      const [objKey, nestedKey] = key.split('[');
      const nestedValue = formObj[key];

      if (nestedKey) {
        if (!novoObjeto[objKey]) {
          novoObjeto[objKey] = {};
        }
        novoObjeto[objKey][nestedKey.slice(0, -1)] = nestedValue;
      } else {
        novoObjeto[key] = nestedValue;
      }
    }
  }

  return novoObjeto;
}

const serialize = (form) => {
  if (!form || form.nodeName !== "FORM") {
    return;
  }

  var i, j, q = {};

  for (i = form.elements.length - 1; i >= 0; i = i - 1) {
    if (form.elements[i].name === "") {
      continue;
    }

    switch (form.elements[i].nodeName) {
      case "INPUT":
        switch (form.elements[i].type) {
          case "text":
          case "hidden":
          case "password":
          case "button":
          case "reset":
          case "submit":
            q[form.elements[i].name] = form.elements[i].value;
            break;
          case "checkbox":
          case "radio":
            if (form.elements[i].checked) {
              q[form.elements[i].name] = form.elements[i].value;
            }
            break;
          case "file":
            break;
        }
        break;
      case "TEXTAREA":
        q[form.elements[i].name] = form.elements[i].value;
        break;
      case "SELECT":
        switch (form.elements[i].type) {
          case "select-one":
            q[form.elements[i].name] = form.elements[i].value;
            break;
          case "select-multiple":
            q[form.elements[i].name] = [];
            for (j = form.elements[i].options.length - 1; j >= 0; j = j - 1) {
              if (form.elements[i].options[j].selected) {
                q[form.elements[i].name].push(form.elements[i].options[j].value);
              }
            }
            break;
        }
        break;
      case "BUTTON":
        switch (form.elements[i].type) {
          case "reset":
          case "submit":
          case "button":
            q[form.elements[i].name] = form.elements[i].value;
            break;
        }
        break;
    }
  }

  return q;
};


const carregarPedacoDeCodigoManualmenteVanilla = async () => {
  const response = await fetch('/carregando-pedaco-codigo');

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }

  document.getElementById("tasks").innerHTML = await response.text();
}


const carregarPedacoDeCodigoManualmenteJQuery = () => {
  $.ajax({
    url: '/carregando-pedaco-codigo',
    method: 'GET',
    success: function(data) {
      $('#tasks').html(data);
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log(`HTTP error! status: ${jqXHR.status}, message: ${errorThrown}`);
    }
  });
}