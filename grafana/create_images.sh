#!/bin/bash
# ARTWORK
# This script assumes that You have cncf/artwork cloned in ~/dev/cncf/artwork 
. ./devel/all_projs.sh || exit 2
for proj in $all
do
  if [ "$proj" = "opencontainers" ]
  then
    continue
  fi
  suff=$proj
  icon=$proj
  if [ "$suff" = "kubernetes" ]
  then
    suff="k8s"
  fi
  if [ "$icon" = "all" ]
  then
    icon="cncf"
  fi
  # TODO: remove when we have icons
  if ( [ "$icon" = "istio" ] || [ "$icon" = "spinnaker" ] || [ "$icon" = "knative" ] )
  then
    icon="cncf"
  fi
  icontype=`./devel/get_icon_type.sh "$proj"` || exit 1
  path=$icon
  if [ "$path" = "devstats" ]
  then
    path="other/$icon"
  fi
  cp "$HOME/dev/cncf/artwork/$path/icon/$icontype/$icon-icon-$icontype.svg" "grafana/img/$suff.svg" || exit 2
  convert "$HOME/dev/cncf/artwork/$path/icon/$icontype/$icon-icon-$icontype.png" -resize 32x32 "grafana/img/${suff}32.png" || exit 3
done

# Special OCI case (not a CNCF project)
if [[ $all = *"opencontainers"* ]]
then
  cp images/OCI.svg grafana/img/opencontainers.svg || exit 4
  convert images/OCI.png -resize 32x32 grafana/img/opencontainers32.png || exit 5
fi
echo 'OK'
