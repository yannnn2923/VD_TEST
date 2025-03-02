{{/*
Common labels
*/}}
{{- define "mon-chart.labels" -}}
helm.sh/chart: {{ .Chart.Name }}
{{ include "mon-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mon-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name }}-vda
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
