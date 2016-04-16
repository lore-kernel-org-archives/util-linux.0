Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34938 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbcDPVmx convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Apr 2016 17:42:53 -0400
Received: by mail-wm0-f45.google.com with SMTP id a140so73111918wma.0
        for <util-linux@vger.kernel.org>; Sat, 16 Apr 2016 14:42:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5712ACB2.7090103@bernhard-voelker.de>
References: <1460827912-19521-1-git-send-email-nsoffer@redhat.com>
	<5712ACB2.7090103@bernhard-voelker.de>
Date: Sun, 17 Apr 2016 00:42:51 +0300
Message-ID: <CAMRbyyvheOFY=2uRHDCwEHwNzBN4r2DsyLAKEiXJj_PZQkttdg@mail.gmail.com>
Subject: Re: [PATCH] Fail like the shell when execvp fails
From: Nir Soffer <nsoffer@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Nir Soffer <nirsof@gmail.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 17, 2016 at 12:20 AM, Bernhard Voelker
<mail@bernhard-voelker.de> wrote:
> On 04/16/2016 07:31 PM, Nir Soffer wrote:
>> For example, running the fuser command via taskset when fuser command is
>> not installed is failing now like this:
>>
>>     $ taskset -c 1 fuser /path/to/file; echo $?
>>     taskset: failed to execute fuser: No such file or directory
>>     1
>>
>> This failure looks like a real failure of the fuser command:
>>
>>     $ taskset -c 1 fuser /path/to/file; echo $?
>>     Specified filename /path/to/file does not exist.
>>     1
>>
>> Based on the exit code, a management program may do the wrong thing,
>> leading to catastrophic results. Detecting such failure requires fragile
>> parsing of standard error.
>>
>> With this patch this failure is easy to detect:
>>
>>     $ taskset -c 1 fuser /path/to/file; echo $?
>>     taskset: failed to execute fuser: No such file or directory
>>     127
>
> TBH I don't like this idea; how would you see from the exit code
> that 'taskset' itself wasn't the culprit?  I mean execve()ing
> taskset worked, but that tool simply wasn't lucky to execve() the
> secondary tool, well.

So taskset will exit with 127, which is not an error code you expect from the
underlying tool?

> So EXIT_FAILURE is the right thing to do IMO,
> and it is like that in almost any other - also non-util-linux tools
> (chroot, nice, ...).

Good examples:

$ nice -n 5 bleep 1; echo $?
nice: bleep: No such file or directory
127

$ sudo chroot /tmp bleep 1; echo $?
chroot: failed to run command ‘bleep’: No such file or directory
127

This is the behavior I suggest to adapt.

> Therefore, I don't see much gain from changing
> this here - not to mention the probable fallout for tools/script
> relying on the previous EXIT_FAILURE.

Tools cannot depend on EXIT_FAILURE from command like taskset, since
they are interested in the underlying tool exit code.

For example, if a tool is depending on EXIT_FAILURE exit code from taskset
while running fuser command, this tool is broken, ignoring the possible
EXIT_FAILURE from fuser - which has very specific semantics.

> Can you reference any general discussion about this?

No

>
> Have a nice day,
> Berny

Cheers,
Nir
