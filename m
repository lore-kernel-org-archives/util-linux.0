Return-Path: zbyszek@in.waw.pl
Date: Fri, 25 Jan 2013 17:39:24 +0100
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 2/5] nsenter: add --all meaning all namespaces and cwd
 and root
Message-ID: <20130125163924.GT4278@in.waw.pl>
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
 <1358750287-17732-3-git-send-email-zbyszek@in.waw.pl>
 <20130125150210.GL27413@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130125150210.GL27413@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 25, 2013 at 04:02:10PM +0100, Karel Zak wrote:
> On Mon, Jan 21, 2013 at 01:38:02AM -0500, Zbigniew Jędrzejewski-Szmek wrote:
> > I guess that most of the time one will want to enter all
> > namespaces, and then it is easier not to have to remember
> > all the option names.
> 
>  Not sure if this is the right argument. From my point of view it's
>  better to be explicit for such things, something like --all sounds
>  like a magical blackbox where semantic depends on features implemented
>  by kernel and nsenter(1). 
Hi,

I'm was trying to document how a user should enter a namespace
container created by systemd-nspawn. I would prefer not to have the
user type 'nsenter -t $PID -muipn', but something simpler.

What about an alternative patch, which implements --all which means:
"all namespaces supported by the kernel" (i.e. iterate over /proc/$PID/ns/*'
and enter all of them. This way the behaviour would depend only on the
kernel options, not on util-linux version.

Zbyszek
