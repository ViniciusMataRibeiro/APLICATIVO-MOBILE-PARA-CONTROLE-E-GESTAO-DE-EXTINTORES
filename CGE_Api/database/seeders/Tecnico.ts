import BaseSeeder from '@ioc:Adonis/Lucid/Seeder'
import Tecnico from 'App/Models/Tecnico'
import User from 'App/Models/User'

export default class extends BaseSeeder {
  public async run () {
    const user = await User.create({
      email: 'gleison@email.com',
      password: '123456',
      tipo: 'tecnico',
    })
    
    await Tecnico.create({
      nome: 'Gleison',
      online: true,
      bloqueado: false,
      empresa_id: 1,
      userId: user.id,
    })
  }
}
