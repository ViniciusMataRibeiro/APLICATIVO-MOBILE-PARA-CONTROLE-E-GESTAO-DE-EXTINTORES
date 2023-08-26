import Route from '@ioc:Adonis/Core/Route'

Route.post('/login', 'AuthController.login');
Route.post('/logout', 'AuthController.logout');

Route.post('/empresa', 'EmpresasController.store');


Route.group(() => {
  Route.get('auth/me', 'AuthController.me');

  Route.get('/Tecnicos', 'TecnicosController.index');
  Route.post('/tecnico', 'TecnicosController.store');
  Route.put('/tecnico/:id', 'TecnicosController.update');
  Route.delete('/tecnico/:id', 'TecnicosController.destroy');

  Route.get('/Empresas', 'EmpresasController.index');
  Route.put('/empresa', 'EmpresasController.update');
  Route.delete('/empresa/:id', 'EmpresasController.destroy');

  Route.get('/empresaEndereco', 'EnderecoEmpresasController.index');
  Route.post('/empresaEndereco', 'EnderecoEmpresasController.store');
  Route.put('/empresaEndereco/:id', 'EnderecoEmpresasController.update');

  Route.get('/resumoSetor', 'SetorsController.ResumoSetor');
  Route.get('/setors', 'SetorsController.index');
  Route.post('/setor', 'SetorsController.store');
  Route.put('/setor/:id', 'SetorsController.update');
  Route.delete('/setor/:id', 'SetorsController.destroy');

  Route.get('/extintorById/:id', 'ExtintorsController.getExtintor');
  Route.get('/extintorsAll', 'ExtintorsController.indexAllExtintores');
  Route.get('/extintorsSetor/:id', 'ExtintorsController.indexExtintoresSetor');
  Route.post('/extintor', 'ExtintorsController.store');
  Route.put('/extintor/:id', 'ExtintorsController.update');
  Route.delete('/extintor/:id', 'ExtintorsController.destroy');

  Route.get('/manutencao', 'ManutencaosController.index');
  Route.post('/manutencao', 'ManutencaosController.store');
  Route.put('/manutencao/:id', 'ManutencaosController.update');

}).middleware('auth');