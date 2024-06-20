#!/bin/bash

# Diretório contendo as imagens
INPUT_DIR="/home/nellys/Documents/sites/action-citroen-new/public/assets/images"

# Verifica se o diretório existe
if [ ! -d "$INPUT_DIR" ]; then
  echo "Diretório não encontrado: $INPUT_DIR"
  exit 1
fi

# Converte todas as imagens PNG e JPEG para WebP
for IMAGE in "$INPUT_DIR"/*.{png,jpg,jpeg}; do
  # Verifica se existem arquivos com essas extensões
  if [ ! -e "$IMAGE" ]; then
    echo "Nenhum arquivo PNG ou JPEG encontrado em $INPUT_DIR"
    exit 1
  fi

  # Obtém o nome do arquivo sem a extensão
  BASENAME=$(basename "$IMAGE")
  FILENAME="${BASENAME%.*}"

  # Converte a imagem para WebP no mesmo diretório
  cwebp "$IMAGE" -o "$INPUT_DIR/$FILENAME.webp"
  
  # Verifica se a conversão foi bem-sucedida
  if [ $? -eq 0 ]; then
    # Exclui a imagem original
    rm "$IMAGE"
    # Exibe uma mensagem de sucesso
    echo "Convertido e deletado: $IMAGE -> $INPUT_DIR/$FILENAME.webp"
  else
    # Exibe uma mensagem de erro se a conversão falhar
    echo "Erro ao converter: $IMAGE"
  fi
done

echo "Conversão concluída."
