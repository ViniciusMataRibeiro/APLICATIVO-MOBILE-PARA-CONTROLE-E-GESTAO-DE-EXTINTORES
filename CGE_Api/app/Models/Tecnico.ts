import { DateTime } from 'luxon'
import { BaseModel, column, HasMany, hasMany} from '@ioc:Adonis/Lucid/Orm'
import Manutencoe from './Manutencoe'

export default class Tecnico extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public userId: number

  @column()
  public empresa_id: number

  @column()
  public nome: string

  @column()
  public online: boolean

  @column()
  public bloqueado: boolean

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @hasMany(() => Manutencoe, {
    foreignKey: 'tecnico_id',
    localKey: 'id',
  })
  public Extintor: HasMany<typeof Manutencoe>
}
