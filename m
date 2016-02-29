Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yk0-f169.google.com ([209.85.160.169]:32854 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcB2HM7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 29 Feb 2016 02:12:59 -0500
Received: by mail-yk0-f169.google.com with SMTP id z13so59155166ykd.0
        for <util-linux@vger.kernel.org>; Sun, 28 Feb 2016 23:12:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <m3a8mln0mq.fsf@gmail.com>
References: <CAOaMnuGfN1hnEn7H95c2TzxyQUoQ3c5PzikApHMPyPW123R9fQ@mail.gmail.com>
 <m3egbxn4uz.fsf@gmail.com> <m3a8mln0mq.fsf@gmail.com>
From: Akshay Adiga <akshay.adiga@gmail.com>
Date: Mon, 29 Feb 2016 12:42:39 +0530
Message-ID: <CAOaMnuHpXBQ=fNfXYBiC6SQi+Ym0V6x01tEgTckqY0oecNWoMw@mail.gmail.com>
Subject: Re: Separate taskset arguments from the command arguments
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Yuriy,

I am using  util-linux v2.27 and GLIBC v2.21 on ubuntu.

As you pointed out rightly, its the invalid logical cpu number, rather
than mis-parsed argument. I was confused because of the error message.

Thanks :)

On Sun, Feb 28, 2016 at 5:53 AM, Yuriy M. Kaminskiy <yumkam@gmail.com> wrote:
> yumkam@gmail.com (Yuriy M. Kaminskiy)
> writes:
>
>> Akshay Adiga <akshay.adiga@gmail.com>
>> writes:
>>
>>> I want to run a command which looks something like this :
>>>
>>> taskset -c 10 ycsb -p "redis_host=1234"
>>>
>>> The actual command is :
>>>
>>> ycsb -p "redis_host=1234"
>>>
>>> But argument -p "redis_host=1234" is taken by taskset as it argument
>>> and throws an error : Failed to set pid 0's affinity:
>>>
>>> -p "redis_host=1234" is an argument to ycsb command. shell/tasket
>>> misunderstands that and takes it as an argument for taskset.
>>>
>>> Is there a work around for this?
>>
>> Normally, such problem are solved by inserting `--` before your command;
>> however, taskset have somewhat unusual parsing of arguments (-c is not
>> an "option with argument", but the flag), so it will be
>>
>>   taskset -c -- 10 ycsb -p "redis_host=1234"
>
> Hmm... actually, on which util-linux and libc version this is on?
>
> This should work even without -- (and it works for me [on util-linux 2.25.2
> and glibc 2.19; and on util-linux git master branch too), note `getopt
> ... "+` in taskset.c and `man 3 getopt_long` on meaning (getopt should
> stop parsing on first non-option argument, in your case `ycsb`).
>
> And do your system have 10 cpu's/cores/whatever? Because if I specify cpu number
> larger than present, taskset gives exactly this error:
>
> $ taskset -c 100 echo -p foobar
> taskset: failed to set pid 0's affinity: Invalid argument
>
> This may be confused as "incorrect argument parsing", but it is not
> ("pid 0" is just means it tries to apply affinity to itself, it is not
> misparsed "foobar"); with existing cpu number everything works:
>
> $ taskset -c 1 echo -p foobar
> -p foobar
> $ taskset -c -- 1 echo -p foobar
> -p foobar
>
> (That said, taskset and chrt argument parsing is a bit unusual and may be confusing)
>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html-
