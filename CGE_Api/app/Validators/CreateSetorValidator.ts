import { schema, CustomMessages, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class CreateSetorValidator {
  constructor(protected ctx: HttpContextContract) {}

  public schema = schema.create({
    nome: schema.string({ trim: true }, [
      rules.required(),
      rules.minLength(3),
      rules.maxLength(50),
    ]),
    descricao: schema.string.nullableAndOptional({ trim: true }, [
      rules.minLength(3),
      rules.maxLength(50),
    ]),
    ativo: schema.boolean(),
  })

  public messages: CustomMessages = {
    'nome.required': 'O campo {{ field }} é obrigatório',
    'nome.minLength': 'O campo {{ field }} deve ter no mínimo 3 caracteres',
    'nome.maxLength': 'O campo {{ field }} deve ter no máximo 50 caracteres',
    'descricao.required': 'O campo {{ field }} é obrigatório',
    'descricao.minLength': 'O campo {{ field }} deve ter no mínimo 3 caracteres',
    'descricao.maxLength': 'O campo {{ field }} deve ter no máximo 50 caracteres',
  }
}
