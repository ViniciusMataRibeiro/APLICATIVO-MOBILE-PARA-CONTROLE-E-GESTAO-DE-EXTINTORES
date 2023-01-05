import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'tecnicos'

  public async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.integer('user_id').unsigned().notNullable().references('id').inTable('users').onDelete('CASCADE')
      table.integer('empresa_id').unsigned().notNullable().references('id').inTable('empresas').onDelete('CASCADE')
      table.string('nome', 255).notNullable()
      table.boolean('online').notNullable().defaultTo(false)
      table.boolean('bloqueado').notNullable().defaultTo(false)
      table.timestamp('updated_at').notNullable()
    })
  }

  public async down() {
    this.schema.dropTable(this.tableName)
  }
}
