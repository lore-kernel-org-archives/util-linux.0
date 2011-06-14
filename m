Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor.suse.de ([195.135.220.2]:44141 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755948Ab1FNMGM convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 14 Jun 2011 08:06:12 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 14DD98E8CC
	for <util-linux@vger.kernel.org>; Tue, 14 Jun 2011 14:06:11 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] uuidgen: print warning if uuidd isn't running
Date: Tue, 14 Jun 2011 14:06:10 +0200
References: <1307540101-6376-1-git-send-email-ludwig.nussel@suse.de> <20110614114534.GF14293@nb.net.home> <20110614115125.GG14293@nb.net.home>
In-Reply-To: <20110614115125.GG14293@nb.net.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106141406.10364.ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Tue, Jun 14, 2011 at 01:45:34PM +0200, Karel Zak wrote:
> > On Wed, Jun 08, 2011 at 03:35:01PM +0200, Ludwig Nussel wrote:
> > > ---
> > >  misc-utils/uuidgen.c |    4 +++-
> > >  1 files changed, 3 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
> > > index 3cf6ec9..47f8e8f 100644
> > > --- a/misc-utils/uuidgen.c
> > > +++ b/misc-utils/uuidgen.c
> > > @@ -59,7 +59,9 @@ main (int argc, char *argv[])
> > >  
> > >  	switch (do_type) {
> > >  	case DO_TYPE_TIME:
> > > -		uuid_generate_time(uu);
> > > +		if (uuid_generate_time_safe(uu)) {
> > > +			fprintf(stderr, _("Warning: uuidd not running or not operational. Time based uuid may not be unique.\n"));
> > 
> > IMHO this is overkill -- the uuidd is used very rarely (usually on
> > large systems with SAP) and it's disabled by default in many
> > distributions, but the uuidgen(1) util is available everywhere and
> > used probably often used by admins/scripts.

That's the problem exactly. uuidgen seems to work for them at first
until lots of uuids within a short time are required. It's a mean
trap.

> > It would be better to add some WARNING section to the uuidgen(1) man
> > page to inform users about the disadvantage.

Well, who reads docu if uuidgen -t appears to work?

>  ... we can also add a new option (e.g. --safe) to use 
>  uuid_generate_time_safe().

... or make -t fail if it's not safe and add a --unsafe option. That
would be the fail-safe approach :-)

cu
Ludwig

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
