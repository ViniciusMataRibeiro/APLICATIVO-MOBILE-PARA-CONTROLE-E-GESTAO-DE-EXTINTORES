import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Database from '@ioc:Adonis/Lucid/Database';
import Tecnico from 'App/Models/Tecnico';
import CreateManutencaoValidator from 'App/Validators/CreateManutencaoValidator';

export default class ManutencaosController {
    public async index({ response, auth }: HttpContextContract) {
        try {
            await auth.use('api').authenticate();
            const manutencoes = await Database.query().select('*').from('manutencoes').orderBy('dataManutencao', 'asc');

            let data = new Array();

            for (const element of manutencoes) {
                let obj;

                const extintor = await Database.query().select('*').from('extintors').where('id', element.extintor_id).first();
                const tecnico = await Database.query().select('*').from('tecnicos').where('id', element.tecnico_id).first();
                const setor = await Database.query().select('*').from('setors').where('id', extintor.setor_id).first();

                obj = {
                    // info tela principal
                    id: element.id,
                    dataManutencao: element.dataManutencao,
                    extintor_id: element.extintor_id,
                    numeroExtintor: extintor.nome,
                    setor_id: setor.setor_id,
                    setor: setor.nome,
                    tecnico_id: element.tecnico_id,
                    tecnico: tecnico.nome,
                    proximaManutencao: extintor.proximaManutencao,
                    apto: element.aprovado == 1 ? true : false,

                    observacao: element.observacao,

                    // modal
                    manometro: element.manimetro == 1 ? true : false,
                    sinalizacaoParede: element.sinalizacaoParede == 1 ? true : false,
                    sinalizacaoPiso: element.sinalizacaoPiso == 1 ? true : false,
                    acesso: element.acesso == 1 ? true : false,
                    mangueira: element.mangueira == 1 ? true : false,
                    lacre: element.lacre == 1 ? true : false,
                }

                data.push(obj);
            }

            return response.status(200).json(data);
        } catch (error) {
            return response.badRequest({
                message: 'Erro ao buscar as manutenções',
            });
        }
    }

    public async store({ request, response, auth }: HttpContextContract) {
        try {
            const payload = await request.validate(CreateManutencaoValidator);
            const userAuth = await auth.use('api').authenticate();
            const tecnico = await Tecnico.findByOrFail("user_id", userAuth.id);

            await Database.insertQuery().table('manutencoes').insert({
                extintor_id: payload.extintor_id,
                tecnico_id: tecnico.id,
                dataManutencao: new Date(payload.dataManutencao.toISODate()),
                manimetro: payload.manimetro,
                sinalizacaoParede: payload.sinalizacaoParede,
                sinalizacaoPiso: payload.sinalizacaoPiso,
                acesso: payload.acesso,
                mangueira: payload.mangueira,
                lacre: payload.lacre,
                aprovado: payload.aprovado,
                observacao: payload.descricao ?? "",
                created_at: new Date(payload.dataManutencao.toISODate()),
            });

            var date = new Date(payload.dataManutencao.toISODate());
            const sql = 'UPDATE extintors SET proximaManutencao = ? WHERE id = ?';
            await Database.rawQuery(sql, [new Date(date.getFullYear(), date.getMonth(), date.getDate() + 31), payload.extintor_id]);

            return response.status(201).json({
                message: 'vistoria cadastrada com sucesso',
            });
        }
        catch (error) {
            return response.badRequest({
                message: 'Erro ao cadastrar vistoria',
            });
        }
    }
}
