#!/usr/bin/env perl

# Perl Net::RabbitMQ port of receive_logs_direct.py from vendor tutorials.
# https://github.com/rabbitmq/rabbitmq-tutorials/blob/master/python/receive_logs_direct.py
#
# This script can receive messages from emit_logs_direct.pl and from emit_logs_direct.py .

use strict;
use Net::RabbitMQ;

my $host = 'localhost';
my $channel_id = 1;
my $exchange_name = 'direct_logs';

my $mq = Net::RabbitMQ->new() ;

$mq->connect($host, {});

$mq->channel_open($channel_id);

# Net::RabbitMQ defaults to auto_delete 1. Python's pika defaults to False. To
# match the exchange created in receive_logs.py, we need to disable auto_delete.
$mq->exchange_declare($channel_id, $exchange_name, {exchange => $exchange_name, exchange_type => 'direct', auto_delete => 0});

my $queue_name = $mq->queue_declare($channel_id, '', { exclusive => 1 });

my @severities = @ARGV;
if ( scalar @severities == 0) {
  print STDERR "Usage: $0 [info] [warning] [error]";
  exit 1;
}

for my $routing_key (@severities) {
  $mq->queue_bind($channel_id, $queue_name, $exchange_name, $routing_key);
}

$mq->consume($channel_id, $queue_name, {consumer_tag => "worker_$$", no_ack => 0, exclusive => 0,});

print " [*] Waiting for logs. To exit press CTRL+C\n";

while ( my $payload = $mq->recv() ) {
    last if not defined $payload ;
    my $message  = $payload->{'body'};
    my $severity = $payload->{'routing_key'};
    print " [x] '$severity':'$message'\n";
}

$mq->disconnect;