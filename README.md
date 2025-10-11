# Velocímetro & Hodômetro HUD

Um aplicativo Flutter para monitoramento de velocidade e distância em tempo real, desenvolvido como projeto acadêmico. O app utiliza os dados do GPS do dispositivo para fornecer medições precisas e conta com um modo HUD (Head-Up Display) para visualização no para-brisa de um veículo.

<img width="399" height="693" alt="image" src="https://github.com/user-attachments/assets/3940e184-6b37-4a02-8d3e-1c35c9479940" />


## ✨ Funcionalidades

Velocímetro em Tempo Real: Exibe a velocidade atual do dispositivo em km/h.

Hodômetro (Odômetro): Calcula e exibe a distância total percorrida desde o início ou o último reset.

Modo HUD (Head-Up Display): Espelha a interface para que possa ser refletida de forma legível no para-brisa de um carro.

Botão de Reset: Zera a contagem da distância percorrida.

Cálculo via GPS: Utiliza o pacote geolocator para obter dados precisos de geolocalização e velocidade.

Tela Sempre Ativa: Usa o pacote wakelock_plus para impedir que a tela se apague durante o uso.

Arquitetura MVVM: O código é estruturado para separar a lógica de negócios da interface, facilitando a manutenção e testes.

## 🛠️ Tecnologias Utilizadas

Flutter: Framework para desenvolvimento de aplicações multiplataforma.

Dart: Linguagem de programação utilizada pelo Flutter.

Provider: Para gerenciamento de estado seguindo a arquitetura MVVM.

Geolocator: Para acesso aos dados de GPS do dispositivo.

Wakelock_plus: Para manter a tela do dispositivo ativa.

Intl: Para formatação de números.

## 🚀 Como Executar o Projeto

Siga os passos abaixo para executar o projeto em seu ambiente local.

Pré-requisitos:

- Ter o SDK do Flutter instalado.

- Um emulador Android/iOS configurado ou um dispositivo físico.

## Passos:

- Clone o repositório:

- git clone [URL_DO_SEU_REPOSITÓRIO_AQUI]

- Navegue até o diretório do projeto:

- cd nome-do-repositorio

- Instale as dependências:

- flutter pub get

- Execute o aplicativo:

- flutter run

# 👨‍💻 Autores

Este projeto foi desenvolvido por:

- Rodrigo Noelli Duarte - Shinzola

## 🤝 Como Contribuir

Contribuições são o que tornam a comunidade de código aberto um lugar incrível para aprender, inspirar e criar. Qualquer contribuição que você fizer será muito apreciada.

Se você tiver uma sugestão para melhorar este projeto, por favor, crie um fork do repositório e crie um pull request. Você também pode simplesmente abrir uma issue com a tag "melhoria".

Faça um Fork do projeto.

Crie uma nova Branch (git checkout -b feature/NovaFeature).

Faça o Commit de suas alterações (git commit -m 'Adiciona uma nova Feature').

Faça o Push para a Branch (git push origin feature/NovaFeature).

Abra um Pull Request.

# 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo LICENSE.md para mais detalhes.
