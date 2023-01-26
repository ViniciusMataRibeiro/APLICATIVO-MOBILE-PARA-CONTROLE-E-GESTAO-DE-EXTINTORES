import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Database from '@ioc:Adonis/Lucid/Database';
import Tecnico from 'App/Models/Tecnico';
import Setor from 'App/Models/Setor';
import CreateExtintorValidator from 'App/Validators/CreateExtintorValidator';
import Extintor from 'App/Models/Extintor';
import EditExtintorValidator from 'App/Validators/EditExtintorValidator';
import { DateTime } from 'luxon';

export default class ExtintorsController {
    public async indexAllExtintores({ response, auth }: HttpContextContract) {
        try {
            const userAuth = await auth.use('api').authenticate();
            const tecnico = await Tecnico.findByOrFail("user_id", userAuth.id);

            const setores = await Database.query().select('id').from('setors').where('empresa_id', tecnico.empresa_id).where('ativo', true);

            const extintores = await Database.query().select('*').from('extintors').whereIn('setor_id', setores).where('ativo', true);

            return response.status(200).json(extintores);

        } catch (error) {
            return response.badRequest({
                message: 'Erro ao listar Extintores',
            });
        }
    }

    public async indexExtintoresSetor({ response, params }: HttpContextContract) {
        try {
            const setor_id = await Database.query().select('id').from('setors').where('id', params.id);

            const extintores = await Database.query().select('*').from('extintors').where('setor_id', setor_id).where('ativo', true);

            if (extintores.length > 0) {
                return response.status(200).json(extintores);
            } else {
                return response.status(204).json({
                    message: 'Não há extintores cadastrados para este setor',
                });
            }

        } catch (error) {
            return response.badRequest({
                message: 'Erro ao listar Extintores',
            });
        }
    }

    public async store({ request, response }: HttpContextContract) {
        const payload = await request.validate(CreateExtintorValidator);
        try {
            const setor = await Setor.findByOrFail("id", payload.setor_id);

            if(setor.ativo == false){
                return response.badRequest({
                    message: 'Setor Inativo',
                });
            }

            await Database.insertQuery().table('extintors').insert({
                nome: payload.nome,
                tipoExtintor: payload.tipoExtintor,
                tamanho: payload.tamanho,
                validadeCasco: new Date(payload.validadeCasco.toISODate()),
                proximaManutencao: new Date(payload.proximaManutencao.toISODate()),
                ativo: payload.ativo,
                setor_id: setor.id,
                descricao: payload.descricao,
            });

            return response.status(201).json({
                message: 'Extintor cadastrado com sucesso',
            });
        }
        catch (error) {
            return response.badRequest({
                message: 'Erro ao cadastrar Extintor',
            });
        }
    }

    public async update({ request, response, params }: HttpContextContract) {
        const payload = await request.validate(EditExtintorValidator);
        try {
            const extintor = await Extintor.findByOrFail("id", params.id);

            extintor.merge({
                nome: payload.nome,
                tipoExtintor: payload.tipoExtintor,
                tamanho: payload.tamanho,
                validadeCasco: new Date(payload.validadeCasco.toISODate()),
                proximaManutencao: new Date(payload.proximaManutencao.toISODate()),
                ativo: payload.ativo,
                descricao: payload.descricao,
            });

            await extintor.save();

            return response.status(200).json({
                message: 'Extintor Editado com sucesso',
            });
        }
        catch (error) {
            return response.badRequest({
                message: 'Erro ao Editar Extintor',
            });
        }
    }

    public async destroy({ response, params }: HttpContextContract) {
        try {
            const extintor = await Extintor.findByOrFail("id", params.id);

            extintor.merge({
                ativo: false,
                deletedAt: DateTime.now(),
            });

            await extintor.save();

            return response.status(200).json({
                message: 'Extintor deletado com sucesso',
            });
        } catch (error) {
            return response.badRequest({
                message: 'Erro ao deletar Extintor',
            });
        }
    }
}
