INSERT INTO pessoa (nome, cpf, email)
VALUES ('Administrador do Sistema', '000.000.000-00', 'admin@estacionamento.com')
ON CONFLICT (cpf) DO NOTHING;

INSERT INTO usuarios (id_pessoa, login, senha, role, admin_id)
VALUES (
    (SELECT id FROM pessoa WHERE cpf = '000.000.000-00'),
    'admin',
    '$argon2id$v=19$m=65536,t=3,p=4$9n4vJQQgxFjLmVMK4VwrJQ$TW7+9i9ilThFKUi9ywPZMqVFefdXUquXVm+yfB06M68', -- Hash para 'admin'
    'admin',
    NULL
)
ON CONFLICT (login) DO NOTHING;

INSERT INTO pessoa (nome, cpf, email)
VALUES ('Funcionário Padrão', '111.111.111-11', 'funcionario@estacionamento.com')
ON CONFLICT (cpf) DO NOTHING;
INSERT INTO usuarios (id_pessoa, login, senha, role, admin_id)
VALUES (
    (SELECT id FROM pessoa WHERE cpf = '111.111.111-11'),
    'funcionario',
    '$argon2id$v=19$m=65536,t=3,p=4$E0LIeW+NEUIo5ZyTEqL0vg$ndDEkfHXqqUHgnsQUgh6IoJyXFe7fUS5h33vnt+udzk', -- Hash para 'funcionario'
    'funcionario',
    (SELECT id FROM usuarios WHERE login = 'admin')
)
ON CONFLICT (login) DO NOTHING;

INSERT INTO pessoa (nome, cpf, email)
VALUES ('Administrador Teste 2', '000.000.000-01', 'admin2@estacionamento.com')
ON CONFLICT (cpf) DO NOTHING;

INSERT INTO usuarios (id_pessoa, login, senha, role, admin_id)
VALUES (
    (SELECT id FROM pessoa WHERE cpf = '000.000.000-01'),
    'admin2',
    '$argon2id$v=19$m=65536,t=3,p=4$TgnBWKs1xhiD8J4TQsgZIw$hQkkJWI0BdGzfsry8XzUEx1edol8Wsj7HgOLxEgmG7E', -- Hash para 'admin2'
    'admin',
    NULL
)
ON CONFLICT (login) DO NOTHING;

-- NOVO INSERT PARA ESTACIONAMENTO
INSERT INTO estacionamento (nome, endereco, total_vagas, valor_primeira_hora, valor_demais_horas, valor_diaria, admin_id)
VALUES (
    'Estacionamento Principal',
    'Rua Exemplo, 123',
    100,
    15.00,
    7.50,
    60.00,
    (SELECT id FROM usuarios WHERE login = 'admin')
)
ON CONFLICT (nome) DO NOTHING;

-- NOVO INSERT PARA EVENTO
-- O evento é criado para 01 de Julho de 2025, das 14:00 às 15:00 (assumindo horário local BRT)
INSERT INTO evento (id_estacionamento, nome, data_hora_inicio, data_hora_fim, valor_acesso_unico, admin_id)
VALUES (
    (SELECT id FROM estacionamento WHERE nome = 'Estacionamento Principal'),
    'Evento de Inauguração',
    '2025-07-01 14:00:00', 
    '2025-07-01 15:00:00',
    25.00,
    (SELECT id FROM usuarios WHERE login = 'admin')
)
ON CONFLICT (nome) DO NOTHING;