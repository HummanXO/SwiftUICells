const jsonServer = require('json-server');
const server = jsonServer.create();
const router = jsonServer.router('db.json');
const middlewares = jsonServer.defaults();

server.use(middlewares);
server.use(jsonServer.bodyParser);

// 🔍 Валидация для пользователей
function validateUser(req, res, next) {
  const { name } = req.body;
  if (!name || name.trim() === '') {
    return res.status(400).json({ error: "Поле 'name' обязательно." });
  }
  next();
}

// ✅ POST: создать пользователя + вернуть id
server.post('/users', validateUser, (req, res) => {
  const db = router.db;
  const users = db.get('users');

  const newUser = {
    ...req.body,
    id: Date.now() // ✅ перезапишет, даже если клиент прислал id
  };

  users.push(newUser).write();
  res.status(201).json(newUser);
});

// ✅ PUT/PATCH проходят через валидацию
server.put('/users/:id', validateUser);
server.patch('/users/:id', validateUser);

server.use(router);
server.listen(3000, () => {
  console.log('🚀 JSON Server запущен на http://localhost:3000');
});