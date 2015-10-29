Return-Path: lennart@poettering.net
Date: Thu, 29 Oct 2015 15:36:16 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Olaf Hering <olaf@aepfle.de>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: regression in logger output to syslog
Message-ID: <20151029143615.GA27684@gardel-login>
References: <20151009082541.GA9068@aepfle.de>
 <20151012104414.GF2356@ws.net.home>
 <20151012133451.GA6825@aepfle.de>
 <20151021093743.GA6552@aepfle.de>
 <20151029103532.GC19508@ws.net.home>
 <20151029142021.GA9487@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151029142021.GA9487@aepfle.de>
List-ID: <util-linux.vger.kernel.org>

On Thu, 29.10.15 15:20, Olaf Hering (olaf@aepfle.de) wrote:

> On Thu, Oct 29, Karel Zak wrote:
> 
> > On Wed, Oct 21, 2015 at 11:37:43AM +0200, Olaf Hering wrote:
> > > On Mon, Oct 12, Olaf Hering wrote:
> > > 
> > > > So, its "systemd" who eats the required info.
> > > 
> > > In case you miss it:
> > > 
> > > ...
> > > We do not allow faking syslog PID fields, for security reasons, it
> > > will always be set to what the kernel passed to journald.
> > > 
> > > If this is something to support, then "logger" needs to to be patched so
> > > that it can fake the SCM_CREDENTIALS metadata of the messages sent.
> > > This requires privileges, but is not hard to do. Please file a bug
> > > against util-linux and ask for for this to be added.
> > 
> >  Implemented, try logger(1) from util-linux git tree, please. 
> 
> Not sure what the "We" above refers to, but this change from 27a9eb5
> may still not work for me:
> 
> +                   && geteuid() == 0 && kill(ctl->pid, 0) == 0) {
> 
> For me its required to run logger as non-root and still get the
> specified number, like it used to do it years ago.

Sorry, but this is something we are unlikely to support in
systemd. Allowing unprivileged processes to fake arbitrary UIDs is
a security problem, and it's really nothing we should provide support
for.

Sorry,

Lennart

-- 
Lennart Poettering, Red Hat
