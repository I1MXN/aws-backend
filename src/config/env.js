import 'dotenv/config';
const required=['DB_HOST','DB_USER','DB_PASSWORD','DB_NAME','JWT_SECRET'];for(const key of required){if(!process.env[key])throw Error(`Falta ${key} en .env`)}
if(process.env.JWT_SECRET.length<32)throw Error('JWT_SECRET debe contener al menos 32 caracteres');
export const config={port:Number(process.env.PORT||3000),jwtSecret:process.env.JWT_SECRET,jwtExpiry:process.env.JWT_EXPIRES_IN||'30m',production:process.env.NODE_ENV==='production',cookieSecure:process.env.COOKIE_SECURE==='true'};