Return-Path: util-linux-owner@vger.kernel.org
Received: from out01.mta.xmission.com ([166.70.13.231]:34961 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab3A1Civ convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Jan 2013 21:38:51 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: =?utf-8?Q?=C3=81ngel_Gonz=C3=A1lez?= <ingenit@zoho.com>
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
	<1358750287-17732-3-git-send-email-zbyszek@in.waw.pl>
	<20130125150210.GL27413@x2.net.home> <20130125163924.GT4278@in.waw.pl>
	<87pq0tjgx9.fsf@xmission.com> <51054B8E.2000205@zoho.com>
Date: Sun, 27 Jan 2013 18:38:36 -0800
In-Reply-To: <51054B8E.2000205@zoho.com> (=?utf-8?Q?=22=C3=81ngel_Gonz?=
 =?utf-8?Q?=C3=A1lez=22's?= message of "Sun,
	27 Jan 2013 16:45:18 +0100")
Message-ID: <874ni22frn.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 2/5] nsenter: add --all meaning all namespaces and cwd and root
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ángel González <ingenit@zoho.com> writes:

> Eric W. Biederman writes:
>> Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl> writes:
>>>>  Not sure if this is the right argument. From my point of view it's
>>>>  better to be explicit for such things, something like --all sounds
>>>>  like a magical blackbox where semantic depends on features implemented
>>>>  by kernel and nsenter(1). 
>> 
>> Which is the reason I did not implement --all in the first place,
>> although it is attractive.
>> 
>>> Hi,
>>>
>>> I'm was trying to document how a user should enter a namespace
>>> container created by systemd-nspawn. I would prefer not to have the
>>> user type 'nsenter -t $PID -muipn', but something simpler.
>> 
>> As I see it nsenter is the raw tool for when you need to get your
>> hands dirty.  lxc already has a more integrated version.  And
>> it isn't hard to define a simple wrapper such as:
>> 
>> cat > systemd-nsenter <<EOF
>> #!/bin/sh
>> PID=$1
>> shift
>> exec nsenter -t $PID --mount --ipc --pid --net --uts "$@"
>> EOF
>> 
>> If you need things to be slightly simpler and it isn't worth deriving
>> your own c wrapper.
>
> Except that when you are distributing such script (eg. an init-like
> script), your shell script will need to add code detecting which
> namespaces the kernel supports (and adding appropiate flags to nsenter)
> and checking if your nsenter version supports them or not.

Then what you want is --ignore-namespaces-if-not-supported-in-kernel.
That is a somewhat different problem than --all.

The --all patch attempts to do something like that and I suspect in the
corner case where the we have namespace files for that namespace but
no setns support in the kernel the logic in the --all patch will work.
However usually the failure will be you can't open /proc/$pid/ns/$file,
which was not handled.

> It's better to have --all to enter all namespaces that nsenter supports.
> If you want to, it could print a warning when using --all and nsenter
> knows about more namespaces than the kernel or if it detects that the
> kernel knows about more namespaces than itself.
> But having a --all to enter “as namespaces as possible” would be the
> right thing IMHO.

The argument for --all and this is an argument that only applies to
nsenter and not unshare is that usually things are more likely to do
what you expect if you share more namespaces with them.

The counter argument is that sharing fewer namespaces than expected
can easily invalidate your testing and introduce subtle bugs.

"nsenter -t $pid --all" is what I want most days, but I can't
convince myself that "nsenter -t $pid -muinpUrw" is worse (just a few
more characters) and it has the advantage that what has worked before
should work again.

Right now --all looks like a subtle trap waiting for users.  Even
--ignore-namespaces-if-not-supported-in-kernel looks like that to
a degree.

With nsenter if we don't ignore failures when something we need is
missing the failure is up there and in your face.  If we do ignore
failures we can easily run into cases where commands that we run
continue to work but on the wrong namespaces, causing all kinds of
things to fail.

Think about using: "nsneter -t $pid -p /bin/kill -KILL -1" to ask a
container to shutdown.  If we were to ignore the fact you can't enter
the pid namespace than the command would kill everything and the box
would go down.

That seems very scary.   So I don't like removing namespaces silently.

Having an --all that could mean everything nsenter supports this week
is better but you start getting shell scripts that work fine on new
distros but fail in horrible ways on old distro's with old versions of
nsenter.  That certainly is better but still a bit of a scary prospect.

Eric
