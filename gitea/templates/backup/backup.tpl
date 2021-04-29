{{/*
Create helm partial for gitea server
*/}}
{{- define "backup" }}
- name: {{ .Chart.Name }}-backup
  image: {{ .Values.images.backup }}
  imagePullPolicy: {{ .Values.images.imagePullPolicy }}
  env:
    - name: AWS_ACCESS_KEY_ID
      value: {{ .Values.backups.s3AccessKey }}
    - name: AWS_SECRET_ACCESS_KEY
      value: {{ .Values.backups.s3AccessSecret }}
    - name: S3_BUCKET
      value: {{ .Values.backups.s3Bucket }}
    - name: S3_REGION
      value: {{ .Values.backups.s3Region }}
    - name: S3_ENDPOINT
      value: {{ .Values.backups.s3Endpoint }}
    - name: S3_S3V4
      value: {{ .Values.backups.s3v4 | quote }}
    - name: S3_PREFIX
      value: {{ .Values.backups.s3Prefix | quote }}
    - name: S3_ENCRYPT
      value: {{ .Values.backups.s3Encrypt | quote }}
    - name: SCHEDULE
      value: {{ .Values.backups.schedule }}
    - name: SKIP_LOG
      value: "true"
  resources:
{{ toYaml .Values.resources.backup | indent 4 }}
  volumeMounts:
    - name: gitea-data
      mountPath: /data
{{- end }}
