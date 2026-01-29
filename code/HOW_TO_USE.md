## Avvio rapido (3 minuti)

1. Apri `code/script.sh`.
2. Modifica SOLO la sezione CONFIG (in alto):
   - `BASE_DIR` deve essere un percorso ASSOLUTO dove scrivere i log
   - `TOTAL_LINES` e `DELAY_SECONDS` sono opzionali
3. Rendi eseguibile lo script e lancialo:

```bash
chmod +x code/script.sh
./code/script.sh
```

Al termine trovi i log in `BASE_DIR/log/`.

## Configurazione (nel file script.sh)

- `BASE_DIR`: cartella dove creare `log/` (obbligatorio, assoluto)
- `TOTAL_LINES`: quante righe generare (default 300)
- `DELAY_SECONDS`: pausa tra una riga e l'altra (0 = nessuna pausa)

## Output generato

Lo script crea 3 file:

```
log1.log
log2.log
log3.log
```

Esempio riga:

```
[2026-01-29 10:15:03] livello=INFO iter=42 pid=12345 evento=heartbeat valore=731
```

Livelli possibili: `INFO`, `DEBUG`, `SUCCESS`, `ERROR`, `CRITICAL`.
