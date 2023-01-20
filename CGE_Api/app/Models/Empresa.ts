import { DateTime } from 'luxon'
import { BaseModel, column, HasMany, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Setor from './Setor'
import Tecnico from './Tecnico'

export default class Empresa extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public userId: number

  @column()
  public nome: string

  @column()
  public telefone: string

  @column()
  public online: boolean

  @column()
  public bloqueado: boolean

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @hasMany(() => Setor, {
    foreignKey: 'empresa_id',
    localKey: 'id',
  })
  public Setor: HasMany<typeof Setor>

  @hasMany(() => Tecnico, {
    foreignKey: 'empresa_id',
    localKey: 'id',
  })
  public Tecnico: HasMany<typeof Tecnico>
}
