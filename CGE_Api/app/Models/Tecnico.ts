import { DateTime } from 'luxon'
import { BaseModel, column, HasOne, hasOne } from '@ioc:Adonis/Lucid/Orm'
import Empresa from './Empresa'

export default class Tecnico extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public userId: number

  @hasOne(() => Empresa,{
    foreignKey: 'empresa_id',
    localKey: 'id',
  })  

  public Empresa: HasOne<typeof Empresa>

  @column()
  public nome: string

  @column()
  public online: boolean

  @column()
  public bloqueado: boolean

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
