const users = require('../data/users');

const resolvers = {
  Query: {
    users: () => users,
    user: (_, { email }) => users.find(user => user.email === email)
  },
  Mutation: {
    addUser: (_, { input }) => {
      if (users.some(user => user.email === input.email)) {
        throw new Error('User with this email already exists');
      }
      
      users.push(input);
      return input;
    },
    
    updateUser: (_, { email, input }) => {
      const userIndex = users.findIndex(user => user.email === email);
      if (userIndex === -1) {
        throw new Error('User not found');
      }

      users[userIndex] = {
        ...input,
        email 
      };
      
      return users[userIndex];
    },
    
    deleteUser: (_, { email }) => {
      const userIndex = users.findIndex(user => user.email === email);
      if (userIndex === -1) {
        throw new Error('User not found');
      }
      
      users.splice(userIndex, 1);
      return true;
    }
  }
};

module.exports = resolvers; 