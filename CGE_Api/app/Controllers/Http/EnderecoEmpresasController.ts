import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Database from '@ioc:Adonis/Lucid/Database';
import Empresa from 'App/Models/Empresa';
import EnderecoEmpresa from 'App/Models/EnderecoEmpresa';
import CreateEnderecoEmpresaValidator from 'App/Validators/CreateEnderecoEmpresaValidator';
import EditEnderecoEmpresaValidator from 'App/Validators/EditEnderecoEmpresaValidator';

export default class EnderecoEmpresasController {
    public async index({ response, auth }: HttpContextContract) {
        try {
            const userAuth = await auth.use('api').authenticate();

            const empresa = await Empresa.findByOrFail("user_id", userAuth.id);
            const endreco = await Database.query().select('*').from('endereco_empresas').where('empresa_id', empresa.id);

            return response.ok(endreco);
        } catch (error) {
            return response.badRequest({
                message: 'Erro ao buscar Endereço',
            });
        }
    }

    public async store({ request, response, params }: HttpContextContract) {
        const payload = await request.validate(CreateEnderecoEmpresaValidator);

        if (!params.id) {
            return response.badRequest({
                message: 'Empresa não encontrada',
            })
        }

        try {
            const endereco = await EnderecoEmpresa.create({
                empresa_id: params.id,
                cep: payload.cep,
                rua: payload.rua,
                numero: payload.numero,
                bairro: payload.bairro,
                cidade: payload.cidade,
                ponto_referencia: payload.ponto_referencia
            });

            return response.ok({
                id: endereco.id,
                cep: endereco.cep,
                rua: endereco.rua,
                numero: endereco.numero,
                bairro: endereco.bairro,
                cidade: endereco.cidade,
                ponto_referencia: endereco.ponto_referencia
            });

        } catch {
            return response.badRequest({
                message: 'Erro ao Criar Endereço',
            });
        }
    }

    public async update({ request, response, auth }: HttpContextContract) {
        const payload = await request.validate(EditEnderecoEmpresaValidator);
        const userAuth = await auth.use('api').authenticate();

        try {
            const empresa = await Empresa.findByOrFail("user_id", userAuth.id);
            const endereco = await EnderecoEmpresa.findByOrFail("empresa_id", empresa.id);

            endereco.merge({
                cep: payload.cep,
                rua: payload.rua,
                numero: payload.numero,
                bairro: payload.bairro,
                ponto_referencia: payload.ponto_referencia
            });

            endereco.save();

            return response.ok({
                id: endereco.id,
                cep: endereco.cep,
                rua: endereco.rua,
                numero: endereco.numero,
                bairro: endereco.bairro,
                ponto_referencia: endereco.ponto_referencia
            });

        } catch {
            return response.badRequest({
                message: 'Erro ao Editar Endereço',
            });
        }
    }
}
