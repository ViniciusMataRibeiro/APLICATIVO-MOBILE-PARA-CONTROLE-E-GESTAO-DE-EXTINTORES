import Route from '@ioc:Adonis/Core/Route'

Route.post('/login', 'AuthController.login');
Route.post('/logout', 'AuthController.logout');

Route.group(() => {
  Route.get('auth/me', 'AuthController.me');

  Route.get('/Tecnicos', 'TecnicosController.index');
  Route.post('/tecnico/cadastro/:id', 'TecnicosController.store');
  Route.put('/tecnico', 'TecnicosController.update');
  Route.delete('/tecnico/:id', 'TecnicosController.destroy');

  Route.get('/Empresas', 'EmpresasController.index');
  Route.post('/empresa/cadastro', 'EmpresasController.store');
  Route.put('/empresa', 'EmpresasController.update');
  Route.delete('/empresa/:id', 'EmpresasController.destroy');
}).middleware('auth');