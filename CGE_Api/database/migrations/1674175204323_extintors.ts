import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'extintors'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.integer('setor_id').unsigned().references('id').inTable('setors').onDelete('CASCADE')
      table.string('nome', 255).notNullable().unique()
      table.string('tipoExtintor').notNullable()
      table.integer('tamanho').notNullable()
      table.date('validadeCasco').notNullable()
      table.date('proximaManutencao').nullable()
      table.boolean('ativo').notNullable().defaultTo(true)
      table.string('descricao', 255).notNullable()
      table.date('validadeExtintor').notNullable()
      table.timestamps(true, true)
      table.timestamp('deleted_at').nullable()
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
