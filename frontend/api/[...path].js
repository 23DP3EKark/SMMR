module.exports = async function handler(req, res) {
  if (req.method === 'OPTIONS') {
    res.status(204).end();
    return;
  }

  const backendUrl = (process.env.BACKEND_URL || process.env.VITE_API_BASE_URL || '').replace(/\/+$/, '');

  if (!backendUrl) {
    res.status(500).json({
      message: 'Missing BACKEND_URL environment variable.',
    });
    return;
  }

  const path = Array.isArray(req.query.path) ? req.query.path.join('/') : req.query.path;
  const target = new URL(`/${path || ''}`, backendUrl);

  for (const [key, value] of Object.entries(req.query)) {
    if (key !== 'path') {
      target.searchParams.append(key, value);
    }
  }

  const headers = {
    Accept: req.headers.accept || 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  if (req.headers['content-type']) {
    headers['Content-Type'] = req.headers['content-type'];
  }

  if (req.headers.cookie) {
    headers.Cookie = req.headers.cookie;
  }

  const response = await fetch(target, {
    method: req.method,
    headers,
    body: ['GET', 'HEAD'].includes(req.method) ? undefined : serializeBody(req.body),
  });

  const contentType = response.headers.get('content-type');
  const setCookie = response.headers.get('set-cookie');

  if (contentType) {
    res.setHeader('Content-Type', contentType);
  }

  if (setCookie) {
    res.setHeader('Set-Cookie', setCookie);
  }

  res.status(response.status).send(Buffer.from(await response.arrayBuffer()));
};

function serializeBody(body) {
  if (body === undefined || body === null) {
    return undefined;
  }

  return typeof body === 'string' ? body : JSON.stringify(body);
}
