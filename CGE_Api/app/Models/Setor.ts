import { DateTime } from 'luxon'
import { BaseModel, column, hasMany, HasMany } from '@ioc:Adonis/Lucid/Orm'
import Extintor from './Extintor'

export default class Setor extends BaseModel {
  @column({ isPrimary: true })
  public id: number
  
  @column()
  public empresa_id: number

  @column()
  public nome: string

  @column()
  public descricao: string | null

  @column()
  public ativo: boolean

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @column.dateTime()
  public deletedAt: DateTime | null

  @hasMany(() => Extintor, {
    foreignKey: 'setor_id',
    localKey: 'id',
  })

  public Extintor: HasMany<typeof Extintor>
}
