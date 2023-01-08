import Route from '@ioc:Adonis/Core/Route'

Route.post('/login', 'AuthController.login');
Route.post('/logout', 'AuthController.logout');

Route.post('/empresa/cadastro', 'EmpresasController.store');

Route.post('/tecnico/cadastro/:id', 'TecnicosController.store');

Route.group(() => {
  Route.get('auth/me', 'AuthController.me');

  Route.get('/Tecnicos', 'TecnicosController.index');

  Route.put('/empresa', 'EmpresasController.update');
}).middleware('auth');

Route.get('/', async () => {
  return { hello: 'world' }
})