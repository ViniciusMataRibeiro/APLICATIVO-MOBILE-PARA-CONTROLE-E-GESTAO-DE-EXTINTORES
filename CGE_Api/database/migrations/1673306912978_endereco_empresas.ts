import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'endereco_empresas'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.integer('empresa_id').unsigned().references('id').inTable('empresas').onDelete('CASCADE')
      table.string('cep', 8).notNullable()
      table.string('rua', 50).notNullable()
      table.string('numero', 10).notNullable()
      table.string('bairro', 50).notNullable()
      table.string('cidade', 50).notNullable()
      table.string('ponto_referencia', 50).nullable()
      table.string('uf', 2).notNullable()
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
