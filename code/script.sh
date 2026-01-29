#!/usr/bin/env bash
set -euo pipefail

# ================== CONFIG (modifica SOLO qui) ==================
BASE_DIR="/home/lmb/prova_hpc"   # <-- percorso ASSOLUTO della cartella target
TOTAL_LINES=300                         # quante righe totali scrivere
DELAY_SECONDS=0                      # pausa tra le righe (0 per nessuna pausa)
# ===============================================================

if [[ "${BASE_DIR}" != /* ]]; then
  echo "Errore: BASE_DIR deve essere un percorso ASSOLUTO (iniziare con /)."
  exit 1
fi

LOG_DIR="${BASE_DIR%/}/log"
mkdir -p "${LOG_DIR}"

LOG1="${LOG_DIR}/log1.log"
LOG2="${LOG_DIR}/log2.log"
LOG3="${LOG_DIR}/log3.log"

: > "${LOG1}"
: > "${LOG2}"
: > "${LOG3}"

echo "Genero ${TOTAL_LINES} righe in:"
echo "  ${LOG1}"
echo "  ${LOG2}"
echo "  ${LOG3}"
echo "Livelli: INFO, DEBUG, SUCCESS, ERROR, CRITICAL"
echo "Interrompi con Ctrl+C"

cleanup() {
  echo
  echo "Interrotto. Log disponibili in: ${LOG_DIR}"
}
trap cleanup INT TERM

levels=(INFO DEBUG SUCCESS ERROR CRITICAL)

pick_level() {
  # Distribuzione semplice: molti INFO/DEBUG, meno ERROR, rarissimi CRITICAL
  r=$((RANDOM % 100))
  if   (( r < 45 )); then echo "INFO"
  elif (( r < 75 )); then echo "DEBUG"
  elif (( r < 90 )); then echo "SUCCESS"
  elif (( r < 98 )); then echo "ERROR"
  else                    echo "CRITICAL"
  fi
}

for ((i=1; i<=TOTAL_LINES; i++)); do
  ts="$(date '+%Y-%m-%d %H:%M:%S')"
  level="$(pick_level)"
  val=$((RANDOM % 1000))

  case "${level}" in
    INFO)     event="heartbeat" ;;
    DEBUG)    event="trace_step" ;;
    SUCCESS)  event="job_completed" ;;
    ERROR)    event="io_error" ;;
    CRITICAL) event="node_failure" ;;
  esac

  msg="[$ts] livello=${level} iter=${i} pid=$$ evento=${event} valore=${val}"

  # Round-robin sui 3 file
  case $((i % 3)) in
    1) echo "${msg}" >> "${LOG1}" ;;
    2) echo "${msg}" >> "${LOG2}" ;;
    0) echo "${msg}" >> "${LOG3}" ;;
  esac

  if [[ "${DELAY_SECONDS}" != "0" && "${DELAY_SECONDS}" != "0.0" && "${DELAY_SECONDS}" != "0.00" ]]; then
    sleep "${DELAY_SECONDS}"
  fi
done

echo "Fatto. Log generati in: ${LOG_DIR}"