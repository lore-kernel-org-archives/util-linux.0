Return-Path: util-linux-owner@vger.kernel.org
Received: from mondschein.lichtvoll.de ([194.150.191.11]:42337 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756789AbbIVK32 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Sep 2015 06:29:28 -0400
Received: from merkaba.localnet (blackhole.teamix.net [194.150.191.251])
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 4B0DF1FFB
	for <util-linux@vger.kernel.org>; Tue, 22 Sep 2015 12:19:57 +0200 (CEST)
From: Martin Steigerwald <martin@lichtvoll.de>
To: util-linux@vger.kernel.org
Subject: chrt permission denied with kernel 4.3-rc2
Date: Tue, 22 Sep 2015 12:19:56 +0200
Message-ID: <1948574.mCKV7sP6Yb@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi!

with 4.3-rc2 kernel (self-compiled) I get:

merkaba:~> LANG=C chrt -r -p 5 $$
chrt: failed to set pid 3464's policy: Operation not permitted

called with root rights (either su shell or even a direct tty)

strace reports:

sched_setscheduler(3464, SCHED_RR, { 5 }) = -1 EPERM (Operation not permitted)


With 4.1 standard Debian kernel it works.


Any idea?

I know I can use setcap to check file capabilities. But I am not sure how to 
see the capabilities of a running process.

Is it /proc/$$/status?

On 4.3-rc2 kernel it tells me:

CapInh: 0000000000000000
CapPrm: 0000003fffffffff
CapEff: 0000003fffffffff
CapBnd: 0000003fffffffff
CapAmb: 0000000000000000

On 4.1 Debian kernel on a different machine it tells me:

CapInh: 0000000000000000
CapPrm: 0000003fffffffff
CapEff: 0000003fffffffff
CapBnd: 0000003fffffffff

(there is no CapAmb there)

as well, when logged in via SSH, yet chrt -r -p 5 $$ works there as well.

Is there a command displaying available capabilities of a process in clear 
text?



> xzgrep SCHED config-4.3.0-rc2-tp520.xz
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_SCHED_AUTOGROUP=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_HRTICK=y
CONFIG_NET_SCHED=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_SCHED_TRACER is not set


mango:~# grep SCHED /boot/config-4.1.0-2-amd64 
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_SCHED_AUTOGROUP=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_HRTICK=y
CONFIG_NET_SCHED=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_SCHED_TRACER is not set


Both Debian Sid systems use systemd 226-3.

Thanks,
-- 
Martin
