python3 xpk/xpk.py cluster create \
  --cluster "${CLUSTER}" --tpu-type=v5p-32 \
  --num-slices=1 \
  --custom-cluster-arguments="${CLUSTER_ARGUMENTS}" \
  --custom-tpu-nodepool-arguments="${TPU_NODEPOOL_ARGUMENTS}" \
  --reservation="${RESERVATION_ID}"