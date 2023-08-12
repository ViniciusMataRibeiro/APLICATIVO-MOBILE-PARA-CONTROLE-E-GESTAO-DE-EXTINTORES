import { BaseModel, column, HasOne, hasOne } from '@ioc:Adonis/Lucid/Orm'
import Empresa from './Empresa'

export default class EnderecoEmpresa extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public empresa_id: number

  @hasOne(() => Empresa,{
    foreignKey: 'empresa_id',
    localKey: 'id',
  })  

  public Empresa: HasOne<typeof Empresa>

  @column()
  public cep: string

  @column()
  public rua: string

  @column()
  public numero: string

  @column()
  public bairro: string

  @column()
  public cidade: string

  @column()
  public ponto_referencia: string | null

  @column()
  public uf: string
}
