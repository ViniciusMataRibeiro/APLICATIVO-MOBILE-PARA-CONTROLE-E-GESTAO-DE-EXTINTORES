import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext';
import Database from '@ioc:Adonis/Lucid/Database';
import Setor from 'App/Models/Setor';
import Tecnico from 'App/Models/Tecnico';
import CreateSetorValidator from 'App/Validators/CreateSetorValidator';
import EditSetorValidator from 'App/Validators/EditSetorValidator';
import { DateTime } from 'luxon';

export default class SetorsController {
    public async index({ response, auth }: HttpContextContract) {
        try {
            const userAuth = await auth.use('api').authenticate();
            const tecnico = await Tecnico.findByOrFail("user_id", userAuth.id);
            const setors = await Database.query().select('*').from('setors').where('empresa_id', tecnico.empresa_id).where('ativo', true);
            return response.ok(setors);
        } catch (error) {
            return response.badRequest({
                message: 'Erro ao listar Setores',
            });
        }
    }

    public async store({ request, response, auth }: HttpContextContract) {
        const payload = await request.validate(CreateSetorValidator);
        const userAuth = await auth.use('api').authenticate();

        try {
            const tecnico = await Tecnico.findByOrFail("user_id", userAuth.id);
            const setor = await Setor.create({
                nome: payload.nome,
                descricao: payload.descricao,
                ativo: payload.ativo,
                empresa_id: tecnico.empresa_id,
            });

            return response.ok({
                id: setor.id,
                nome: setor.nome,
            });
        } catch (error) {
            return response.badRequest({
                message: 'Erro ao Criar Setor',
            });
        }
    }

    public async update({ request, response }: HttpContextContract) {
        const payload = await request.validate(EditSetorValidator);

        try {
            const setor = await Setor.findByOrFail("id", payload.id);

            setor.merge({
                nome: payload.nome,
                descricao: payload.descricao == null ? setor.descricao : payload.descricao,
                ativo: payload.ativo,
            });

            await setor.save();

            return response.ok({
                id: setor.id,
                nome: setor.nome,
            });
        } catch (error) {
            return response.badRequest({
                message: 'Erro ao Editar Setor',
            });
        }
    }

    public async destroy({ response, params }: HttpContextContract) {
        try {
            const setor = await Setor.findByOrFail("id", params.id);

            if (setor) {
                setor.merge({
                    ativo: false,
                    deletedAt: DateTime.now(),
                });

                await setor.save();

                return response.ok({
                    message: 'Setor Deletado',
                });
            } else {
                return response.notFound({
                    message: 'Setor não encontrado',
                });
            }
        } catch {
            return response.badRequest({
                message: 'Erro ao Deletar Setor',
            });
        }
    }
}
