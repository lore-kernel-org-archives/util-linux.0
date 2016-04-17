Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.133]:50893 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbcDQJLk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Apr 2016 05:11:40 -0400
Subject: Re: [PATCH] Fail like the shell when execvp fails
To: Nir Soffer <nsoffer@redhat.com>
References: <1460827912-19521-1-git-send-email-nsoffer@redhat.com>
 <5712ACB2.7090103@bernhard-voelker.de>
 <CAMRbyyvheOFY=2uRHDCwEHwNzBN4r2DsyLAKEiXJj_PZQkttdg@mail.gmail.com>
 <CAMRbyyt5nAoMR8=8k0GRm-jijwxzTywA+hk65esxQqPkhTmabA@mail.gmail.com>
Cc: Nir Soffer <nirsof@gmail.com>, util-linux@vger.kernel.org
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <57135343.2080105@bernhard-voelker.de>
Date: Sun, 17 Apr 2016 11:11:31 +0200
MIME-Version: 1.0
In-Reply-To: <CAMRbyyt5nAoMR8=8k0GRm-jijwxzTywA+hk65esxQqPkhTmabA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/16/2016 11:53 PM, Nir Soffer wrote:
> On Sun, Apr 17, 2016 at 12:42 AM, Nir Soffer <nsoffer@redhat.com> wrote:
>> On Sun, Apr 17, 2016 at 12:20 AM, Bernhard Voelker
>> <mail@bernhard-voelker.de> wrote:
>>> On 04/16/2016 07:31 PM, Nir Soffer wrote:
>>>> For example, running the fuser command via taskset when fuser command is
>>>> not installed is failing now like this:
>>>>
>>>>     $ taskset -c 1 fuser /path/to/file; echo $?
>>>>     taskset: failed to execute fuser: No such file or directory
>>>>     1
>>>>
>>>> This failure looks like a real failure of the fuser command:
>>>>
>>>>     $ taskset -c 1 fuser /path/to/file; echo $?
>>>>     Specified filename /path/to/file does not exist.
>>>>     1
>>>>
>>>> Based on the exit code, a management program may do the wrong thing,
>>>> leading to catastrophic results. Detecting such failure requires fragile
>>>> parsing of standard error.
>>>>
>>>> With this patch this failure is easy to detect:
>>>>
>>>>     $ taskset -c 1 fuser /path/to/file; echo $?
>>>>     taskset: failed to execute fuser: No such file or directory
>>>>     127
>>>
>>> TBH I don't like this idea; how would you see from the exit code
>>> that 'taskset' itself wasn't the culprit?  I mean execve()ing
>>> taskset worked, but that tool simply wasn't lucky to execve() the
>>> secondary tool, well.
>>
>> So taskset will exit with 127, which is not an error code you expect from the
>> underlying tool?
>>
>>> So EXIT_FAILURE is the right thing to do IMO,
>>> and it is like that in almost any other - also non-util-linux tools
>>> (chroot, nice, ...).
>>
>> Good examples:
>>
>> $ nice -n 5 bleep 1; echo $?
>> nice: bleep: No such file or directory
>> 127
>>
>> $ sudo chroot /tmp bleep 1; echo $?
>> chroot: failed to run command ‘bleep’: No such file or directory
>> 127
>>
>> This is the behavior I suggest to adapt.
> 
> Looking in coreutils, it is using these exit codes:
> 
> /* Exit statuses for programs like 'env' that exec other programs.  */
> enum
> {
>   EXIT_TIMEDOUT = 124, /* Time expired before child completed.  */
>   EXIT_CANCELED = 125, /* Internal error prior to exec attempt.  */
>   EXIT_CANNOT_INVOKE = 126, /* Program located, but not usable.  */
>   EXIT_ENOENT = 127 /* Could not find program to exec.  */
> };
> 
> So we may adapt this behavior?

Good examples, indeed.  I really should've looked that up myself
before replying, sorry.  Thanks for correcting me.  So your patch
actually makes util-linux more consistent with other tools ...
which is good.

Have a nice day,
Berny
