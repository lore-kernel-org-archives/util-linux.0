Return-Path: util-linux-owner@vger.kernel.org
Received: from out03.mta.xmission.com ([166.70.13.233]:59684 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab3DUQSw convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 21 Apr 2013 12:18:52 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc: util-linux <util-linux@vger.kernel.org>,
        systemd-devel@lists.freedesktop.org
References: <20130420182319.GU3394@in.waw.pl> <87k3nwzvkt.fsf@xmission.com>
	<20130421144523.GW3394@in.waw.pl>
Date: Sun, 21 Apr 2013 09:18:34 -0700
In-Reply-To: <20130421144523.GW3394@in.waw.pl> ("Zbigniew
	\=\?utf-8\?Q\?J\=C4\=99drzejewski-Szmek\=22's\?\= message of "Sun, 21 Apr 2013
 16:45:23 +0200")
Message-ID: <87wqrvx3fp.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: nsenter and SIGSTOP
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl> writes:

> On Sat, Apr 20, 2013 at 03:27:46PM -0700, Eric W. Biederman wrote:
>> Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl> writes:
>> 
>> > Hi,
>> > I've hit a bit of a problem with nsenter and systemd-nspawn.
>> > When nsenter is used to enter the PID namespace created with
>> > systemd-nspawn, and the container's init attempts a shutdown,
>> > it hangs because nsenter is suspended.
>> >
>> > The sequence of events leading to the hang is:
>> >
>> > 1. nsenter launches a shell inside the container with
>> >    PPID=0 as seen inside the container,
>> > 2. systemd with PID=1 goes through the shutdown sequence,
>> >    issuing the equivalent(*) of
>> >
>> >    kill(-1, SIGSTOP)
>> 
>> This baffles me.  I am not certain why someone whould send SIGSTOP
>> when the want processes to exit.  I'm not even saying it's wrong just
>> saying that is odd.
> Like Lennart wrote, it's for atomicity of the subsequent killing.

When you don't do kill(-1, SIGTERM) that makes sense.
>
>> >    kill(-1, SIGTERM)
>> >    kill(_1, SIGCONT)
>> >    reboot(RB_HALT_SYSTEM)
>> >
>> > Now, nsenter has a stanza in continue_as_child where it stops itself
>> > when the child gets stopped. Unfortunately, this means that nsenter
>> > gets stopped in response to kill(-1, SIGSTOP) which hits the child.
>> > Then the child dies on kill(-1, SIGTERM), is resumed with kill(-1,
>> > SIGCONT) and exits (it prints "exit", so it's easy to see that it
>> > terminated properly. Then the shell becomes a zombie, since nsenter it
>> > it's parent and it's sleeping. Meanwhile, init executes reboot, and
>> > hangs in there, since the container waits for the PID namespace to
>> > become empty (I'm guessing here, but that seems logical).
>> 
>> I expect the hang is in the pid namespace init exiting.
>> in kernel/pid_namespace.x:zap_pid_ns_processes() has the baviour of
>> blocking until all children of init have been reaped that you describe.
>> 
>> > When then
>> > I type 'fg' to continue nsenter, the child gets collected and the
>> > container successfully exits.
>> >
>> > This is with kernel 3.9-rc6 from Fedora.
>> 
>> For nsenter and the pid namespace they are working as designed.  But
>> given this outcode it would be nice if we could get a SIGCONT when the
>> child wakes up again.
> I don't know how the kernel could know what is wanted. nsenter
> signalled itself, and the kernel had nothing to with that.

No.  However it is possible to get a notification when the child wakes
up, and even more when the child is killed (SIGCHLD).

The question is can those facilities be used without making the code
incomprehensible both to readers and to users of nsenter.

>> The current behavior supports being able to type suspend in your shell
>> in the namespace and able to work outside the namespace.
>> 
>> I can't think of a way off the top of my head to wake nsenter up when
>> it's child is woken up underneath it, but it sounds like that would be
>> nice to do.
>> 
>> For the short term I would recommend not typing "reboot & exit" instead
>> of "reboot" from a shell started with nsenter, and otherwise not leaving
>> processes with parents outside the pid namespace around.
> 'reboot & exit' would suffer from the same problem, just with a race.
> Even 'exec reboot' would, since the container shuts down quite quickly,
> and the 'reboot' process could get SIGSTOPped before exiting.

Well when this happens with ssh "reboot & exit" has a pretty good track
record of working.  'shutdown -r "now + 1 minute" &' might even be
better.

When you are interactive I don't imaginge going "doh!" and typing fg
is not going to be particularly hard either.

>> Of course that seding SIGSTOP before sending SIGTERM seems mighty fishy
>> as well.
> It's not entirely fishy, but I think that the implementation in
> systemd might require some revisiting. systemd currently stops (and
> resumes) all processes, even the ones which are exempt from killing.
> But it's independent of this problem, since systemd does not exempt
> the injected shell from killing.
>
> Whether nsenter should be "fixed" depends on the main purpose of
> nsenter.  If it's supposed to be used to launch arbitrary services,
> then it might be changed, if comfortable use of a shell is more
> important. I'll post a patch to remove the self-suspend, but I'm not
> really sure if it should be applied. Probably not.

Launching completely arbitrary services really isn't the main purposes.
Any time use setns to launch processes in a pid namespace the process
tree becomes multi-rooted which is not a good place to be.  So at the
very least everything you "launch" needs to be daemonized.

nsenter should remove the need to run sshd do in a container.

As I see it the main purpose of nsenter is to be a simple, easily
understood tool that let's you get inside of a container and do things.
It should be comfortable and useful to use as much as possible.

Which means it should be possible to use the "suspend" command in bash
possible.  There are folks for whom their workflow breaks when that
command does not work.

So I guess I am saying I would bias nsenter towards the interactive users
rather than scripted automation.

> For systemd-nspawn, we'll grow our own facility to enter the
> container, since we want to set the environment and find the container
> by name and in general integrate with systemd-nspawn. So there's
> little reason to modify nsenter for this purpose. 

Sounds reaasonable to me.  Just make certain multiple roots in the pid
namespace doing mess you up.

Eric
