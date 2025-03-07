#!/bin/bash

set -e

# build release binary
cargo build --release
# build docker image
docker build --tag aleph-node:latest -f ./docker/Dockerfile .

# run the chain and the tests in two separate tmux windows
tmux new-session -d -s aleph0 './.github/scripts/run_consensus.sh';  
tmux new-window -t "aleph0:1";
tmux send-keys -t "aleph0:1" './run_e2e.sh' Enter;

tmux a;                                       

exit $?
