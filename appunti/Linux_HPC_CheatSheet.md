# Linux Cheat Sheet 

Una pagina “da foto” con i comandi essenziali.  
**Tip:** usa `TAB` per autocompletare e `↑` per ripetere comandi.

---

## 0) Aiuto e “salvavita”
- `comando --help` — aiuto rapido (opzioni principali)
- `man comando` — manuale completo (esci con `q`)
- `history` — lista comandi usati
- `clear` — pulisce lo schermo
- `Ctrl+C` — interrompe un comando in corso
- `Ctrl+R` — ricerca nella history (digita, poi Invio)

---

## 1) Orientarsi (dove sono? cosa c’è?)
- `pwd` — mostra il percorso della cartella corrente
- `ls` — elenca file/cartelle
- `ls -lah` — elenco dettagliato, include nascosti, dimensioni “umane”
- `tree` — mostra struttura ad albero (se installato)

**Esempio**
```bash
pwd
ls -lah
```

---

## 2) Muoversi nel filesystem
- `cd cartella` — entra in una cartella
- `cd ..` — sale di un livello
- `cd` oppure `cd ~` — torna alla **home**
- `cd -` — torna alla cartella precedente
- `.` — cartella corrente
- `..` — cartella genitore

**Esempio**
```bash
cd progetto
cd ..
cd -
cd
```

---

## 3) Struttura cartelle (quelle utili)
- `/` — radice del sistema
- `/home/<utente>` — i tuoi file (zona sicura)
- `/tmp` — temporanei (possono essere puliti)
- `/etc` — configurazioni di sistema
- `/var/log` — log di sistema
- `/usr/bin` — programmi/comandi

---

## 4) Creare cartelle e file
- `mkdir nome` — crea cartella
- `mkdir -p a/b/c` — crea anche cartelle intermedie
- `touch file.txt` — crea file vuoto (o aggiorna timestamp)
- `echo "testo" > file.txt` — scrive (sovrascrive)
- `echo "riga" >> file.txt` — aggiunge in fondo

**Esempio**
```bash
mkdir -p progetto/{input,output,log}
touch readme.txt
echo "Ciao Leonardo" > readme.txt
echo "Seconda riga" >> readme.txt
```

---

## 5) Leggere e modificare file
- `cat file.txt` — stampa tutto (file piccoli)
- `less file.txt` — scorre (esci con `q`, cerca con `/parola`)
- `head -n 20 file.txt` — prime 20 righe
- `tail -n 20 file.txt` — ultime 20 righe
- `nano file.txt` — editor semplice  
  - salva: `Ctrl+O` + Invio  
  - esci: `Ctrl+X`

**Esempio**
```bash
less log/log1.log
tail -n 50 log/log2.log
nano config.txt
```

---

## 6) Copiare, spostare, rinominare, cancellare
- `cp a b` — copia file `a` in `b`
- `cp -r dir1 dir2` — copia cartella ricorsiva
- `mv a b` — sposta o rinomina
- `rm file` — cancella file (**senza cestino**)
- `rm -r cartella` — cancella cartella (**attenzione**)
- `rmdir cartella` — rimuove cartella **vuota**

**Esempio**
```bash
cp input.dat input_backup.dat
mv input_backup.dat backup/
rm -r vecchio_output/
```

---

## 7) Cercare file e testo (super potere)
### Trovare file/cartelle per nome
- `find . -name "*.txt"` — cerca da qui in giù

### Cercare testo dentro file
- `grep "parola" file.txt` — trova righe contenenti “parola”
- `grep -n "parola" file.txt` — con numero di riga
- `grep -R "ERROR" log/` — ricorsivo in una cartella
- `grep -i "parola" file.txt` — ignora maiuscole/minuscole

**Esempio**
```bash
find . -name "*.out"
grep -R "CRITICAL" log/
```

---

## 8) Redirection: salvare output e errori
- `comando > out.txt` — salva output (sovrascrive)
- `comando >> out.txt` — salva output (aggiunge)
- `comando 2> err.txt` — salva errori
- `comando > out.txt 2> err.txt` — separa output ed errori
- `comando | less` — manda output a `less`
- `comando1 | comando2` — pipe (output di 1 → input di 2)

**Esempio**
```bash
ls -lah > lista.txt
python script.py > out.txt 2> err.txt
cat out.txt | less
```

---

## 9) Permessi (owner / group / others)
- `ls -l` — mostra permessi e proprietari
- `chmod +x script.sh` — rende eseguibile
- `chmod 644 file.txt` — owner rw, altri r
- `chmod 755 script.sh` — owner rwx, altri rx

**Leggere i permessi**
- `-rw-r--r--` → file: owner legge/scrive; altri leggono
- `drwxr-xr-x` → cartella: owner tutto; altri entrano e leggono

**Esempio**
```bash
ls -l
chmod +x run.sh
./run.sh
```

---

## 10) Processi (solo l’essenziale)
- `ps aux` — lista processi
- `top` — monitor live (esci con `q`)
- `kill PID` — termina processo (gentile)
- `kill -9 PID` — termina forzato (ultima spiaggia)

---

## 11) SSH e copia file (remoto / cluster)
- `ssh utente@host` — entra sul server/cluster
- `exit` — esce dalla sessione SSH
- `scp file.txt utente@host:/percorso/` — copia **verso** remoto
- `scp utente@host:/percorso/out.txt .` — copia **dal** remoto (qui)

**Esempio**
```bash
ssh nomeutente@login.host
scp risultati.txt nomeutente@login.host:/home/nomeutente/progetto/output/
```

---
