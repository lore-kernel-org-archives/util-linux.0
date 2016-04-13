Return-Path: rworkman@slackware.com
Date: Tue, 12 Apr 2016 19:33:08 -0700 (PDT)
From: Robby Workman <rworkman@slackware.com>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: v2.29 plan: kill mtab
In-Reply-To: <20160411205934.blmh2xx3bgxw4vwm@ws.net.home>
Message-ID: <alpine.LNX.2.02.1604121931070.16273@connie.slackware.com>
References: <alpine.LNX.2.02.1604071350320.22605@connie.slackware.com> <20160411205934.blmh2xx3bgxw4vwm@ws.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <util-linux.vger.kernel.org>

On Mon, 11 Apr 2016, Karel Zak wrote:

> On Sun, Apr 10, 2016 at 09:35:41PM -0700, Robby Workman wrote:
>> Karel Zak wrote:
>>
>>> libmount supports three scenarios:
>>>
>>> 1) regular classic /etc/mtab
>>>
>>> 2) /etc/mtab symlink to /proc/self/mount -- in this case libmount uses
>>>    /proc/self/mountinfo and /run/mount/utab
>>>
>>> The current default is to detect symlink and on-the-fly switch
>>> between 1) and 2).
>>>
>>> 3) --enable-libmount-force-mountinfo -- don't care about the symlink
>>>    and always use /proc/self/mountinfo. This is robust solution required
>>>    for example by systemd, because unfortunately sometimes people use
>>>    broken stuff (init scripts, tools, etc.) which removes the symlink.
>>>
>>>
>>> I'd like to make 3) default, the question is what with mtab code:
>>>
>>>    a) #ifdef all mtab code (and add --enable-libmount-support-mtab)
>>>
>>>    b) remove mtab support at all (because it's evil and horrible code)
>>>
>>> Comments?
>>
>>
>> We still use SysV init because it suits our needs just fine, and we
>> have no plans to migrate to systemd in the foreseeable future, so
>> we don't have any other compelling reason to use anything other than
>> classic /etc/mtab. As such, we'd certainly appreciate, at the very
>> least, leaving the mtab support in util-linux.
>
> This discussion is really not about init, but about mtab that is
> broken by design.


Okay, then how about this? Our current use of /etc/mtab works well
for us, and as far as I'm aware, we've experienced absolutely
none of this "[breakage] by design" - as such, we'd be grealy
appreciative if the option remains to continue using it.

-RW
