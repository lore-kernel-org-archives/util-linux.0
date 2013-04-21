Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:45929 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753674Ab3DUOp2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 21 Apr 2013 10:45:28 -0400
Date: Sun, 21 Apr 2013 16:45:23 +0200
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        systemd-devel@lists.freedesktop.org
Subject: Re: nsenter and SIGSTOP
Message-ID: <20130421144523.GW3394@in.waw.pl>
References: <20130420182319.GU3394@in.waw.pl>
 <87k3nwzvkt.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87k3nwzvkt.fsf@xmission.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Apr 20, 2013 at 03:27:46PM -0700, Eric W. Biederman wrote:
> Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl> writes:
> 
> > Hi,
> > I've hit a bit of a problem with nsenter and systemd-nspawn.
> > When nsenter is used to enter the PID namespace created with
> > systemd-nspawn, and the container's init attempts a shutdown,
> > it hangs because nsenter is suspended.
> >
> > The sequence of events leading to the hang is:
> >
> > 1. nsenter launches a shell inside the container with
> >    PPID=0 as seen inside the container,
> > 2. systemd with PID=1 goes through the shutdown sequence,
> >    issuing the equivalent(*) of
> >
> >    kill(-1, SIGSTOP)
> 
> This baffles me.  I am not certain why someone whould send SIGSTOP
> when the want processes to exit.  I'm not even saying it's wrong just
> saying that is odd.
Like Lennart wrote, it's for atomicity of the subsequent killing.

> >    kill(-1, SIGTERM)
> >    kill(_1, SIGCONT)
> >    reboot(RB_HALT_SYSTEM)
> >
> > Now, nsenter has a stanza in continue_as_child where it stops itself
> > when the child gets stopped. Unfortunately, this means that nsenter
> > gets stopped in response to kill(-1, SIGSTOP) which hits the child.
> > Then the child dies on kill(-1, SIGTERM), is resumed with kill(-1,
> > SIGCONT) and exits (it prints "exit", so it's easy to see that it
> > terminated properly. Then the shell becomes a zombie, since nsenter it
> > it's parent and it's sleeping. Meanwhile, init executes reboot, and
> > hangs in there, since the container waits for the PID namespace to
> > become empty (I'm guessing here, but that seems logical).
> 
> I expect the hang is in the pid namespace init exiting.
> in kernel/pid_namespace.x:zap_pid_ns_processes() has the baviour of
> blocking until all children of init have been reaped that you describe.
> 
> > When then
> > I type 'fg' to continue nsenter, the child gets collected and the
> > container successfully exits.
> >
> > This is with kernel 3.9-rc6 from Fedora.
> 
> For nsenter and the pid namespace they are working as designed.  But
> given this outcode it would be nice if we could get a SIGCONT when the
> child wakes up again.
I don't know how the kernel could know what is wanted. nsenter
signalled itself, and the kernel had nothing to with that.

> The current behavior supports being able to type suspend in your shell
> in the namespace and able to work outside the namespace.
> 
> I can't think of a way off the top of my head to wake nsenter up when
> it's child is woken up underneath it, but it sounds like that would be
> nice to do.
> 
> For the short term I would recommend not typing "reboot & exit" instead
> of "reboot" from a shell started with nsenter, and otherwise not leaving
> processes with parents outside the pid namespace around.
'reboot & exit' would suffer from the same problem, just with a race.
Even 'exec reboot' would, since the container shuts down quite quickly,
and the 'reboot' process could get SIGSTOPped before exiting.

> Of course that seding SIGSTOP before sending SIGTERM seems mighty fishy
> as well.
It's not entirely fishy, but I think that the implementation in
systemd might require some revisiting. systemd currently stops (and
resumes) all processes, even the ones which are exempt from killing.
But it's independent of this problem, since systemd does not exempt
the injected shell from killing.

Whether nsenter should be "fixed" depends on the main purpose of
nsenter.  If it's supposed to be used to launch arbitrary services,
then it might be changed, if comfortable use of a shell is more
important. I'll post a patch to remove the self-suspend, but I'm not
really sure if it should be applied. Probably not.

For systemd-nspawn, we'll grow our own facility to enter the
container, since we want to set the environment and find the container
by name and in general integrate with systemd-nspawn. So there's
little reason to modify nsenter for this purpose. 

Zbyszek
