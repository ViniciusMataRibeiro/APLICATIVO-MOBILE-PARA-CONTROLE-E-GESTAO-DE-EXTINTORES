import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Empresa from 'App/Models/Empresa';
import Tecnico from 'App/Models/Tecnico';
import User from 'App/Models/User';
import CreateTecnicoValidator from 'App/Validators/CreateTecnicoValidator';

export default class TecnicosController {
    public async store({ request, response, params }: HttpContextContract) {
        const payload = await request.validate(CreateTecnicoValidator);

        const user = await User.create({
            email: payload.email,
            password: payload.password,
            tipo: 'tecnico',
        });

        const IdEmpresa = params.id;

        if (!IdEmpresa) {
            return response.badRequest({
                message: 'Empresa não encontrada',
            });
        }

        try {
            const empresa = await Empresa.query().where('id', IdEmpresa).firstOrFail();
            const tecnico = await Tecnico.create({
                nome: payload.nome,
                userId: user.id,
                empresa_id: empresa.id,
            });

            return response.ok({
                id: tecnico.id,
                nome: tecnico.nome,
                email: user.email,
                empresa: empresa.nome,
            });

        } catch{
            return response.badRequest({
                message: 'Erro ao Criar Técnico',
            });
        }
    }
}
