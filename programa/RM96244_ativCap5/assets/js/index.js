let user = 'userTeste',
    senha = 'senhaTeste123';

function verSenha(num) {

    // Controle da imagem do botão da senha e visibilidade da mesma

    let idImg = '#imgBtnSenha' + num;

    let img = document.querySelector(idImg);
    let srcImagem = img.src.toString();

    let idSenha = '#txtSenha' + num;
    let senha = document.querySelector(idSenha);

    // Estrutura de if para trocar a img e deixar a senha visível ou não

    if (srcImagem.indexOf('ver.png') > -1) {
        img.src = './assets/imgs/olho.png';
        senha.type = 'text';
    }

    else if (srcImagem.indexOf('olho.png') > -1) {
        img.src = './assets/imgs/ver.png';
        senha.type = 'password';
    }
}

function gifIn(id) {
    document.querySelector(id).innerHTML = `<img src='./assets/imgs/carregando.gif'
                                            alt='gif de circulo carregando' id='gifCarregando'></img>`;
}

function gifOff(id, txt) {
    document.querySelector(id).textContent = txt;
}

function login() {

    gifIn('#btnLogin');

    setTimeout(verificaLogin, 1000);
}

function verificaLogin() {

    // Coletando usuario e senha informadas

    let userInfo = document.querySelector('#txtUser').value;
    let senhaInfo = document.querySelector('#txtSenha1').value;

    document.querySelector('#divUser').style.borderColor = '';
    document.querySelector('#divSenha').style.borderColor = '';

    if (userInfo === '' || senhaInfo === '') {
        alert('Existe campos não preenchidos.');

        if (userInfo === '') {
            document.querySelector('#divUser').style.borderColor = 'red';
        }

        if (senhaInfo === '') {
            document.querySelector('#divSenha').style.borderColor = 'red';
        }

    } else if (senhaInfo.length < 8) {
        document.querySelector('#divSenha').style.borderColor = 'red';

        alert('A senha informada, é menor que 8 caracteres.');

    } else if (userInfo === user && senhaInfo === senha) {

        window.location.href = 'home.html';


    } else {
        alert('Usuário ou senha incorretos! Tente novamente...');

        window.location.href = 'index.html';
    }

    gifOff('#btnLogin', 'Entrar');
}