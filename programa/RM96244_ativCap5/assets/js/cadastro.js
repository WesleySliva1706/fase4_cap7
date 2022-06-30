let provedorEmail = ['@gmail.com', '@hotmail.com', '@outlook.com', '@live.com', '@yahoo.com'];

function cadastrar() {

    gifIn('#btnCadastro');

    setTimeout(verificar_dados, 1000);
}

function verificar_dados() {

    // Coletando dados

    let dados = [
        [
            userInfo = document.querySelector('#txtUser'),
            dtNas = document.querySelector('#txtDtNascimento'),
            email = document.querySelector('#txtEmail'),
            confEmail = document.querySelector('#txtConfirmarEmail'),
            senhaInfo = document.querySelector('#txtSenha1'),
            confSenha = document.querySelector('#txtSenha2')
        ],
        ['divUser', 'divDtNascimento', 'divEmail', 'divConfirmarEmail', 'divSenha', 'divConfirmarSenha']
    ];

    let control = false;

    for (let i = 0; i < dados[0].length; i++) {

        document.getElementById(dados[1][i]).style.borderColor = '';

        if (dados[0][i].value === '') {
            document.getElementById(dados[1][i]).style.borderColor = 'red';

            if (control === false) {
                alert('Existe campos não preenchidos.');
                control = true;
            }
        }
    }

    if (userInfo.value !== '') {
        if (userInfo.value === user) {
            document.querySelector('#divUser').style.borderColor = 'red';
            alert('O nome de usuário não está disponível.');
            control = true;
        }
    }

    if (email.value !== '' && confEmail.value !== '') {
        for (provedor in provedorEmail) {
            if (email.value.indexOf(provedor) !== -1) {
                if (email.value !== confEmail.value) {
                    document.querySelector('#divEmail').style.borderColor = 'red';
                    document.querySelector('#divConfirmarEmail').style.borderColor = 'red';
                    alert('Os emails não correspondem.');
                    control = true;
                }
                break;
            }

            if (provedor === provedor[provedorEmail.length - 1]) {
                document.querySelector('#divEmail').style.borderColor = 'red';
                document.querySelector('#divConfirmarEmail').style.borderColor = 'red';
                alert('O provedor de email é inválido ou está escrito incorretamente.');
                control = true;
            }
        }
    }

    if (senhaInfo.value !== '' && confSenha.value !== '') {
        if (senhaInfo.value.length >= 8) {
            if (senhaInfo.value !== confSenha.value) {
                document.querySelector('#divSenha').style.borderColor = 'red';
                document.querySelector('#divConfirmarSenha').style.borderColor = 'red';
                alert('As senhas não correspondem.');
                control = true;
            }
        } else {
            document.querySelector('#divSenha').style.borderColor = 'red';
            document.querySelector('#divConfirmarSenha').style.borderColor = 'red';
            alert('As senhas possuem menos de 8 caracteres.');
            control = true;
        }
    }

    if (control === false) {
        user = dados[0][0].value;
        senha = dados[0][1].value;

        alert('Cadastro realizado com sucesso!');

        window.location.href = 'home.html';
    }

    gifOff('#btnCadastro', 'Criar Conta')

}