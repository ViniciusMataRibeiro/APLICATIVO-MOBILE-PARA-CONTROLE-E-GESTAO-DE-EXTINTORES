import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext';
import Database from '@ioc:Adonis/Lucid/Database';
import Empresa from 'App/Models/Empresa';
import Setor from 'App/Models/Setor';
import Tecnico from 'App/Models/Tecnico';
import CreateSetorValidator from 'App/Validators/CreateSetorValidator';
import EditSetorValidator from 'App/Validators/EditSetorValidator';
import { DateTime } from 'luxon';

export default class SetorsController {

    public async ResumoSetor({ response, auth }: HttpContextContract) {
        try {
            const userAuth = await auth.use('api').authenticate();
            let TipoUsuario;
            let Setores;

            if (userAuth.tipo == 'tecnico') {
            TipoUsuario = await Tecnico.findByOrFail("user_id", 4); //userAuth.id);
            Setores = await Database.query().select('*').from('setors').where('empresa_id', TipoUsuario.empresa_id).where('ativo', true);
            }
            else {
                TipoUsuario = await Empresa.findByOrFail("user_id", userAuth.id);
                Setores = await Database.query().select('*').from('setors').where('empresa_id', TipoUsuario.id).where('ativo', true);
            }

            let ResumoSetor = new Array();

            for (const element of Setores) {
                let obj;

                const result = await Database.rawQuery('SELECT * FROM extintors WHERE setor_id = ? AND ativo = ?', [element.id, true]);
                if (result[0].length == 0) {
                    continue;
                }

                obj = {
                    setor: element.nome,
                    extintores: result[0],
                    totalVencidos: 0,
                    totalVencer: 0,
                    totalFuncional: 0,
                    totalExtintores: result[0].length,
                }

                let cont = 0;

                for (const element of obj.extintores) {
                    cont++;
                    var dateAtual = new Date();
                    var dataLimite = new Date(dateAtual.getFullYear(), dateAtual.getMonth(), dateAtual.getDate() + 15);

                    if (dateAtual > element.proximaManutencao) {
                        obj.totalVencidos++;
                    }
                    else if (dateAtual < element.proximaManutencao && dataLimite > element.proximaManutencao) {
                        obj.totalVencer++;
                    }
                    else {
                        obj.totalFuncional++;
                    }
                }

                //porcentagem
                if (obj.totalVencidos > 0) {
                    obj.totalVencidos = Number(
                        ((obj.totalVencidos / cont) * 100).toFixed(2)
                    );
                }
                if (obj.totalVencer > 0) {
                    obj.totalVencer = Number(
                        ((obj.totalVencer / cont) * 100).toFixed(2)
                    ); 
                }
                if(obj.totalFuncional > 0){
                    obj.totalFuncional = Number(
                        ((obj.totalFuncional / cont) * 100).toFixed(2)
                    );
                }
                ResumoSetor.push(obj);
            }

            return response.ok(ResumoSetor);

        } catch (error) {
            return response.badRequest({
                message: error.message,
            });
        }

    }

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
