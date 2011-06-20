Return-Path: ludwig.nussel@suse.de
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] uuidgen: fail if uuidd isn't running
Date: Mon, 20 Jun 2011 14:18:36 +0200
Cc: Karel Zak <kzak@redhat.com>, "Ted Ts'o" <tytso@mit.edu>
References: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de> <20110617020756.GB29725@thunk.org> <20110620104548.GC17967@nb.net.home>
In-Reply-To: <20110620104548.GC17967@nb.net.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106201418.36364.ludwig.nussel@suse.de>
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Thu, Jun 16, 2011 at 10:07:56PM -0400, Ted Ts'o wrote:
> > On Thu, Jun 16, 2011 at 03:59:36PM +0200, Ludwig Nussel wrote:
> > > time bases uuids are not safe if uuidd is not running.
> > > Add option --force to generate a uuid in this case nevertheless.
> >
> > I really wouldn't worry about time-based uuid if you're grabbing them
> > from uuidgen.  Yes, if you're generating thousands of uuid's in
> > parallel via the C interface, it's possible that you potentially force
> > a collision.  But via the command-line interface of uuidgen?
>=20
>  I agree with Ted.=20
>=20
>  Let's go one step back (sorry Ludwig). It would be really better to
>  add --safe rather than --force. We can use the --safe option to test
>  the new *_safe functions or for really paranoid environments, but we
>  should not force people use the new functionality.

Actually never mind, forget about the patches. I'm perfectly fine
with a 'no'. This discussion now finally documents in public the
background and reasons why things are the way they are. Thanks a lot
for your patience and Ted for the detailed explanation!

cu
Ludwig

=2D-=20
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffe=
r, HRB 16746 (AG N=FCrnberg)=20
