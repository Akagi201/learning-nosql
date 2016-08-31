#!/bin/sh

redis-sentinel redis.sentinel.conf

sleep 1

redis-server redis.sentinel.8000.conf

sleep 1

redis-server redis.sentinel.8001.conf
