Return-Path: util-linux-owner@vger.kernel.org
Received: from out01.mta.xmission.com ([166.70.13.231]:53398 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab3DUWHc convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 21 Apr 2013 18:07:32 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc: util-linux <util-linux@vger.kernel.org>,
        systemd-devel@lists.freedesktop.org
References: <20130420182319.GU3394@in.waw.pl> <87k3nwzvkt.fsf@xmission.com>
	<20130421144523.GW3394@in.waw.pl> <87wqrvx3fp.fsf@xmission.com>
	<20130421193331.GX3394@in.waw.pl>
Date: Sun, 21 Apr 2013 15:07:18 -0700
In-Reply-To: <20130421193331.GX3394@in.waw.pl> ("Zbigniew
	\=\?utf-8\?Q\?J\=C4\=99drzejewski-Szmek\=22's\?\= message of "Sun, 21 Apr 2013
 21:33:31 +0200")
Message-ID: <87txmzv8q1.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: nsenter and SIGSTOP
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl> writes:

> On Sun, Apr 21, 2013 at 09:18:34AM -0700, Eric W. Biederman wrote:
>> Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl> writes:
>> 
>> > On Sat, Apr 20, 2013 at 03:27:46PM -0700, Eric W. Biederman wrote:
>> >> Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl> writes:
>> >> 
>> >> > Hi,
>> >> > I've hit a bit of a problem with nsenter and systemd-nspawn.
>> >> > When nsenter is used to enter the PID namespace created with
>> >> > systemd-nspawn, and the container's init attempts a shutdown,
>> >> > it hangs because nsenter is suspended.
>> >> >
>> >> > The sequence of events leading to the hang is:
>> >> >
>> >> > 1. nsenter launches a shell inside the container with
>> >> >    PPID=0 as seen inside the container,
>> >> > 2. systemd with PID=1 goes through the shutdown sequence,
>> >> >    issuing the equivalent(*) of
>> >> >
>> >> >    kill(-1, SIGSTOP)
>> >> 
>> >> This baffles me.  I am not certain why someone whould send SIGSTOP
>> >> when the want processes to exit.  I'm not even saying it's wrong just
>> >> saying that is odd.
>> > Like Lennart wrote, it's for atomicity of the subsequent killing.
>> 
>> When you don't do kill(-1, SIGTERM) that makes sense.
> Because not all processes are killed: during normal shutdown processes
> with argv[0] beginning with @ are spared
> (http://www.freedesktop.org/wiki/Software/systemd/RootStorageDaemons).

I wasn't arguing.  But since you bring up root storage daemons and
initial ram disks, I don't believe any of those actually apply to a
container.

My point was only that using SIGSTOP makes sense when it becomes clear
that kill(-1, SIGTERM) is not happening.

>> No.  However it is possible to get a notification when the child wakes
>> up, and even more when the child is killed (SIGCHLD).
> Right, but that doesn't help at all, since nsenter is sleeping. It'll
> get the notification, when it wakes up, but there's nothing to wake it
> up.

I believe you could make it all work with a poll based on a periodic
wake up.  If you don't send yourself SIGSTOP I don't believe the outer
shell will recognize what has happened, but you should be able to wake
yourself up with a timer and see verify you child is still stopped.

>> Well when this happens with ssh "reboot & exit" has a pretty good track
>> record of working.  'shutdown -r "now + 1 minute" &' might even be
>> better.
>> 
>> When you are interactive I don't imaginge going "doh!" and typing fg
>> is not going to be particularly hard either.
> We're trying to get things to work without kludges like sleeping or 
> manual prodding. For debugging that's fine, but people use systemd-nspawn
> containers for services, and expect them to "just work".

Like I said below nsenter is about interactive/debugging case.  More
sysadmin debugging than application debugging but I guess that makes
it debugging.

Essentially that was the point of implementing setns for the pid
namespace.  So you exceptional cases could be handled without having to
got to the expense of having to depend on a functioning login daemon in
the container.

>> So I guess I am saying I would bias nsenter towards the interactive users
>> rather than scripted automation.
> Agreed.
>
>> > For systemd-nspawn, we'll grow our own facility to enter the
>> > container, since we want to set the environment and find the container
>> > by name and in general integrate with systemd-nspawn. So there's
>> > little reason to modify nsenter for this purpose. 
>> 
>> Sounds reaasonable to me.  Just make certain multiple roots in the pid
>> namespace doing mess you up.
> Yeah, multiple roots with unkillable zombie processes surely are enough
> to make people confused. I'm still trying to wrap my head around PID
> and mount namespaces, and I know that user namespaces add another level
> of fun :).

Well this isn't a case of unkillable zombies.  This is a case of
processes not being reaped.  And a weird process that doesn't fully die
until all of it's children are dead (similar to the leader of a thread
group).  Now honestly I would not be adverse in theory to handling this
weird corrner case better in zap_pid_ns_processes.  Right now
zap_pid_ns_processes is the best so far.

For launching new services in a container simply sending a message to
the init process is probably what you want.  I think those messages
already traverse unix domain sockets so it insn't too shabby.

Eric

