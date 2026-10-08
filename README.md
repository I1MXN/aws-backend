# AWS Zero Trust — Backend

Node.js + Express + MySQL Server local en EC2, JWT en cookie HttpOnly, autorización RBAC y PM2.

## Instalar en EC2 Ubuntu

```bash
sudo apt update
sudo apt install -y git curl mysql-server
sudo systemctl enable --now mysql
npm install
sudo mysql < database/schema.sql
sudo mysql
```

En MySQL:

```sql
CREATE USER 'aws_app'@'localhost' IDENTIFIED BY 'COLOCA_UNA_CONTRASENA_SEGURA';
GRANT SELECT, INSERT, UPDATE ON proyecto_aws.* TO 'aws_app'@'localhost';
```

Configura:

```bash
cp .env.example .env
nano .env
openssl rand -hex 32
chmod 600 .env
npm run seed:admin
npm start
curl http://localhost:3000/api/health
```

Para servir en segundo plano: `sudo npm install -g pm2 && pm2 start ecosystem.config.cjs && pm2 save && pm2 startup`.

Nunca subas `.env`; nunca expongas el puerto MySQL 3306 a Internet. Restringe el puerto 3000 a la IP privada del frontend. HTTPS y protección del enlace entre VPC siguen siendo necesarios para producción.
