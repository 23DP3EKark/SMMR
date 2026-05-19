module.exports = async function handler(req, res) {
  res.setHeader('X-SMMR-Proxy', 'vercel-api');
  res.setHeader('Access-Control-Allow-Credentials', 'true');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Requested-With');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');

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
  const cleanPath = String(path || '').replace(/^api(?:\/|$)/, '');
  const target = new URL(`/api/${cleanPath}`, backendUrl);

  if (req.query.debug_proxy === '1') {
    res.status(200).json({
      method: req.method,
      target: target.toString(),
    });
    return;
  }

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

  let response;

  try {
    response = await fetch(target, {
      method: req.method,
      headers,
      body: ['GET', 'HEAD'].includes(req.method) ? undefined : serializeBody(req.body),
    });
  } catch (error) {
    res.status(502).json({
      message: 'Vercel could not reach the Railway backend.',
      target: target.origin,
      error: error.message,
    });
    return;
  }

  const contentType = response.headers.get('content-type');
  const setCookie = response.headers.get('set-cookie');

  if (contentType) {
    res.setHeader('Content-Type', contentType);
  }

  if (setCookie) {
    res.setHeader('Set-Cookie', setCookie);
  }

  const responseBody = Buffer.from(await response.arrayBuffer());

  if (!contentType && response.status >= 500) {
    res.status(response.status).json({
      message: 'Railway backend returned an error without a JSON body.',
      status: response.status,
      target: target.toString(),
      body: responseBody.toString('utf8').slice(0, 500),
    });
    return;
  }

  res.status(response.status).send(responseBody);
};

function serializeBody(body) {
  if (body === undefined || body === null) {
    return undefined;
  }

  return typeof body === 'string' ? body : JSON.stringify(body);
}
