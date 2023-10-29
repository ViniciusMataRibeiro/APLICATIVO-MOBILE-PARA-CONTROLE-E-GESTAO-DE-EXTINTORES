import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext';
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
            const endereco = await Database.query().select('*').from('endereco_empresas').where('empresa_id', empresa.id).firstOrFail();

            return response.ok(endereco);
        } catch (error) {
            return response.badRequest({
                message: 'Erro ao buscar Endereço',
            });
        }
    }

    public async store({ request, response, auth }: HttpContextContract) {
        const payload = await request.validate(CreateEnderecoEmpresaValidator);
        try {
            const userAuth = await auth.use('api').authenticate();
            const empresa = await Empresa.findByOrFail("user_id", userAuth.id);

            const endereco = await EnderecoEmpresa.create({
                empresa_id: empresa.id,
                cep: payload.cep,
                rua: payload.rua,
                numero: payload.numero,
                bairro: payload.bairro,
                cidade: payload.cidade,
                ponto_referencia: payload.ponto_referencia,
                uf: payload.uf
            });

            return response.ok({
                id: endereco.id,
                cep: endereco.cep,
                rua: endereco.rua,
                numero: endereco.numero,
                bairro: endereco.bairro,
                cidade: endereco.cidade,
                ponto_referencia: endereco.ponto_referencia,
                uf: endereco.uf
            });

        } catch (error) {
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
                ponto_referencia: payload.ponto_referencia ?? "",
                uf: payload.uf
            });

            endereco.save();

            return response.ok({
                id: endereco.id,
                cep: endereco.cep,
                rua: endereco.rua,
                numero: endereco.numero,
                bairro: endereco.bairro,
                ponto_referencia: endereco.ponto_referencia,
                uf: endereco.uf
            });

        } catch {
            return response.badRequest({
                message: 'Erro ao Editar Endereço',
            });
        }
    }
}
