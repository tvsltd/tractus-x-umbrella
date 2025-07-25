---
################################################################################
# Copyright (c) 2021,2024 Contributors to the Eclipse Foundation
#
# See the NOTICE file(s) distributed with this work for additional
# information regarding copyright ownership.
#
# This program and the accompanying materials are made available under the
# terms of the Apache License, Version 2.0 which is available at
# https://www.apache.org/licenses/LICENSE-2.0.
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
# SPDX-License-Identifier: Apache-2.0
################################################################################

{{- define "bpdm-common.configMap.tpl" -}}
{{- $ := .context -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{include "bpdm.fullname" $}}
  labels:
    {{- include "bpdm.labels" $ | nindent 4 }}
data:
  deployment.yml: |-
{{- if .override }}
{{- .override | toYaml | nindent 4}}
{{- end}}
{{- end -}}

{{- define "bpdm-common.configMap" -}}
{{- $ := .context -}}
{{- $defaultTemplate := .defaultValues | default "bpdm-common.empty"  -}}
{{- $defaultValues := fromYaml (include $defaultTemplate $) | default (dict )  -}}
{{- $override := .context.Values.applicationConfig | default (dict ) -}}
{{- $finalValues := mergeOverwrite $defaultValues $override -}}
{{- include "bpdm-common.configMap.tpl" (dict "context" $ "override" $finalValues) -}}
{{- end -}}