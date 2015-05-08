
# RabbitMQ Tutorials - Perl

Ports of the [RabbitMQ tutorials](https://github.com/rabbitmq/rabbitmq-tutorials) to Perl [Net::RabbitMQ](http://search.cpan.org/~jesus/Net--RabbitMQ-0.2.8/RabbitMQ.pm).


## Requirements

To successfully use the examples you will need a running RabbitMQ server. The scripts as written expect the RabbitMQ server to be on localhost, port 5672, guest/guest username/password. The [mheiges/vagrant-rabbitmq](http://github.com/mheiges/vagrant-rabbitmq) Vagrant VM is one source of a suitable RabbitMQ for these tutorials.

The Perl scripts use [Net::RabbitMQ](http://search.cpan.org/~jesus/Net--RabbitMQ-0.2.8/RabbitMQ.pm). I use  version 0.2.8 .

    curl -LO http://www.cpan.org/authors/id/J/JE/JESUS/Net--RabbitMQ-0.2.8.tar.gz
    tar zxf Net--RabbitMQ-0.2.8.tar.gz
    cd Net--RabbitMQ-0.2.8
    perl Makefile.PL
    make
    make install

## Code

[Tutorial one: "Hello World!"](http://www.rabbitmq.com/tutorial-one-python.html):

    perl send.pl
    perl receive.pl

[Tutorial two: Work Queues](http://www.rabbitmq.com/tutorial-two-python.html):

    perl new_task.pl "A very hard task which takes two seconds.."
    perl worker.pl

[Tutorial three: Publish/Subscribe:](http://www.rabbitmq.com/tutorials/tutorial-three-python.html)

    perl receive_logs.pl
    perl emit_log.pl "info: This is the log message"

[Tutorial four: Routing](http://www.rabbitmq.com/tutorial-four-python.html):

    perl receive_logs_direct.pl info
    perl emit_log_direct.pl info "The message"

[Tutorial five: Topics](http://www.rabbitmq.com/tutorial-five-python.html):

    perl receive_logs_topic.pl "*.rabbit"
    perl emit_log_topic.pl red.rabbit Hello

