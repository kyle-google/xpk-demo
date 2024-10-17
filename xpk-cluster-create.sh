

##### STEP 1 #################
##### Cluster Networking #####
##############################

##### 1A #####################
# Create network for cluster.
##### 1A #####################

gcloud compute networks create "${NETWORK_NAME}" --mtu=8896 --bgp-routing-mode=regional --subnet-mode=custom

# Created [https://www.googleapis.com/compute/v1/projects/PROJECT/global/networks/PREFIX-privatenetwork].
# NAME                  SUBNET_MODE  BGP_ROUTING_MODE  IPV4_RANGE  GATEWAY_IPV4
# PREFIX-privatenetwork  CUSTOM       REGIONAL

# Instances on this network will not be reachable until firewall rules
# are created. As an example, you can allow all internal traffic between
# instances as well as SSH, RDP, and ICMP by running:

##### 1B #####################
# Create subnetwork for cluster.
##### 1B #####################

gcloud compute networks subnets create "${SUBNET_NAME}" --network="${NETWORK_NAME}" --range=10.10.0.0/18 --region="${REGION}"

# Created [https://www.googleapis.com/compute/v1/projects/PROJECT/regions/us-central2/subnetworks/PREFIX-privatesubnet].
# NAME                 REGION    NETWORK               RANGE         STACK_TYPE  IPV6_ACCESS_TYPE  INTERNAL_IPV6_PREFIX  EXTERNAL_IPV6_PREFIX
# PREFIX-privatesubnet  us-central2  PREFIX-privatenetwork  10.10.0.0/18  IPV4_ONLY

##### 1C #####################
# Create firewall rules for private network.
##### 1C #####################

gcloud compute firewall-rules create "${FIREWALL_RULE_NAME}" --network "${NETWORK_NAME}" --allow tcp,icmp,udp --project="${PROJECT}"

# Creating firewall...⠹Created [https://www.googleapis.com/compute/v1/projects/PROJECT/global/firewalls/PREFIX-privatefirewall].
# Creating firewall...done.
# NAME                   NETWORK               DIRECTION  PRIORITY  ALLOW         DENY  DISABLED
# PREFIX-privatefirewall  PREFIX-privatenetwork  INGRESS    1000      tcp,icmp,udp        False

##### 1D #####################
# Routers for network and region.
##### 1D #####################

gcloud compute routers create "${ROUTER_NAME}" \
  --project="${PROJECT}" \
  --network="${NETWORK_NAME}" \
  --region="${REGION}"

# Creating router [PREFIX-network]...done.
# NAME           REGION    NETWORK
# PREFIX-network  us-central2  PREFIX-privatenetwork

##### 1E #####################
# Router nats for the region
##### 1E #####################

gcloud compute routers nats create "${NAT_CONFIG}" \
  --router="${ROUTER_NAME}" \
  --region="${REGION}" \
  --auto-allocate-nat-external-ips \
  --nat-all-subnet-ip-ranges \
  --enable-logging

##### 1D #####################
# Routers for network and region.

##### STEP 2 ############################
##### Create your cluster with xpk. #####
#########################################

##### 2A #####################
# Export cluster and node pool arguments
##### 2A #####################



##### 2C #####################
# Confirm that variables are correctly set:
##### 2C #####################
echo python3 xpk/xpk.py cluster create \
  --cluster "${CLUSTER}" --tpu-type="${TPU_TYPE}" \
  --num-slices="${NUMSLICES}" \
  --custom-cluster-arguments="${CLUSTER_ARGUMENTS}" \
  --custom-tpu-nodepool-arguments="${TPU_NODEPOOL_ARGUMENTS}" \
  --reservation="${RESERVATION_ID}"


python3 xpk/xpk.py cluster create \
  --cluster "${CLUSTER}" --tpu-type="${TPU_TYPE}" \
  --num-slices="${NUMSLICES}" \
  --custom-cluster-arguments="${CLUSTER_ARGUMENTS}" \
  --custom-tpu-nodepool-arguments="${TPU_NODEPOOL_ARGUMENTS}" \
  --reservation="${RESERVATION_ID}"
