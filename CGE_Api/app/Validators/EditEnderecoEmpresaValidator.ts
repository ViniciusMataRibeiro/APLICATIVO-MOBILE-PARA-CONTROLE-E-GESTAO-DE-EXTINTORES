import { schema, CustomMessages, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class EditEnderecoEmpresaValidator {
  constructor(protected ctx: HttpContextContract) {}

  public schema = schema.create({
    cep: schema.string({ trim: true }, [
      rules.required(),
      rules.minLength(7),
      rules.maxLength(9),
    ]),

    rua: schema.string({ trim: true }, [
      rules.required(),
      rules.minLength(3),
      rules.maxLength(50),
    ]),

    numero: schema.string({ trim: true }, [
      rules.required(),
      rules.minLength(1),
      rules.maxLength(10),
    ]),

    bairro: schema.string({ trim: true }, [
      rules.required(),
      rules.minLength(5),
      rules.maxLength(50),
    ]),

    cidade: schema.string({ trim: true }, [
      rules.required(),
      rules.minLength(5),
      rules.maxLength(50),
    ]),

    ponto_referencia: schema.string.optional({ trim: true }, [
      rules.minLength(5),
      rules.maxLength(50),
    ]),

    uf : schema.string({ trim: true }, [
      rules.required(),
      rules.maxLength(3),
    ]),
  })

  public messages: CustomMessages = {}
}
