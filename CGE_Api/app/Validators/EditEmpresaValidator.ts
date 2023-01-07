import { schema, CustomMessages, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class EditEmpresaValidator {
  constructor(protected ctx: HttpContextContract) { }

  public refs = schema.refs({
    user_id: this.ctx.auth.user!.id,
  })

  public schema = schema.create({
    nome: schema.string({ trim: true }, [
      rules.minLength(3),
      rules.maxLength(100),
    ]),

    email: schema.string({ trim: true }, [
      rules.email(),
      rules.maxLength(100),
      rules.unique({ table: 'users', column: 'email', whereNot: { id: this.refs.user_id } }),
    ]),

    password: schema.string.nullableAndOptional({}, [
      rules.minLength(6),
      rules.maxLength(20),
    ]),

    telefone: schema.string({ trim: true }, [
      rules.mobile({ locale: ['pt-BR'] }),
      rules.maxLength(15),
    ]),
  })

  public messages: CustomMessages = {
    required: 'O campo {{ field }} é obrigatório',
    'nome.minLength': 'O campo {{ field }} deve ter no mínimo 3 caracteres',
    'nome.maxLength': 'O campo {{ field }} deve ter no máximo 100 caracteres',
    'email.email': 'O campo {{ field }} deve ser um email válido',
    'email.maxLength': 'O campo {{ field }} deve ter no máximo 100 caracteres',
    'password.minLength': 'O campo {{ field }} deve ter no mínimo 6 caracteres',
    'password.maxLength': 'O campo {{ field }} deve ter no máximo 20 caracteres',
    'telefone.mobile': 'O campo {{ field }} deve ser um número de celular válido',
    'telefone.maxLength': 'O campo {{ field }} deve ter no máximo 15 caracteres',
  }
}
