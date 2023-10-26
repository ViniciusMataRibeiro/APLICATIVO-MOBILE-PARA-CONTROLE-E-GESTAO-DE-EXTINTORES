import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext';
import Database from '@ioc:Adonis/Lucid/Database';
import Empresa from 'App/Models/Empresa';
import Tecnico from 'App/Models/Tecnico';
import User from 'App/Models/User';
import CreateTecnicoValidator from 'App/Validators/CreateTecnicoValidator';
import EditTecnicoValidator from 'App/Validators/EditTecnicoValidator';

export default class TecnicosController {

    public async index({ response, auth }: HttpContextContract) {
        try {
            const userAuth = await auth.use('api').authenticate();

            const empresa = await Empresa.findByOrFail("user_id", userAuth.id);
            const tecnicos = await Tecnico.query().where('empresa_id', empresa.id);

            const listTecnico = new Array();

            for (const element of tecnicos) {
                const usertecnico = await User.findByOrFail("id", element.userId);
                

                let obj = {
                    id: element.id,
                    nome: element.nome,
                    email: usertecnico.email,
                    status: element.bloqueado == false ? 'Ativo' : 'Inativo',
                    qtdVistorias: '2',
                }

                listTecnico.push(obj);
            }

            listTecnico.sort(function(a,b) {
                return a.status < b.status ? -1 : a.status > b.status ? 1 : 0;
            });

            return response.ok(listTecnico);

        } catch (error) {
            return response.badRequest({
                message: 'Erro ao listar Técnicos',
            });
        }
    }

    public async store({ request, response, auth }: HttpContextContract) {
        const payload = await request.validate(CreateTecnicoValidator);
        try {
            const userAuth = await auth.use('api').authenticate();

            const empresa = await Empresa.findByOrFail("user_id", userAuth.id);

            const user = await User.create({
                email: payload.email,
                password: payload.password,
                tipo: 'tecnico',
            });

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

        } catch {
            return response.badRequest({
                message: 'Erro ao Criar Técnico',
            });
        }
    }

    public async update({ request, response, params }: HttpContextContract) {
        const payload = await request.validate(EditTecnicoValidator);

        const trx = await Database.transaction();

        try {
            const tecnico = await Tecnico.findByOrFail("id", parseInt(params.id));
            const user = await User.findByOrFail("id", tecnico.userId);


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

            tecnico.merge({
                nome: payload.nome,
                bloqueado: payload.bloqueado,
            });

            await tecnico.save();

            await trx.commit();

            return response.ok({
                id: tecnico.id,
                nome: tecnico.nome,
                email: user.email,
            });

        } catch (error) {
            await trx.rollback();
            return response.badRequest({
                message: 'Erro ao Editar Técnico',
            });
        }
    }

    public async destroy({ response, params }: HttpContextContract) {
        try {
            const tecnico = await Tecnico.findByOrFail("id", params.id);

            if (tecnico) {
                tecnico.merge({
                    bloqueado: !tecnico.bloqueado,
                });

                await tecnico.save();

                return response.ok({
                    message: 'Técnico Deletado',
                });
            } else {
                return response.notFound({
                    message: 'Técnico não encontrado',
                });
            }
        } catch {
            return response.badRequest({
                message: 'Erro ao Deletar Técnico',
            });
        }

        // public async destroy({ response, params }: HttpContextContract) {
        //     try {
        //         const resp = await Tecnico.query().where('id', params.id).delete();

        //         if (resp.includes(1)) {
        //             return response.ok({
        //                 message: 'Técnico Deletado',
        //             });
        //         } else {
        //             return response.notFound({
        //                 message: 'Técnico não encontrado',
        //                 });
        //         }

        //     } catch {
        //         return response.status(400).send({
        //             message: 'Erro ao Deletar Técnico',
        //         });
        //     }
        // }
    }
}