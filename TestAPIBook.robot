***settings***
Documentation    Documentação da API https://fakerestapi.azurewebsites.net
Resource         ResourceAPI.robot
Suite Setup      Conectar a minha API

***Test Case***
Buscar a listagem de todos os livros (GET em todos os livros)
    Requisitar todos os livros
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se retorn uma lista com "200" livros

Buscar um livro específico (GET em um livro específico)
    Requisitar o livro "15"
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se retorna todos os dados corretos do livro "15"

Cadastrar um novo livro (POST)
    Cadastrar um novo livro
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se retorna os dados corretos do livro "2323" cadastrado

Alterar um livro (PUT)
    Alterar o livro cadastrado "150"
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se retorna os dados alterados do livro "150"

Deletar um livro (DELETE)
    Deletar o livro "200"
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se o livro "200" foi deletado
###
