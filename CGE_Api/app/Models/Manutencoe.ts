import { DateTime } from 'luxon'
import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'

export default class Manutencoe extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public extintor_id: number

  @column()
  public tecnico_id: number

  @column()
  public dataManutencao: DateTime

  @column()
  public manimetro: boolean

  @column()
  public sinalizacaoParede: boolean

  @column()
  public sinalizacaoPiso: boolean

  @column()
  public acesso: boolean

  @column()
  public mangueira: boolean

  @column()
  public lacre: boolean

  @column()
  public aprovado: boolean

  @column()
  public observacao: string | null

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime
}
