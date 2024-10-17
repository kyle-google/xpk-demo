cd maxtext

TS=`date +'%s' | cut -c4-`

python3 ../xpk/xpk.py workload create \
--workload xpk-jax-info-"${TS}"  \
--cluster "${CLUSTER}" \
--base-docker-image maxtext_base_image \
--workload "kyle-maxtext-demo-training-${TS}" \
--tpu-type="${TPU_TYPE}"   \
--num-slices=1 \
--command "python3 MaxText/train.py \
        MaxText/configs/base.yml \
        dataset_type=synthetic \
        enable_checkpointing=false \
        steps=50"
echo XPK JOB SUBMITTED!
cd ..