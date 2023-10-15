#!/bin/bash
kubectl port-forward --address 0.0.0.0 -n prometheus svc/prometheus-grafana 3001:80 1>/dev/null 2>/dev/null &
kubectl port-forward --address 0.0.0.0 -n prometheus svc/prometheus-kube-prometheus-prometheus 9090:9090 1>/dev/null 2>/dev/null &
kubectl port-forward --address 0.0.0.0 -n prometheus svc/prometheus-pushgateway 9091:9091 1>/dev/null 2>/dev/null &
#kubectl port-forward --address 0.0.0.0 -n prometheus svc/prometheus-kube-state-metrics 8080:8080 1>/dev/null 2>/dev/null &