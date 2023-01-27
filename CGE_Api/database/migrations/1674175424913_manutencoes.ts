import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'manutencoes'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.integer('extintor_id').unsigned().references('id').inTable('extintors').onDelete('CASCADE')
      table.integer('tecnico_id').unsigned().references('id').inTable('tecnicos').onDelete('CASCADE')
      table.dateTime('dataManutencao').notNullable()
      table.boolean('manimetro').notNullable().defaultTo(false)
      table.boolean('sinalizacaoParede').notNullable().defaultTo(false)
      table.boolean('sinalizacaoPiso').notNullable().defaultTo(false)
      table.boolean('acesso').notNullable().defaultTo(false)
      table.boolean('mangueira').notNullable().defaultTo(false)
      table.boolean('lacre').notNullable().defaultTo(false)
      table.boolean('aprovado').notNullable().defaultTo(false)
      table.string('observacao', 255).nullable()
      table.timestamp('created_at').notNullable()
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
