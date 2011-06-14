Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45980 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109Ab1FNOiK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Jun 2011 10:38:10 -0400
Date: Tue, 14 Jun 2011 16:38:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] uuidgen: print warning if uuidd isn't running
Message-ID: <20110614143805.GJ14293@nb.net.home>
References: <1307540101-6376-1-git-send-email-ludwig.nussel@suse.de> <20110614114534.GF14293@nb.net.home> <20110614115125.GG14293@nb.net.home> <201106141406.10364.ludwig.nussel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201106141406.10364.ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 14, 2011 at 02:06:10PM +0200, Ludwig Nussel wrote:
> Karel Zak wrote:
> > On Tue, Jun 14, 2011 at 01:45:34PM +0200, Karel Zak wrote:
> > > On Wed, Jun 08, 2011 at 03:35:01PM +0200, Ludwig Nussel wrote:
> > > > ---
> > > >  misc-utils/uuidgen.c |    4 +++-
> > > >  1 files changed, 3 insertions(+), 1 deletions(-)
> > > > 
> > > > diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
> > > > index 3cf6ec9..47f8e8f 100644
> > > > --- a/misc-utils/uuidgen.c
> > > > +++ b/misc-utils/uuidgen.c
> > > > @@ -59,7 +59,9 @@ main (int argc, char *argv[])
> > > >  
> > > >  	switch (do_type) {
> > > >  	case DO_TYPE_TIME:
> > > > -		uuid_generate_time(uu);
> > > > +		if (uuid_generate_time_safe(uu)) {
> > > > +			fprintf(stderr, _("Warning: uuidd not running or not operational. Time based uuid may not be unique.\n"));
> > > 
> > > IMHO this is overkill -- the uuidd is used very rarely (usually on
> > > large systems with SAP) and it's disabled by default in many
> > > distributions, but the uuidgen(1) util is available everywhere and
> > > used probably often used by admins/scripts.
> 
> That's the problem exactly. uuidgen seems to work for them at first
> until lots of uuids within a short time are required. It's a mean
> trap.
> 
> > > It would be better to add some WARNING section to the uuidgen(1) man
> > > page to inform users about the disadvantage.
> 
> Well, who reads docu if uuidgen -t appears to work?
> 
> >  ... we can also add a new option (e.g. --safe) to use 
> >  uuid_generate_time_safe().
> 
> ... or make -t fail if it's not safe and add a --unsafe option. That
> would be the fail-safe approach :-)

 OK. What about --force rather than --unsafe?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
