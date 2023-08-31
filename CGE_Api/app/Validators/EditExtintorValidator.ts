import { schema, CustomMessages, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class EditExtintorValidator {
  constructor(protected ctx: HttpContextContract) { }

  public schema = schema.create({
    nome: schema.string({ trim: true }, [
      rules.minLength(1),
      rules.maxLength(100),
    ]),

    tipoExtintor: schema.string({ trim: true }, []),

    tamanho: schema.number([
      rules.unsigned(),
    ]),

    validadeCasco: schema.date({}),

    validadeExtintor: schema.date({}),

    proximaManutencao: schema.date.nullableAndOptional({}),

    ativo: schema.boolean(),

    setor_id: schema.number([
      rules.unsigned(),
    ]),

    descricao: schema.string.nullableAndOptional({ }, [
      rules.minLength(5),
      rules.maxLength(100),
    ]),
  })

  public messages: CustomMessages = {
    required: 'O campo {{ field }} é obrigatório',
    'nome.minLength': 'O campo {{ field }} deve ter no mínimo 5 caracteres',
    'nome.maxLength': 'O campo {{ field }} deve ter no máximo 100 caracteres',
    'tipoExtintor.unsigned': 'O campo {{ field }} deve ser um número positivo',
    'tamanho.unsigned': 'O campo {{ field }} deve ser um número positivo',
    'validadeCasco.date': 'O campo {{ field }} deve ser uma data válida',
    'proximaManutencao.date': 'O campo {{ field }} deve ser uma data válida',
    'setor_id.unsigned': 'O campo {{ field }} deve ser um número positivo',
    'descricao.minLength': 'O campo {{ field }} deve ter no mínimo 5 caracteres',
    'descricao.maxLength': 'O campo {{ field }} deve ter no máximo 100 caracteres',
  }
}
