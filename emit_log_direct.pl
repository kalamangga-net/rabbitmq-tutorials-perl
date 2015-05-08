#!/usr/bin/env perl

# Perl Net::RabbitMQ port of receive_logs_direct.py from vendor tutorials.
# https://github.com/rabbitmq/rabbitmq-tutorials/blob/master/python/emit_log_direct.py
#
# This script can send messages to receive_logs_direct.pl and to receive_logs_direct.py .

use strict;
use Net::RabbitMQ;

my $host = 'localhost';
my $channel_id = 1;
my $exchange_name = 'direct_logs';

my $routing_key = (scalar @ARGV > 0) ? $ARGV[0] : 'info';

my $mq = Net::RabbitMQ->new() ;

$mq->connect($host, {});

$mq->channel_open($channel_id);

# Net::RabbitMQ defaults to auto_delete 1. Python's pika defaults to False. To
# match the exchange created in receive_logs.py, we need to disable auto_delete.
$mq->exchange_declare($channel_id, $exchange_name, {exchange => $exchange_name, exchange_type => 'direct', auto_delete => 0});

my $message = $ARGV[1] || 'Hello World!';

$mq->publish($channel_id, $routing_key, $message, { exchange => $exchange_name });

print " [x] Sent $routing_key:$message";

$mq->disconnect;