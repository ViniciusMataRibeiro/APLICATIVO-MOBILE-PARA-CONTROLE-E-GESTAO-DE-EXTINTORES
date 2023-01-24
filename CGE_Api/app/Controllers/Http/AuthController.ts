import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Admin from 'App/Models/Admin';
import Empresa from 'App/Models/Empresa';
import Tecnico from 'App/Models/Tecnico';
import User from 'App/Models/User'

export default class AuthController {
    public async login({ request, auth, response }: HttpContextContract) {
        const email = request.input('email');
        const password = request.input('password');

        try {
            const user = await User.findByOrFail('email', email);

            let expira;
            switch (user.tipo) {
                case 'tecnicos':
                    expira = '30days';
                    break;
                case 'empresas':
                    expira = '7days';
                    break;
                case 'admins':
                    expira = '1day';
                    break;
                default:
                    expira = '30days';
                    break;
            }

            const token = await auth.use("api").attempt(email, password, {
                expiresIn: expira,
                name: user.serialize().email,
            });

            response.ok({ 
                token: token.token,
                expires_at: token.expiresAt,
            } );
        } catch {
            return response.badRequest({ message: 'Invalid email/password' });
        }

    }

    public async logout({ auth, response }: HttpContextContract) {
        try {
            await auth.use("api").revoke();
        } catch {
            return response.unauthorized('no authorization');
        }

        return response.ok({
            revoked: true,
        });

    }

    public async me({ auth, response }: HttpContextContract) {
        const userAuth = await auth.use("api").authenticate();

        let data;

        switch (userAuth.tipo) {
            case 'empresa':
                const empresas = await Empresa.findByOrFail('userId', userAuth.id);
                data = {
                    id_empresa: empresas.id,
                    nome: empresas.nome,
                    telefone: empresas.telefone,
                    email: userAuth.email,
                };
                break;
            case 'tecnicos':
                const tecnicos = await Tecnico.findByOrFail('userId', userAuth.id);
                data = {
                    id_tecnico: tecnicos.id,
                    nome: tecnicos.nome,
                    bloqueado: tecnicos.bloqueado,
                    online: tecnicos.online,
                    email: userAuth.email,
                };
                break;
            case 'admins':
                const admins = await Admin.findByOrFail('userId', userAuth.id);
                data = {
                    id_admin: admins.id,
                    nome: admins.nome,
                    email: userAuth.email,
                };
                break;
            default:
                return response.unauthorized('no authorization');
        }

        return response.ok(data);
    }
}
