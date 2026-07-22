import 'package:flutter/material.dart';

class CatalogoBasicos extends StatelessWidget {
  const CatalogoBasicos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widgets básicos')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ── Bloque 1: Text ────────────────────────────────────────────
          const Text(
            'nginx-proxy: En línea',
            style: TextStyle(
              fontSize:      20,
              fontWeight:    FontWeight.bold,
              color:         Colors.green,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Text(
              'api-gateway-produccion-region-us-east → sin respuesta',
              textAlign: TextAlign.center,
              maxLines:  1,
              overflow:  TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          const Text.rich(
            TextSpan(children: [
              TextSpan(text: 'Estado: ',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              TextSpan(text: 'CRÍTICO',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              TextSpan(text: ' — última revisión hace 5 min',
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
            ]),
          ),
          const SizedBox(height: 8),
          const SelectableText('10.0.0.12:5432',
              style: TextStyle(fontFamily: 'monospace', fontSize: 14)),
          const Divider(height: 32),

          // ── Bloque 2: Icon ────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.check_circle,  size: 40, color: Colors.green),
              Icon(Icons.cancel,        size: 40, color: Colors.red),
              Icon(Icons.warning_amber, size: 40, color: Colors.orange),
              Icon(Icons.dns,           size: 40, color: Colors.indigo),
              Icon(Icons.wifi_off,      size: 40, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 8),
          const Icon(Icons.settings, size: 24, color: Colors.blueGrey,
              semanticLabel: 'Configuración'),
          const Divider(height: 32),

          // ── Bloque 3: Botones ─────────────────────────────────────────
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('ElevatedButton')),
              FilledButton(  onPressed: () {}, child: const Text('FilledButton')),
              OutlinedButton(onPressed: () {}, child: const Text('OutlinedButton')),
              TextButton(    onPressed: () {}, child: const Text('TextButton')),
              ElevatedButton(onPressed: null,  child: const Text('Desactivado')),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon:  const Icon(Icons.refresh, size: 18),
                label: const Text('Reiniciar'),
              ),
              FilledButton.icon(
                onPressed: () {},
                icon:  const Icon(Icons.stop, size: 18),
                label: const Text('Detener'),
              ),
              IconButton(
                onPressed: () {},
                icon:     const Icon(Icons.settings),
                color:    Colors.indigo,
                iconSize: 28,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              padding:     const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation:   4,
              minimumSize: const Size(double.infinity, 0),
            ),
            child: const Text('Acción crítica',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 32),

          // ── Bloque 4: Card y ListTile ─────────────────────────────────
          Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading:  const Icon(Icons.dns, color: Colors.indigo),
              title:    const Text('nginx-proxy'),
              subtitle: const Text('10.0.0.5 · 45ms'),
              trailing: const Icon(Icons.circle, color: Colors.green, size: 12),
              onTap:    () {},
            ),
          ),
          Card(
            elevation: 1,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red.shade100,
                child: const Icon(Icons.cancel, color: Colors.red, size: 20),
              ),
              title:    const Text('backup-worker'),
              subtitle: const Text('sin respuesta · 10.0.0.30'),
              trailing: TextButton(
                  onPressed: () {}, child: const Text('Ver')),
            ),
          ),
          const Divider(height: 32),

          // ── Bloque 5: Chip ────────────────────────────────────────────
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              const Chip(label: Text('nginx')),
              const Chip(
                avatar:          Icon(Icons.check, size: 16, color: Colors.white),
                label:           Text('TLS 1.3'),
                backgroundColor: Colors.green,
                labelStyle: TextStyle(color: Colors.white, fontSize: 12),
              ),
              FilterChip(
                label: const Text('HTTP/2'),
                selected: true, onSelected: (_) {},
              ),
              ActionChip(
                label:     const Text('Ver logs'),
                avatar:    const Icon(Icons.open_in_new, size: 16),
                onPressed: () {},
              ),
            ],
          ),
          const Divider(height: 32),

          // ── Bloque 6: Indicadores de progreso ────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SizedBox(width: 48, height: 48,
                  child: CircularProgressIndicator()),
              SizedBox(width: 48, height: 48,
                  child: CircularProgressIndicator(
                    value: 0.7, color: Colors.green, strokeWidth: 6)),
              SizedBox(width: 48, height: 48,
                  child: CircularProgressIndicator(
                    value: 0.3, color: Colors.red,
                    strokeWidth: 3, strokeCap: StrokeCap.round)),
            ],
          ),
          const SizedBox(height: 16),
          const LinearProgressIndicator(),
          const SizedBox(height: 8),
          const LinearProgressIndicator(value: 0.6, color: Colors.indigo),
          const SizedBox(height: 8),
          const LinearProgressIndicator(
              value: 1.0, color: Colors.green, minHeight: 6),
        ],
      ),
    );
  }
}
