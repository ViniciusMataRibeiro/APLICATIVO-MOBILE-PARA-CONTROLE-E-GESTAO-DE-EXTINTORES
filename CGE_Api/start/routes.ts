import Route from '@ioc:Adonis/Core/Route'

Route.post('/login', 'AuthController.login');
Route.post('/logout', 'AuthController.logout');

Route.post('/empresa/cadastro', 'EmpresasController.store');

Route.group(() => {
  Route.get('auth/me', 'AuthController.me');

  Route.put('/empresa', 'EmpresasController.update');
}).middleware('auth');

Route.get('/', async () => {
  return { hello: 'world' }
})