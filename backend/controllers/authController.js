const jwt = require('jsonwebtoken');
const db = require('../config/db');

exports.login = (req, res) => {
  const { email, password } = req.body;

  const query = 'SELECT * FROM student WHERE email = ?';
  db.query(query, [email], (err, results) => {
    if (err) throw err;

    if (results.length === 0) {
      return res.status(401).json({ message: 'User not found' });
    }

    const user = results[0];

    // Directly compare the plain text password
    if (password !== user.password) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    // Generate the JWT token
    const token = jwt.sign({ id: user.id }, 'ef38dde36c8efe0bad98a673f00bb8621616e62643b6e792c29dfe10951115eb', { expiresIn: '1h' });
    return res.json({
      token: token,
       name: user.name,
       email: user.email
     });
  });
};

exports.logout = (req, res) => {
  res.json({ message: 'Logged out successfully' });
};
