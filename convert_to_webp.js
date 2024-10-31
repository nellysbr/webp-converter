const fs = require('fs');
const path = require('path');
const sharp = require('sharp');

// Verifica se um argumento foi fornecido
if (process.argv.length < 3) {
  console.log("Uso: node script.js <diretório>");
  process.exit(1);
}

// Diretório contendo as imagens
const inputDir = process.argv[2];

// Verifica se o diretório existe
if (!fs.existsSync(inputDir)) {
  console.log(`Diretório não encontrado: ${inputDir}`);
  process.exit(1);
}

// Função para processar um arquivo
async function processFile(filePath) {
  const ext = path.extname(filePath).toLowerCase();
  if (['.png', '.jpg', '.jpeg'].includes(ext)) {
    const dirname = path.dirname(filePath);
    const filename = path.basename(filePath, ext);
    const outputPath = path.join(dirname, `${filename}.webp`);

    try {
      await sharp(filePath)
        .webp()
        .toFile(outputPath);

      // Exclui a imagem original
      fs.unlinkSync(filePath);
      console.log(`Convertido e deletado: ${filePath} -> ${outputPath}`);
    } catch (error) {
      console.error(`Erro ao converter: ${filePath}`, error);
    }
  }
}

// Função para percorrer diretórios recursivamente
async function processDirectory(dir) {
  const files = fs.readdirSync(dir);

  for (const file of files) {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);

    if (stat.isDirectory()) {
      await processDirectory(filePath);
    } else {
      await processFile(filePath);
    }
  }
}

// Inicia o processamento
(async () => {
  try {
    await processDirectory(inputDir);
    console.log("Conversão concluída.");
  } catch (error) {
    console.error("Erro durante a conversão:", error);
  }
})();