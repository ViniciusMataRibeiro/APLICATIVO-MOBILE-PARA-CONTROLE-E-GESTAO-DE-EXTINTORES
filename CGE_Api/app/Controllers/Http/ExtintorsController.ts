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

                    setores = await Database.query().select('*').from('setors').where('empresa_id', empresa.id).where('ativo', true);
                    break;
                case 'tecnico':
                    const tecnico = await Tecnico.findByOrFail("user_id", userAuth.id);

                    setores = await Database.query().select('*').from('setors').where('empresa_id', tecnico.empresa_id).where('ativo', true);
                    break;
            }

            const setoresId = setores.map((setor) => setor.id);
            const extintores = await Database.query().select('*').from('extintors').whereIn('setor_id', setoresId).orderBy('setor_id', 'asc').orderBy('proximaManutencao', 'asc');
            
            for (const element of extintores) {
                const vistoria = await Database.rawQuery('Select * from manutencoes where extintor_id = ? order by dataManutencao desc limit 1', [element.id]);

                if (vistoria[0].length > 0) {
                    element.ultimaVistoria = vistoria[0][0].dataManutencao;
                }
                else {
                    element.ultimaVistoria = null;
                }

                const set = setores.find((setor) => setor.id == element.setor_id);
                element.setor = set.nome;
            }

            return response.status(200).json(extintores);


        } catch (error) {
            return response.badRequest({
                message: 'Erro ao listar Extintores',
            });
        }
    }

    public async indexExtintoresSetor({ response, params }: HttpContextContract) {
        try {
            const setor = await Setor.findByOrFail("id", params.id);
            const extintores = await Database.query().select('*').from('extintors').where('setor_id', params.id).where('ativo', true).orderBy('proximaManutencao', 'asc');

            if (extintores.length > 0) {
                for (const element of extintores) {
                    const vistoria = await Database.rawQuery('Select * from manutencoes where extintor_id = ? order by dataManutencao desc limit 1', [element.id]);
    
                    if (vistoria[0].length > 0) {
                        element.ultimaVistoria = vistoria[0][0].dataManutencao;
                    }
                    else {
                        element.ultimaVistoria = null;
                    }

                    element.setor = setor.nome;
                }
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

    public async getExtintor({ response, params }: HttpContextContract) {
        try {
            let ResultExtintor = new Array();

            const extintor = await Database.query().select('*').from('extintors').where('id', params.id).first();
            if (extintor === null) {
                return response.badRequest({
                    message: 'Extintor não encontrado',
                });
            }

            const setor = await Setor.findByOrFail("id", extintor.setor_id);
            const vistoria = await Database.rawQuery('Select * from manutencoes where extintor_id = ? order by dataManutencao desc limit 1', [extintor.id]);

            const obj = {
                extintor_id: extintor.id,
                setor_id : setor.id,
                setor: setor.nome,
                nome: extintor.nome,
                tipoExtintor: extintor.tipoExtintor,
                tamanho: extintor.tamanho,
                validadeCasco: extintor.validadeCasco,
                validadeExtintor: extintor.validadeExtintor,
                proximaManutencao: extintor.proximaManutencao,
                ativo: extintor.ativo == 1 ? true : false,
                descricao: extintor.descricao,
                ultimaVistoria: vistoria[0].length > 0 ? vistoria[0][0].dataManutencao : null,
                manimetro: vistoria[0].length > 0 ? vistoria[0][0].manimetro == 1 ? true : false : false,
                sinalizacaoParede: vistoria[0].length > 0 ? vistoria[0][0].sinalizacaoParede  == 1 ? true : false: false,
                sinalizacaoPiso: vistoria[0].length > 0 ? vistoria[0][0].sinalizacaoPiso == 1 ? true : false : false,
                acesso: vistoria[0].length > 0 ? vistoria[0][0].acesso == 1 ? true : false : false,
                mangueira: vistoria[0].length > 0 ? vistoria[0][0].mangueira == 1 ? true : false : false,
                lacre: vistoria[0].length > 0 ? vistoria[0][0].lacre == 1 ? true : false : false,
            };
            ResultExtintor.push(obj)
            
            return response.ok(ResultExtintor);

        } catch (error) {
            return response.badRequest({
                message: 'Erro ao trazer Extintor',
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

            var a = await Database.insertQuery().table('extintors').insert({
                nome: payload.nome,
                tipoExtintor: payload.tipoExtintor,
                tamanho: payload.tamanho,
                validadeCasco: new Date(payload.validadeCasco.toISODate()),
                validadeExtintor: new Date(payload.validadeExtintor.toISODate()),
                proximaManutencao: new Date(payload.proximaManutencao!.toISODate()),
                ativo: payload.ativo,
                setor_id: setor.id,
                descricao: payload.descricao ?? "",
            });

            return response.status(201).json({
                id: a[0],
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
            const extintores = await Database.query().select('*').from('extintors').where('id', params.id);
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
