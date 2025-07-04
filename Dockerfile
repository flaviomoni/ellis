# Etapa 1: Imagem base
# Usamos uma imagem 'slim' que é menor que a padrão, mas contém o necessário.
# É recomendado usar uma versão estável do Python em vez de uma versão beta.
FROM python:3.13.4-alpine3.22

# Etapa 2: Definir o diretório de trabalho dentro do contêiner
# Isso evita que os arquivos da aplicação fiquem espalhados no diretório raiz.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências e instalá-las
# Copiamos o requirements.txt primeiro para aproveitar o cache do Docker.
# As dependências só serão reinstaladas se o arquivo requirements.txt mudar.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 4: Copiar o código da aplicação
COPY . .

# Etapa 5: Expor a porta em que a aplicação será executada
EXPOSE 8000

# Etapa 6: Comando para iniciar a aplicação
# Usamos 0.0.0.0 para que o servidor seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
