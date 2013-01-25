Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:50372 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755627Ab3AYR7F (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jan 2013 12:59:05 -0500
Date: Fri, 25 Jan 2013 18:59:01 +0100
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/5] nsenter: add --all meaning all namespaces and cwd
 and root
Message-ID: <20130125175901.GX4278@in.waw.pl>
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
 <1358750287-17732-3-git-send-email-zbyszek@in.waw.pl>
 <20130125150210.GL27413@x2.net.home>
 <20130125163924.GT4278@in.waw.pl>
 <87pq0tjgx9.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87pq0tjgx9.fsf@xmission.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 25, 2013 at 09:44:50AM -0800, Eric W. Biederman wrote:
> Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl> writes:
> 
> > On Fri, Jan 25, 2013 at 04:02:10PM +0100, Karel Zak wrote:
> >> On Mon, Jan 21, 2013 at 01:38:02AM -0500, Zbigniew Jędrzejewski-Szmek wrote:
> >> > I guess that most of the time one will want to enter all
> >> > namespaces, and then it is easier not to have to remember
> >> > all the option names.
> >> 
> >>  Not sure if this is the right argument. From my point of view it's
> >>  better to be explicit for such things, something like --all sounds
> >>  like a magical blackbox where semantic depends on features implemented
> >>  by kernel and nsenter(1). 
> 
> Which is the reason I did not implement --all in the first place,
> although it is attractive.
> 
> > Hi,
> >
> > I'm was trying to document how a user should enter a namespace
> > container created by systemd-nspawn. I would prefer not to have the
> > user type 'nsenter -t $PID -muipn', but something simpler.
> 
> As I see it nsenter is the raw tool for when you need to get your
> hands dirty.  lxc already has a more integrated version.  And
> it isn't hard to define a simple wrapper such as:
> 
> cat > systemd-nsenter <<EOF
> #!/bin/sh
> PID=$1
> shift
> exec nsenter -t $PID --mount --ipc --pid --net --uts "$@"
> EOF
> 
> If you need things to be slightly simpler and it isn't worth deriving
> your own c wrapper.
> 
> I assume you didn't include -U because systemd-nspawn doesn't create
> a user namespace?
Yes, systemd-nspawn so far doesn't.

> Of course at the point you wrap nsenter you probably want to have
> something that takes a name and looks at a pid file I expect.
> 
> > What about an alternative patch, which implements --all which means:
> > "all namespaces supported by the kernel" (i.e. iterate over /proc/$PID/ns/*'
> > and enter all of them. This way the behaviour would depend only on the
> > kernel options, not on util-linux version.
> 
> If we add another namespace will it have oddball semantics to worry
> about?  So far the mount namespace, the user namespace, and the pid
> namespace do.  So judging from history you have a 50/50 chance of
> needing special code in nsenter.  I don't expect blinding iterarting
> over /proc/[pid]/ns/* will remove the need for future changes to
> nsenter if and when we add another namespace.
OK, so that's not an option.

> What will keep from breaking peoples scripts is to not have an option
> that is ambiguous.
Well, in the two patches I was careful to write "enter all of the
above namespaces", to underline the fact that the kernel might know
about some additional ones.

OK, bear with me. What about --all meaning "enter all of the
namespaces that nsenter has support for, and fail if there's a
namespace diffent between target and requesting process that
nsenter doesn't know about"?

In scripts one could say 'nsenter -<wanted namespaces>', but for quick'n'dirty
commandline use, nsenter --all would work.

Zbyszek

