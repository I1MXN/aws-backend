import 'dotenv/config';
import bcrypt from 'bcryptjs';
import {pool} from '../src/infrastructure/mysql.js';
const {INITIAL_ADMIN_NAME,INITIAL_ADMIN_USERNAME,INITIAL_ADMIN_EMAIL,INITIAL_ADMIN_PASSWORD}=process.env;
if (!INITIAL_ADMIN_PASSWORD || INITIAL_ADMIN_PASSWORD.length < 12) throw Error('Configura INITIAL_ADMIN_PASSWORD con 12 o más caracteres');
try {
 const [roles]=await pool.execute("SELECT id FROM roles WHERE nombre='admin'");
 if(!roles.length) throw Error('Primero ejecuta database/schema.sql');
 const hash=await bcrypt.hash(INITIAL_ADMIN_PASSWORD,12);
 await pool.execute('INSERT INTO usuarios(nombre,usuario,correo,password_hash,rol_id) VALUES (?,?,?,?,?) ON DUPLICATE KEY UPDATE nombre=nombre',[INITIAL_ADMIN_NAME,INITIAL_ADMIN_USERNAME,INITIAL_ADMIN_EMAIL,hash,roles[0].id]);
 console.log('Usuario administrador inicial preparado');
}finally{await pool.end();}