cd maxtext

TS=`date +'%s' | cut -c4-`

python3 ../xpk/xpk.py workload create \
--cluster "${CLUSTER}" \
--base-docker-image maxtext_base_image \
--workload "kyle-llama-13b-${TS}" \
--tpu-type="${TPU_TYPE}"   \
--num-slices=1 \
--command "python3 MaxText/train.py \
        MaxText/configs/base.yml \
        dataset_type=synthetic \
        enable_checkpointing=false \
        model_name=llama2-13b \
        steps=10"
echo XPK JOB SUBMITTED!
cd ..