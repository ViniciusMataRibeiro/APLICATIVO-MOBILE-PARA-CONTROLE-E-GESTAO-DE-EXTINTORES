import { DateTime } from 'luxon'
import { BaseModel, column, HasMany, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Manutencoe from './Manutencoe'

export default class Extintor extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public nome: string

  @column()
  public tipoExtintor: string

  @column()
  public tamanho: number

  @column()
  public validadeCasco: Date

  @column()
  public proximaManutencao: Date | null

  @column()
  public ativo: boolean

  @column()
  public setor_id: number

  @column()
  public descricao: string | null

  @column()
  public validadeExtintor: Date
  
  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @column.dateTime()
  public deletedAt: DateTime

  @hasMany(() => Manutencoe, {
    foreignKey: 'extintor_id',
    localKey: 'id',
  })
  public Extintor: HasMany<typeof Manutencoe>
}
