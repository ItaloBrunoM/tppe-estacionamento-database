FROM postgres:15

# Cria a pasta onde os scripts devem ser colocados no container
RUN mkdir -p /docker-entrypoint-initdb.d

# Copia todos os scripts SQL da pasta scripts/ do seu repositório
COPY scripts/*.sql /docker-entrypoint-initdb.d/
