INSERT INTO pessoa (nome, cpf, email)
VALUES ('Administrador do Sistema', '000.000.000-00', 'admin@estacionamento.com')
ON CONFLICT (cpf) DO NOTHING;

INSERT INTO usuarios (id_pessoa, login, senha, role)
VALUES (
    (SELECT id FROM pessoa WHERE cpf = '000.000.000-00'),
    'admin',
    '$argon2id$v=19$m=65536,t=3,p=4$kDuaASUDwi1X53S/6AN4WA$87EwqBFv3Ual+B8gjBH0xIlGkXflsT+hnBziryQ82r8', -- TROCAR PELA SENHA REAL EM HASH
    'admin'
)
ON CONFLICT (login) DO NOTHING;

INSERT INTO pessoa (nome, cpf, email)
VALUES ('Funcionário Padrão', '111.111.111-11', 'funcionario@estacionamento.com')
ON CONFLICT (cpf) DO NOTHING;
INSERT INTO usuarios (id_pessoa, login, senha, role)
VALUES (
    (SELECT id FROM pessoa WHERE cpf = '111.111.111-11'),
    'funcionario',
    '$argon2id$v=19$m=65536,t=3,p=4$Af2OI0iyCxIVIZDuXAHCbw$1CQjNyxWRCIT+YDURNn4m4TN+5RnmvNf+SWNzYnF83Y', -- TROCAR PELA SENHA REAL EM HASH
    'funcionario'
)
ON CONFLICT (login) DO NOTHING;