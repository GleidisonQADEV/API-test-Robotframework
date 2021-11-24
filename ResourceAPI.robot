***settings***
Documentation    Documentação da API https://fakerestapi.azurewebsites.net
Library          RequestsLibrary
Library          Collections

***variable***
${URL_API}       https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}       id=15
...              title=Book 15
...              pageCount=1500

&{BOOK_2323}     id=2323
...              title=teste
...              pageCount=200

&{BOOK_150}      id=1500
...              title=Book 1500
...              pageCount=3000

***Keywords***
###Setup e teardowns
Conectar a minha API
    Create Session                FakeAPI    ${URL_API}
    ${HEADERS}   Create Dictionary    content-type=application/json
    Set Suite Variable    ${HEADERS}
##Ações
Requisitar todos os livros
    ${RESPOSTA}                     GET On Session    FakeAPI   Books
    Log                             ${RESPOSTA.text}
    Set Test Variable               ${RESPOSTA}

Requisitar o livro "${ID_LIVROS}"
    ${RESPOSTA}                     GET On Session    FakeAPI   Books/${ID_LIVROS}
    Log                             ${RESPOSTA.text}
    Set Test Variable               ${RESPOSTA}

Cadastrar um novo livro
    ${RESPOSTA}                     POST On Session    FakeAPI   Books
    ...                                                data={"id": 2323,"title": "teste","description": "teste","pageCount": 200,"excerpt": "teste","publishDate": "2021-11-23T13:55:00.384Z"}
    ...                                                headers=${HEADERS}
    Log                             ${RESPOSTA.text}
    Set Test Variable               ${RESPOSTA}

Alterar o livro cadastrado "${ID_LIVROS}"
    ${RESPOSTA}                     PUT On Session    FakeAPI   Books/${ID_LIVROS}
    ...                                               data={"id": 1500,"title": "Book 1500","description": "Alteracao de livro","pageCount":3000,"excerpt": "Obrigado","publishDate": "2021-11-23T21:27:24.285Z"}
    ...                                               headers=${HEADERS}
    Log                             ${RESPOSTA.text}
    Set Test Variable               ${RESPOSTA}

Deletar o livro "${ID_LIVROS}"
    ${RESPOSTA}                     DELETE On Session    FakeAPI   Books/${ID_LIVROS}
    Log                             ${RESPOSTA.text}
    Set Test Variable               ${RESPOSTA}
###Conferência
Conferir o status code
    [Arguments]                     ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings      ${RESPOSTA.status_code}   ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]                     ${REASON_DESEJADO}
    Should Be Equal As Strings      ${RESPOSTA.reason}   ${REASON_DESEJADO}

Conferir se retorn uma lista com "${QTDE_LIVROS}" livros
    Length Should Be                ${RESPOSTA.json()}    ${QTDE_LIVROS}

Conferir se retorna todos os dados corretos do livro "${ID_LIVRO}"
    Conferir livro    ${ID_LIVRO}


Conferir se retorna os dados corretos do livro "${ID_LIVRO}" cadastrado
    Conferir livro    ${ID_LIVRO}

Conferir se retorna os dados alterados do livro "${ID_LIVRO}"
    Conferir livro    ${ID_LIVRO}

Conferir livro
    [Arguments]   ${ID_LIVRO}
    Dictionary Should Contain Item  ${RESPOSTA.json()}    id           ${BOOK_${ID_LIVRO}.id}
    Dictionary Should Contain Item  ${RESPOSTA.json()}    title        ${BOOK_${ID_LIVRO}.title}
    Dictionary Should Contain Item  ${RESPOSTA.json()}    pageCount    ${BOOK_${ID_LIVRO}.pageCount}
    Should Not Be Empty             ${RESPOSTA.json()["description"]}
    Should Not Be Empty             ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty             ${RESPOSTA.json()["publishDate"]}
    Log                             ${RESPOSTA.text}
    Set Test Variable               ${RESPOSTA}

Conferir se o livro "${ID_LIVRO}" foi deletado
    Should Be Empty                 ${RESPOSTA.content}
    Log                             ${RESPOSTA.text}
    Set Test Variable               ${RESPOSTA}
