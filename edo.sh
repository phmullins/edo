#!/usr/bin/env bash
# edo v0.0.1 - Easy Digital Ocean doctl Wrapper
# Copyright (c) 2016 Patrick H. Mullins (@phmullins). All rights reserved.

KEYCHAIN="secrets.keychain"

main () {
  if [[ -z $1 ]]; then
    print_usage
  fi

  case $1 in
    ls) list_droplets ;;
    info) get_droplet_info $2 ;;
    images) get_images ;;
    off) droplet_off $2 ;;
    on) droplet_on $2 ;;
    *) print_usage ;;
  esac
}

list_droplets() {
  doctl compute droplet list
}

get_droplet_info() {
  if [[ -z $1 ]]; then
    print_usage
  fi
  doctl compute droplet get $1
}

get_images() {
  doctl compute image list
}

droplet_off() {
  if [[ -z $1 ]]; then
    print_usage
  fi
  doctl compute droplet get $1
}

droplet_on() {
  if [[ -z $1 ]]; then
    print_usage
  fi
  doctl compute droplet get $1
}

delete_secret() {
  if [[ -z $1 ]]; then
    print_usage
  fi
  security delete-generic-password -a $USER -s $1 $KEYCHAIN
}

print_usage() {
  cat << EOF
edo v0.0.1 - Easy Digital Ocean doctl Wrapper
Copyright (c) 2016 Patrick H. Mullins (@phmullins). All rights reserved.

Usage:

  Droplet Information:

  - edo ls                List Droplets
  - edo info <droplet>    Display Droplet Information
  - edo images            Display a list of Images

  Power On/Off:

  - edo on <droplet>      Power on Droplet
  - edo off <droplet>     Power down Droplet

EOF
  exit 0
}

main "$@"
