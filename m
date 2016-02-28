Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:33065 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992461AbcB1AXv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 27 Feb 2016 19:23:51 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aZp9J-0000PK-Tj
	for util-linux@vger.kernel.org; Sun, 28 Feb 2016 01:23:49 +0100
Received: from ppp37-190-56-21.pppoe.spdop.ru ([37.190.56.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sun, 28 Feb 2016 01:23:49 +0100
Received: from yumkam by ppp37-190-56-21.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sun, 28 Feb 2016 01:23:49 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: Separate taskset arguments from the command arguments
Date: Sun, 28 Feb 2016 03:23:41 +0300
Message-ID: <m3a8mln0mq.fsf@gmail.com>
References: <CAOaMnuGfN1hnEn7H95c2TzxyQUoQ3c5PzikApHMPyPW123R9fQ@mail.gmail.com>
	<m3egbxn4uz.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

yumkam@gmail.com (Yuriy M. Kaminskiy)
writes:

> Akshay Adiga <akshay.adiga@gmail.com>
> writes:
>
>> I want to run a command which looks something like this :
>>
>> taskset -c 10 ycsb -p "redis_host=1234"
>>
>> The actual command is :
>>
>> ycsb -p "redis_host=1234"
>>
>> But argument -p "redis_host=1234" is taken by taskset as it argument
>> and throws an error : Failed to set pid 0's affinity:
>>
>> -p "redis_host=1234" is an argument to ycsb command. shell/tasket
>> misunderstands that and takes it as an argument for taskset.
>>
>> Is there a work around for this?
>
> Normally, such problem are solved by inserting `--` before your command;
> however, taskset have somewhat unusual parsing of arguments (-c is not
> an "option with argument", but the flag), so it will be
>
>   taskset -c -- 10 ycsb -p "redis_host=1234"

Hmm... actually, on which util-linux and libc version this is on?

This should work even without -- (and it works for me [on util-linux 2.25.2
and glibc 2.19; and on util-linux git master branch too), note `getopt
... "+` in taskset.c and `man 3 getopt_long` on meaning (getopt should
stop parsing on first non-option argument, in your case `ycsb`).

And do your system have 10 cpu's/cores/whatever? Because if I specify cpu number
larger than present, taskset gives exactly this error:

$ taskset -c 100 echo -p foobar
taskset: failed to set pid 0's affinity: Invalid argument

This may be confused as "incorrect argument parsing", but it is not
("pid 0" is just means it tries to apply affinity to itself, it is not
misparsed "foobar"); with existing cpu number everything works:

$ taskset -c 1 echo -p foobar
-p foobar
$ taskset -c -- 1 echo -p foobar
-p foobar

(That said, taskset and chrt argument parsing is a bit unusual and may be confusing)

