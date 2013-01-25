Return-Path: util-linux-owner@vger.kernel.org
Received: from out02.mta.xmission.com ([166.70.13.232]:57239 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084Ab3AYRpA convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 Jan 2013 12:45:00 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
	<1358750287-17732-3-git-send-email-zbyszek@in.waw.pl>
	<20130125150210.GL27413@x2.net.home> <20130125163924.GT4278@in.waw.pl>
Date: Fri, 25 Jan 2013 09:44:50 -0800
In-Reply-To: <20130125163924.GT4278@in.waw.pl> ("Zbigniew
	\=\?utf-8\?Q\?J\=C4\=99drzejewski-Szmek\=22's\?\= message of "Fri, 25 Jan 2013
 17:39:24 +0100")
Message-ID: <87pq0tjgx9.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 2/5] nsenter: add --all meaning all namespaces and cwd and root
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl> writes:

> On Fri, Jan 25, 2013 at 04:02:10PM +0100, Karel Zak wrote:
>> On Mon, Jan 21, 2013 at 01:38:02AM -0500, Zbigniew Jędrzejewski-Szmek wrote:
>> > I guess that most of the time one will want to enter all
>> > namespaces, and then it is easier not to have to remember
>> > all the option names.
>> 
>>  Not sure if this is the right argument. From my point of view it's
>>  better to be explicit for such things, something like --all sounds
>>  like a magical blackbox where semantic depends on features implemented
>>  by kernel and nsenter(1). 

Which is the reason I did not implement --all in the first place,
although it is attractive.

> Hi,
>
> I'm was trying to document how a user should enter a namespace
> container created by systemd-nspawn. I would prefer not to have the
> user type 'nsenter -t $PID -muipn', but something simpler.

As I see it nsenter is the raw tool for when you need to get your
hands dirty.  lxc already has a more integrated version.  And
it isn't hard to define a simple wrapper such as:

cat > systemd-nsenter <<EOF
#!/bin/sh
PID=$1
shift
exec nsenter -t $PID --mount --ipc --pid --net --uts "$@"
EOF

If you need things to be slightly simpler and it isn't worth deriving
your own c wrapper.

I assume you didn't include -U because systemd-nspawn doesn't create
a user namespace?

Of course at the point you wrap nsenter you probably want to have
something that takes a name and looks at a pid file I expect.

> What about an alternative patch, which implements --all which means:
> "all namespaces supported by the kernel" (i.e. iterate over /proc/$PID/ns/*'
> and enter all of them. This way the behaviour would depend only on the
> kernel options, not on util-linux version.

If we add another namespace will it have oddball semantics to worry
about?  So far the mount namespace, the user namespace, and the pid
namespace do.  So judging from history you have a 50/50 chance of
needing special code in nsenter.  I don't expect blinding iterarting
over /proc/[pid]/ns/* will remove the need for future changes to
nsenter if and when we add another namespace.

What will keep from breaking peoples scripts is to not have an option
that is ambiguous.

Eric
