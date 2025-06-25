CREATE TYPE tipo_acesso AS ENUM ('evento', 'hora', 'diaria'); 
CREATE TYPE user_role AS ENUM ('admin', 'funcionario');

CREATE TABLE pessoa (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE
);

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    id_pessoa INT UNIQUE NOT NULL,
    login VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    role user_role NOT NULL DEFAULT 'funcionario',
    admin_id INT,
    FOREIGN KEY (id_pessoa) REFERENCES pessoa(id) ON DELETE CASCADE,
    FOREIGN KEY (admin_id) REFERENCES usuarios(id) ON DELETE SET NULL
);

CREATE TABLE estacionamento (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) UNIQUE NOT NULL,
    endereco TEXT,
    total_vagas INT NOT NULL,
    valor_primeira_hora NUMERIC(10, 2),
    valor_demais_horas NUMERIC(10, 2),
    valor_diaria NUMERIC(10, 2),
    admin_id INT, 
    FOREIGN KEY (admin_id) REFERENCES usuarios(id) ON DELETE SET NULL
);

CREATE TABLE veiculo (
    id SERIAL PRIMARY KEY,
    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(100),
    cor VARCHAR(50)
);

CREATE TABLE cliente_mensalista (
    id SERIAL PRIMARY KEY,
    id_pessoa INT NOT NULL,
    id_veiculo INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    ativo BOOLEAN DEFAULT TRUE,
    valor_mensalidade NUMERIC(10, 2) NOT NULL,
    FOREIGN KEY (id_pessoa) REFERENCES pessoa(id) ON DELETE CASCADE,
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id) ON DELETE CASCADE
);

CREATE TABLE evento (
    id SERIAL PRIMARY KEY,
    id_estacionamento INT NOT NULL,
    nome VARCHAR(255) UNIQUE NOT NULL,
    data_evento DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    valor_acesso_unico NUMERIC(10, 2),
    admin_id INT, 
    FOREIGN KEY (id_estacionamento) REFERENCES estacionamento(id) ON DELETE CASCADE,
    FOREIGN KEY (admin_id) REFERENCES usuarios(id) ON DELETE SET NULL
);

CREATE TABLE acesso (
    id SERIAL PRIMARY KEY,
    placa VARCHAR(10) NOT NULL,
    hora_entrada TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    hora_saida TIMESTAMP WITH TIME ZONE,
    valor_total NUMERIC(10, 2), 
    tipo_acesso tipo_acesso NOT NULL DEFAULT 'hora',
    id_estacionamento INT NOT NULL,
    id_evento INT,
    admin_id INT,
    FOREIGN KEY (id_estacionamento) REFERENCES estacionamento(id) ON DELETE CASCADE,
    FOREIGN KEY (id_evento) REFERENCES evento(id) ON DELETE SET NULL, 
    FOREIGN KEY (admin_id) REFERENCES usuarios(id) ON DELETE SET NULL 
);

CREATE TABLE faturamento (
    id SERIAL PRIMARY KEY,
    id_acesso INT NOT NULL,
    data_faturamento DATE NOT NULL DEFAULT CURRENT_DATE,
    valor NUMERIC(10, 2) NOT NULL,
    FOREIGN KEY (id_acesso) REFERENCES acesso(id) ON DELETE CASCADE
); 


ALTER TABLE usuarios
ADD CONSTRAINT fk_usuario_id_pessoa
FOREIGN KEY (id_pessoa) REFERENCES pessoa(id) ON DELETE CASCADE; 
