import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Database from '@ioc:Adonis/Lucid/Database';
import Empresa from 'App/Models/Empresa';
import User from 'App/Models/User';
import CreateEmpresaValidator from 'App/Validators/CreateEmpresaValidator'
import EditEmpresaValidator from 'App/Validators/EditEmpresaValidator';

export default class EmpresasController {

    public async store({ request, response }: HttpContextContract) {
        const payload = await request.validate(CreateEmpresaValidator);

        const user = await User.create({
            email: payload.email,
            password: payload.password,
            tipo: 'empresa',
        });

        const cliente = await Empresa.create({
            nome: payload.nome,
            telefone: payload.telefone,
            userId: user.id,
        });

        return response.ok({
            id: cliente.id,
            nome: cliente.nome,
            email: user.email,
            telefone: cliente.telefone,
        });
    }

    public async update({ request, response, auth }: HttpContextContract) {
        const payload = await request.validate(EditEmpresaValidator);
        const userAuth = await auth.use('api').authenticate();

        //transação
        const trx = await Database.transaction();

        try {
            const user = await User.findByOrFail("id", userAuth.id);
            const empresa = await Empresa.findByOrFail("user_id", userAuth.id);

            if (payload.password) {
                user.merge({
                    email: payload.email,
                    password: payload.password,
                });
            } else {
                user.merge({
                    email: payload.email,
                });
            }

            await user.save();

            empresa.merge({
                nome: payload.nome,
                telefone: payload.telefone,
            });

            await empresa.save();

            //finalizar transação
            await trx.commit();
        } catch (error) {
            await trx.rollback();
            return response.badRequest(error);
        }
    }

}
