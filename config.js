var path = require('path'),
    config;

function CheckEnvVar(varname, defaultvalue)
{
    var result = process.env[varname];
    if(result!=undefined)
        return result;
    else
        return defaultvalue;
}

var devDomain = CheckEnvVar('DEV_DOMAIN', 'http://localhost:2368');
var prodDomain = CheckEnvVar('PROD_DOMAIN', 'http://fastqiu.com');

config = {
    production: {
        url: 'http://fastqiu.com',
        database: {
            client: 'mysql',
            connection: {
                host     : 'mysql',
                user     : 'root',
                password : '123456',
                database : 'ghost',
                charset  : 'utf8'
            }
        },
        server: {
            host: '0.0.0.0',
            port: '2369'
        },
        logging: true,

        mail: {
             transport: 'SMTP',
             options: {
                  service: 'Gmail',
                  auth: {
                      user: CheckEnvVar('MAIL_USER', ''), 
                      pass: CheckEnvVar('MAIL_PASS', '')
                }
             }
        }
   }
};

module.exports = config;
