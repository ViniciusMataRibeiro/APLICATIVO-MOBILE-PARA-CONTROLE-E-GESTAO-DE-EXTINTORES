import { schema, CustomMessages, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class EditSetorValidator {
  constructor(protected ctx: HttpContextContract) {}

  public schema = schema.create({
    id: schema.number(),
    
    nome: schema.string({ trim: true }, [
      rules.minLength(3),
      rules.maxLength(50),
    ]),
    descricao: schema.string.nullableAndOptional({ trim: true }, [
      rules.minLength(3),
      rules.maxLength(50),
    ]),
    ativo: schema.boolean(),
  })

  public messages: CustomMessages = {}
}
