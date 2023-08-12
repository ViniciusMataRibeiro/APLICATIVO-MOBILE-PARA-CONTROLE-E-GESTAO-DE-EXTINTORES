import { schema, CustomMessages,rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class CreateManutencaoValidator {
  constructor(protected ctx: HttpContextContract) {}

  public schema = schema.create({
    extintor_id: schema.number([
      rules.unsigned(),
    ]),

    tecnico_id: schema.number([
      rules.unsigned(),
    ]),

    dataManutencao: schema.date({}),

    manimetro: schema.boolean(),

    sinalizacaoParede: schema.boolean(),

    sinalizacaoPiso: schema.boolean(),

    acesso: schema.boolean(),

    mangueira: schema.boolean(),

    lacre: schema.boolean(),

    aprovado: schema.boolean(),

    descricao: schema.string.nullableAndOptional({ }, [
      rules.minLength(5),
      rules.maxLength(100),
    ]),
  })

  public messages: CustomMessages = {
    'extintor_id.required': 'O campo {{ field }} é obrigatório',
    'tecnico_id.required': 'O campo {{ field }} é obrigatório',
    'dataManutencao.required': 'O campo {{ field }} é obrigatório',
    'manimetro.required': 'O campo {{ field }} é obrigatório',
    'sinalizacaoParede.required': 'O campo {{ field }} é obrigatório',
    'sinalizacaoPiso.required': 'O campo {{ field }} é obrigatório',
    'acesso.required': 'O campo {{ field }} é obrigatório',
    'mangueira.required': 'O campo {{ field }} é obrigatório',
    'lacre.required': 'O campo {{ field }} é obrigatório',
    'aprovado.required': 'O campo {{ field }} é obrigatório',
    'descricao.required': 'O campo {{ field }} é obrigatório',
    'descricao.minLength': 'O campo {{ field }} deve ter no mínimo 3 caracteres',
    'descricao.maxLength': 'O campo {{ field }} deve ter no máximo 50 caracteres',
  }
}
