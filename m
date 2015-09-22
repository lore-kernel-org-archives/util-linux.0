Return-Path: util-linux-owner@vger.kernel.org
Received: from mondschein.lichtvoll.de ([194.150.191.11]:42778 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933220AbbIVMcQ convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Sep 2015 08:32:16 -0400
From: Martin Steigerwald <martin@lichtvoll.de>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>, linux-rt-users@vger.kernel.org
Subject: Re: chrt permission denied with kernel 4.3-rc2
Date: Tue, 22 Sep 2015 14:32:14 +0200
Message-ID: <1529840.Y79o7PkRCS@merkaba>
In-Reply-To: <CAG27Bk3=gCmdsekNc9ZXYz1h-gz0VfNpRz23zMvx7-RqM+Qqdg@mail.gmail.com>
References: <1948574.mCKV7sP6Yb@merkaba> <CAG27Bk3=gCmdsekNc9ZXYz1h-gz0VfNpRz23zMvx7-RqM+Qqdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Cc´ing rt-users mailinglist as some questions may exceed the scope of
util-linux mailinglist.

Am Dienstag, 22. September 2015, 12:07:10 CEST schrieb Sami Kerola:
> On 22 September 2015 at 11:19, Martin Steigerwald <martin@lichtvoll.de> wrote:
> > with 4.3-rc2 kernel (self-compiled) I get:
> > 
> > merkaba:~> LANG=C chrt -r -p 5 $$
> > chrt: failed to set pid 3464's policy: Operation not permitted
> > 
> > called with root rights (either su shell or even a direct tty)
> > 
> > strace reports:
> > 
> > sched_setscheduler(3464, SCHED_RR, { 5 }) = -1 EPERM (Operation not
> > permitted)
> > 
> > 
> > With 4.1 standard Debian kernel it works.
> > 
> > 
> > Any idea?
> > 
> > I know I can use setcap to check file capabilities. But I am not sure how
> > to see the capabilities of a running process.
> > 
> > Is it /proc/$$/status?
> > 
> > On 4.3-rc2 kernel it tells me:
> > 
> > CapInh: 0000000000000000
> > CapPrm: 0000003fffffffff
> > CapEff: 0000003fffffffff
> > CapBnd: 0000003fffffffff
> > CapAmb: 0000000000000000
> > 
> > On 4.1 Debian kernel on a different machine it tells me:
> > 
> > CapInh: 0000000000000000
> > CapPrm: 0000003fffffffff
> > CapEff: 0000003fffffffff
> > CapBnd: 0000003fffffffff
> > 
> > (there is no CapAmb there)
> > 
> > as well, when logged in via SSH, yet chrt -r -p 5 $$ works there as well.
> > 
> > Is there a command displaying available capabilities of a process in clear
> > text?
> > 
> >> xzgrep SCHED config-4.3.0-rc2-tp520.xz
> > 
> > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> > CONFIG_CGROUP_SCHED=y
> > CONFIG_FAIR_GROUP_SCHED=y
> > CONFIG_RT_GROUP_SCHED=y
> > CONFIG_SCHED_AUTOGROUP=y
> > CONFIG_IOSCHED_NOOP=y
> > CONFIG_IOSCHED_DEADLINE=y
> > CONFIG_IOSCHED_CFQ=y
> > CONFIG_CFQ_GROUP_IOSCHED=y
> > CONFIG_DEFAULT_IOSCHED="cfq"
> > CONFIG_SCHED_OMIT_FRAME_POINTER=y
> > CONFIG_SCHED_SMT=y
> > CONFIG_SCHED_MC=y
> > CONFIG_SCHED_HRTICK=y
> > CONFIG_NET_SCHED=y
> > CONFIG_USB_EHCI_TT_NEWSCHED=y
> > CONFIG_SCHED_DEBUG=y
> > CONFIG_SCHED_INFO=y
> > CONFIG_SCHEDSTATS=y
> > # CONFIG_SCHED_STACK_END_CHECK is not set
> > # CONFIG_SCHED_TRACER is not set
> > 
> > 
> > mango:~# grep SCHED /boot/config-4.1.0-2-amd64
> > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> > CONFIG_CGROUP_SCHED=y
> > CONFIG_FAIR_GROUP_SCHED=y
> > # CONFIG_RT_GROUP_SCHED is not set
> > CONFIG_SCHED_AUTOGROUP=y
> > CONFIG_IOSCHED_NOOP=y
> > CONFIG_IOSCHED_DEADLINE=y
> > CONFIG_IOSCHED_CFQ=y
> > CONFIG_CFQ_GROUP_IOSCHED=y
> > CONFIG_DEFAULT_IOSCHED="cfq"
> > CONFIG_SCHED_OMIT_FRAME_POINTER=y
> > CONFIG_SCHED_SMT=y
> > CONFIG_SCHED_MC=y
> > CONFIG_SCHED_HRTICK=y
> > CONFIG_NET_SCHED=y
> > CONFIG_USB_EHCI_TT_NEWSCHED=y
> > CONFIG_SCHED_DEBUG=y
> > # CONFIG_SCHEDSTATS is not set
> > # CONFIG_SCHED_STACK_END_CHECK is not set
> > # CONFIG_SCHED_TRACER is not set
> > 
> > 
> > Both Debian Sid systems use systemd 226-3.
> 
> Hi Martin,
> 
> You might be hitting branch CONFIG_RT_GROUP_SCHED enabled.
> 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/kernel/s
> ched/core.c#n3863
> 
> See also.
> 
> http://cateee.net/lkddb/web-lkddb/RT_GROUP_SCHED.html

I see.

Thanks, that was it. Detailed analysis below.


I was aware of the system wide settings that are meant to prevent
blocking a CPU completely:

merkaba:~> cat /proc/sys/kernel/sched_rt_period_us 
1000000
merkaba:~> cat /proc/sys/kernel/sched_rt_runtime_us 
950000


But yeah, kernel documentation also mentions this:

119 Realtime group scheduling means you have to assign a portion of total CPU
120 bandwidth to the group before it will accept realtime tasks. Therefore you will
121 not be able to run realtime tasks as any user other than root until you have
122 done that, even if the user has the rights to run processes with realtime
123 priority!

scheduler/sched-rt-group.txt

Still with the example "chrt -r -p 5 $$" in a root shell the bash process is
running as root.


Well lets see:

merkaba:/sys/fs/cgroup> find -name "*cpu.rt_runtime_us*"
./cpu,cpuacct/cpu.rt_runtime_us
./cpu,cpuacct/init.scope/cpu.rt_runtime_us
./cpu,cpuacct/system.slice/cpu.rt_runtime_us
./cpu,cpuacct/user.slice/user-1000.slice/cpu.rt_runtime_us
./cpu,cpuacct/user.slice/user-2012.slice/cpu.rt_runtime_us
./cpu,cpuacct/user.slice/cpu.rt_runtime_us
./cpu,cpuacct/user.slice/user-132.slice/cpu.rt_runtime_us



merkaba:/sys/fs/cgroup> cat cpuacct/user.slice/user-1000.slice/cpu.rt_runtime_us
0

merkaba:/sys/fs/cgroup> echo "950000" > cpuacct/user.slice/user-1000.slice/cpu.rt_runtime_us
echo: write error: invalid argument

merkaba:/sys/fs/cgroup> echo "950000" > cpu/user.slice/cpu.rt_runtime_us 
merkaba:/sys/fs/cgroup> echo "950000" > cpu/user.slice/user-1000.slice/cpu.rt_runtime_us

merkaba:/sys/fs/cgroup> LANG=C echo "950000" > cpu/user.slice/user-2012.slice/cpu.rt_runtime_us
echo: write error: invalid argument

Okay, probably cannot allocate more than the 950000 combined to each user then.

merkaba:/sys/fs/cgroup> echo "400000" > cpu/user.slice/user-1000.slice/cpu.rt_runtime_us   
merkaba:/sys/fs/cgroup> echo "400000" > cpu/user.slice/user-2012.slice/cpu.rt_runtime_us


merkaba:~> chrt -r -p 5 $$                                
merkaba:~>

So the RT accounting still thinks I am a user. Despite:

merkaba:~> ps u -p $$  
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      3464  0.0  0.0  44856  5944 pts/2    S    09:23   0:00 -su

merkaba:~> whoami                         
root

Is this a kernel bug or I am overseeing something here? Maybe its tied to the
session somehow? But then it also didn´t work as root shell started from
tty1. Well… if child processes are inheriting the same group despite the user
they run at, and if systemd created a new slice for root sessions as well…

but still, above documentation says the limit only applies to non root
processes.


Heck, I may just disable that feature again. A global option to prevent
complete lockup is enough for me.

It all started with me wanting to give PulseAudio real time prio in order to
get rid of the cracks in the audio on heavy GUI activity.

merkaba:~#1> ps u -C pulseaudio
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
martin    1283  0.1  0.0 573432 11996 ?        Sl   Sep21   1:36 /usr/bin/pulseaudio --start --log-target=syslog
ms       16888  0.8  0.0 433712 11400 ?        Sl   09:59   2:15 /usr/bin/pulseaudio --start --log-target=syslog

merkaba:~> chrt -afp 5 1283  
merkaba:~> chrt -afp 5 16888

Thanks,
-- 
Martin
