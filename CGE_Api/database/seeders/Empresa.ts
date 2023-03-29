import BaseSeeder from '@ioc:Adonis/Lucid/Seeder'
import Empresa from 'App/Models/Empresa'
import User from 'App/Models/User'

export default class extends BaseSeeder {
  public async run () {
    const user = await User.create({
      email: 'empresa@email.com',
      password: '123456',
      tipo: 'empresa',
    })
    await Empresa.create({
      nome: 'Empresa',
      telefone: '35 9 9999-9999',
      online: true,
      bloqueado: false,
      userId: user.id,
    })
  }
}
