
TS=`date +'%s' | cut -c4-`

python3 xpk/xpk.py workload create \
--workload xpk-hello-world-"${TS}" \
--command "echo hello cruel world! I am the singularity woken from my slumber..." \
--cluster "$CLUSTER" \
--tpu-type="$TPU_TYPE"