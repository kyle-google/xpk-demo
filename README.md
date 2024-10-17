# xpk-demo
A repo to demo xpk in with examples for the tpu/gpu academy.

## setup configuration

```
cp set-environment.sh.example set-environment.sh
```

Manually update the set-environment.sh file contents for your project / reservation


## xpk
In the root of the repo clone the xpk repository.
```
git clone https://github.com/AI-Hypercomputer/xpk.git
```

## maxtext

In the root of the repo clone the maxtext repository:

```
git clone git@github.com:AI-Hypercomputer/maxtext.git
```

And build the maxtext base image (requires docker):

```
cd maxtext
bash docker_build_dependency_image.sh
```

## Creating the cluster

```
source set-environment.sh
./00_xpk_cluster_create.sh
```

Assuming everything went okay you should see something like...

```
[XPK] [t=0.00, GKE Cluster CreateOrUpdate ConfigMap(s)] Completed 0/2, task ConfigMap CreateOrUpdate-kyle-xpk-maxtext-demo-resources-configmap still working, logfile /tmp/ConfigMap-CreateOrUpdate-kyle-xpk-maxtext-demo-resources-configmap-xju_sqy7
[XPK] [t=1.00, GKE Cluster CreateOrUpdate ConfigMap(s)] Completed 2/2
[XPK] GKE commands done! Resources are created.
[XPK] See your GKE Cluster here: https://console.cloud.google.com/kubernetes/clusters/details/us-east5/kyle-xpk-maxtext-demo/details?project=tpu-vm-431818
[XPK] Exiting XPK cleanly
```

Which means you are ready to run worklaods

## Running workloads

The examples are meant to be run in order from 01 -> 05, with an option to run 04_bad_llama (to show failure) before rescaling the cluster with 04_cluster_resize.
