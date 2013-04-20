Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:45887 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550Ab3DTTJj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 20 Apr 2013 15:09:39 -0400
Date: Sat, 20 Apr 2013 20:23:19 +0200
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: util-linux <util-linux@vger.kernel.org>, ebiederm@xmission.com
Cc: systemd-devel@lists.freedesktop.org
Subject: nsenter and SIGSTOP
Message-ID: <20130420182319.GU3394@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130417155727.GE19116@tango.0pointer.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,
I've hit a bit of a problem with nsenter and systemd-nspawn.
When nsenter is used to enter the PID namespace created with
systemd-nspawn, and the container's init attempts a shutdown,
it hangs because nsenter is suspended.

The sequence of events leading to the hang is:

1. nsenter launches a shell inside the container with
   PPID=0 as seen inside the container,
2. systemd with PID=1 goes through the shutdown sequence,
   issuing the equivalent(*) of

   kill(-1, SIGSTOP)
   kill(-1, SIGTERM)
   kill(_1, SIGCONT)
   reboot(RB_HALT_SYSTEM)

Now, nsenter has a stanza in continue_as_child where it stops itself
when the child gets stopped. Unfortunately, this means that nsenter
gets stopped in response to kill(-1, SIGSTOP) which hits the child.
Then the child dies on kill(-1, SIGTERM), is resumed with kill(-1,
SIGCONT) and exits (it prints "exit", so it's easy to see that it
terminated properly. Then the shell becomes a zombie, since nsenter it
it's parent and it's sleeping. Meanwhile, init executes reboot, and
hangs in there, since the container waits for the PID namespace to
become empty (I'm guessing here, but that seems logical). When then
I type 'fg' to continue nsenter, the child gets collected and the
container successfully exits.

This is with kernel 3.9-rc6 from Fedora.

Thanks,
Zbyszek
