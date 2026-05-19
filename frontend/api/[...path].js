module.exports = async function handler(req, res) {
  res.setHeader('X-SMMR-Proxy', 'vercel-api');
  res.setHeader('Access-Control-Allow-Credentials', 'true');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Requested-With');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');

  if (req.method === 'OPTIONS') {
    res.status(204).end();
    return;
  }

  const backendUrl = (process.env.BACKEND_URL || '').replace(/\/+$/, '');

  if (!backendUrl) {
    res.status(500).json({
      message: 'Missing BACKEND_URL environment variable.',
    });
    return;
  }

  const rawPath =
    req.query.path ??
    req.query['...path'] ??
    req.query.slug ??
    '';

  const path = Array.isArray(rawPath) ? rawPath.join('/') : String(rawPath);

  const cleanPath = path
    .replace(/^\/+/, '')
    .replace(/^api\/?/, '');

  const target = new URL(`/api/${cleanPath}`, backendUrl);

  for (const [key, value] of Object.entries(req.query)) {
    if (key === 'path' || key === '...path' || key === 'slug' || key === 'debug_proxy') {
      continue;
    }

    if (Array.isArray(value)) {
      for (const item of value) {
        target.searchParams.append(key, item);
      }
    } else {
      target.searchParams.append(key, value);
    }
  }

  if (req.query.debug_proxy === '1') {
    res.status(200).json({
      method: req.method,
      rawPath,
      cleanPath,
      target: target.toString(),
    });
    return;
  }

  const headers = {
    Accept: req.headers.accept || 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  if (req.headers['content-type']) {
    headers['Content-Type'] = req.headers['content-type'];
  }

  if (req.headers.authorization) {
    headers.Authorization = req.headers.authorization;
  }

  if (req.headers.cookie) {
    headers.Cookie = req.headers.cookie;
  }

  try {
    const response = await fetch(target, {
      method: req.method,
      headers,
      body: ['GET', 'HEAD'].includes(req.method)
        ? undefined
        : serializeBody(req.body),
    });

    const contentType = response.headers.get('content-type');

    if (contentType) {
      res.setHeader('Content-Type', contentType);
    }

    const responseBody = Buffer.from(await response.arrayBuffer());
    res.status(response.status).send(responseBody);
  } catch (error) {
    res.status(502).json({
      message: 'Vercel could not reach the Railway backend.',
      target: target.toString(),
      error: error.message,
    });
  }
};

function serializeBody(body) {
  if (body === undefined || body === null) {
    return undefined;
  }

  return typeof body === 'string' ? body : JSON.stringify(body);
}