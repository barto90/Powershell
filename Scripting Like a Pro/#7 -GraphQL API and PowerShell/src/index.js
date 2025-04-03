const startServer = require('./config/server');

startServer().catch(error => {
  console.error('Failed to start server:', error);
  process.exit(1);
}); 