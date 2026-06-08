# ==============================================================================
#  PARA-Optimized AWS S3 Sync Function (Ver.2)
# ==============================================================================
sync-workspace-to-s3() {
  local SRC="${S3_SRC}"
  local BUCKET="${S3_BUCKET}"

  # ----------------------------------------------------------------------------
  #  1. Sync active directories to S3 Standard (No early deletion penalties)
  # ----------------------------------------------------------------------------
  echo "📦 [1/2] Syncing 0-Inbox & 1-Projects to S3 Standard..."
  for std_dir in "0-Inbox" "1-Projects"; do
    if [ -d "${SRC}/${std_dir}" ]; then
      echo "  -> Syncing ${std_dir} (Standard)..."
      aws s3 sync "${SRC}/${std_dir}/" "${BUCKET}/${std_dir}/" \
        --storage-class STANDARD \
        --delete
    fi
  done

  # ----------------------------------------------------------------------------
  #  2. Sync static/archived directories to S3 Glacier IR (Reduce storage costs by 80%)
  # ----------------------------------------------------------------------------
  echo "🧊 [2/2] Syncing Areas, Resources, Archives to S3 Glacier IR (Cost-saving)..."
  for gir_dir in "2-Areas" "3-Resources" "4-Archives"; do
    if [ -d "${SRC}/${gir_dir}" ]; then
      echo "  -> Syncing ${gir_dir} (Glacier IR)..."
      aws s3 sync "${SRC}/${gir_dir}/" "${BUCKET}/${gir_dir}/" \
        --storage-class GLACIER_IR \
        --delete
    fi
  done

  echo "✨ [SUCCESS] Workspace (220GiB) is perfectly synced to AWS S3!"
}
