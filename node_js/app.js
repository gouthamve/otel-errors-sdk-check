const express = require('express');
const pino = require('pino');

const logger = pino({ level: 'info' });
const app = express();
const port = 8080;

app.get('/', (req, res) => {
    logger.info('Received request to root endpoint');
    res.send('Hello from Node.js Express!');
});

app.get('/throw-error', (req, res) => {
    logger.error('About to throw an intentional error');
    throw new Error('Intentional error from Node.js Express application');
});

// Error handling middleware to ensure OTEL captures the error
app.use((err, req, res, next) => {
    logger.error({ err }, 'Unhandled error occurred');
    res.status(500).send('Something broke!');
});

app.listen(port, '0.0.0.0', () => {
    logger.info(`Node.js app listening on port ${port}`);
});
