import BaseSeeder from '@ioc:Adonis/Lucid/Seeder'
import Tecnico from 'App/Models/Tecnico'
import User from 'App/Models/User'

export default class extends BaseSeeder {
  public async run () {
    const user = await User.create({
      email: 'tecnico@email.com',
      password: '123456',
      tipo: 'tecnicos',
    })
    
    await Tecnico.create({
      nome: 'Tecnico',
      online: true,
      bloqueado: false,
      empresaId: 1,
      userId: user.id,
    })
  }
}
