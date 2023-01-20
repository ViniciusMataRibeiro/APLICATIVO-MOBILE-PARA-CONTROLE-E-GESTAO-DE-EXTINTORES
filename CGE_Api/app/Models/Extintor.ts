import { DateTime } from 'luxon'
import { BaseModel, column, HasMany, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Manutencoe from './Manutencoe'

export default class Extintor extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public nome: string

  @column()
  public tipoExtintor: number

  @column()
  public tamanho: number

  @column()
  public validadeCasco: DateTime

  @column()
  public proximaManutencao: DateTime

  @column()
  public ativo: boolean

  @column()
  public setor_id: number

  @column()
  public descricao: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @hasMany(() => Manutencoe, {
    foreignKey: 'extintor_id',
    localKey: 'id',
  })
  public Extintor: HasMany<typeof Manutencoe>
}
