#!/bin/bash

# Verifica se um argumento foi fornecido
if [ $# -eq 0 ]; then
  echo "Uso: $0 <diretório>"
  exit 1
fi

# Diretório contendo as imagens
INPUT_DIR="$1"

# Verifica se o diretório existe
if [ ! -d "$INPUT_DIR" ]; then
  echo "Diretório não encontrado: $INPUT_DIR"
  exit 1
fi

# Encontra e converte todas as imagens PNG e JPEG para WebP
find "$INPUT_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | while read -r IMAGE; do
  # Obtém a extensão do arquivo
  EXT="${IMAGE##*.}"
  
  # Verifica se a extensão é válida
  if [[ "$EXT" =~ ^(png|jpg|jpeg)$ ]]; then
    # Obtém o nome do arquivo sem a extensão
    BASENAME=$(basename "$IMAGE")
    FILENAME="${BASENAME%.*}"

    # Diretório onde a imagem convertida será salva
    DIRNAME=$(dirname "$IMAGE")

    # Converte a imagem para WebP no mesmo diretório
    cwebp "$IMAGE" -o "$DIRNAME/$FILENAME.webp"
    
    # Verifica se a conversão foi bem-sucedida
    if [ $? -eq 0 ]; then
      # Exclui a imagem original
      rm "$IMAGE"
      # Exibe uma mensagem de sucesso
      echo "Convertido e deletado: $IMAGE -> $DIRNAME/$FILENAME.webp"
    else
      # Exibe uma mensagem de erro se a conversão falhar
      echo "Erro ao converter: $IMAGE"
    fi
  fi
done

echo "Conversão concluída."
