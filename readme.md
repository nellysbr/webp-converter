# Conversor de imagens para webp

Faz a conversão de imagens para webp de forma recursiva em um diretório.

## Instalação

Após clonar o repositório, execute o comando abaixo para tornar o script executável:

```bash
chmod +x img_convert.sh


```

## Utilização

```bash

./img_convert.sh /caminho_da_pasta

```

## Utilização no windows

- Instalar as dependências do node:

```
npm install 
```

- Executar o comando abaixo no terminal trocando o caminho para a raíz da pasta da imagens

```
node convert_to_webp.js C:\caminho\para\suas\imagens
```

O script irá converter todas as imagens da pasta e subpastas para webp e salvará na mesma pasta.
