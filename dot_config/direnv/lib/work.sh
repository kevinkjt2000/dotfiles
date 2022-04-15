#!/usr/bin/env bash

kinit_login() {
	if has klist && ! klist --test; then
		kinit
	fi
}

oc_supports_gssapi() {
	has oc && oc version | grep GSSAPI > /dev/null 2>&1
}

oc_is_logged_in() {
	has oc && oc_supports_gssapi && oc whoami > /dev/null 2>&1
}

openshift_login() {
	if ! oc_is_logged_in; then
		oc login "$@"
	fi
}

openshift_get_secret_json() {
	local secret_name=$1
	printf "%s" "$(oc get secret -o json "$secret_name")"
}

openshift_get_individual_secret_from_json() {
	local json=$1
	local secret_json_path=".data.$2"
	if has jq && oc_is_logged_in; then
		printf "%s" "$json" | jq -r "$secret_json_path" | base64 --decode
	fi
}
