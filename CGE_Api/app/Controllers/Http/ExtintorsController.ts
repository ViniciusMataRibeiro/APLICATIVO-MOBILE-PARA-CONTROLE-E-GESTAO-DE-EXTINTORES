import CreateExtintorValidator from 'App/Validators/CreateExtintorValidator';
import EditExtintorValidator from 'App/Validators/EditExtintorValidator';
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Database from '@ioc:Adonis/Lucid/Database';
import Extintor from 'App/Models/Extintor';
import Tecnico from 'App/Models/Tecnico';
import Empresa from 'App/Models/Empresa';
import Setor from 'App/Models/Setor';
import { DateTime } from 'luxon';

export default class ExtintorsController {
    public async indexAllExtintores({ response, auth }: HttpContextContract) {
        try {
            const userAuth = await auth.use('api').authenticate();
            let setores;

            switch (userAuth.tipo) {
                case 'empresa':
                    const empresa = await Empresa.findByOrFail("user_id", userAuth.id);

                    setores = await Database.query().select('id').from('setors').where('empresa_id', empresa.id).where('ativo', true);
                    break;
                case 'tecnico':
                    const tecnico = await Tecnico.findByOrFail("user_id", userAuth.id);

                    setores = await Database.query().select('id').from('setors').where('empresa_id', tecnico.empresa_id).where('ativo', true);
                    break;
            }

            const setoresId = setores.map((setor) => setor.id);
            const extintores = await Database.query().select('*').from('extintors').whereIn('setor_id', setoresId).where('ativo', true);

            return response.status(200).json(extintores);


        } catch (error) {
            return response.badRequest({
                message: 'Erro ao listar Extintores',
            });
        }
    }

    public async indexExtintoresSetor({ response, params }: HttpContextContract) {
        try {
            const extintores = await Database.query().select('*').from('extintors').where('setor_id', params.id).where('ativo', true);

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
        try {
            const payload = await request.validate(CreateExtintorValidator);

            const setor = await Setor.findByOrFail("id", payload.setor_id);

            if (setor.ativo == false) {
                return response.badRequest({
                    message: 'Setor Inativo',
                });
            }

            await Database.insertQuery().table('extintors').insert({
                nome: payload.nome,
                tipoExtintor: payload.tipoExtintor,
                tamanho: payload.tamanho,
                validadeCasco: new Date(payload.validadeCasco.toISODate()),
                validadeExtintor: new Date(payload.validadeExtintor.toISODate()),
                proximaManutencao: payload.proximaManutencao ?? null,
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
            const extintores = await Extintor.findByOrFail("id", params.id);
            if(extintores == null){
                return response.badRequest({
                    message: 'Setor não encontrado',
                });
            }  

            let proximaManutencao;

            if (payload.proximaManutencao != null) {
                proximaManutencao = new Date(payload.proximaManutencao.toISODate());
            }else{
                proximaManutencao = null;
            }

            const sql = 'UPDATE extintors SET setor_id = ?, nome = ?, tipoExtintor = ?, tamanho = ?, validadeCasco = ?, validadeExtintor = ?, proximaManutencao = ? , ativo = ?, descricao = ? WHERE id = ?';
            await Database.rawQuery(sql, [payload.setor_id ,payload.nome, payload.tipoExtintor, payload.tamanho, new Date(payload.validadeCasco.toISO()), (new Date(payload.validadeExtintor.toISO())) ?? null , proximaManutencao , payload.ativo, payload.descricao, params.id]);

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
