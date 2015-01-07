Return-Path: util-linux-owner@vger.kernel.org
Received: from mta04.eastlink.ca ([24.224.136.10]:38680 "EHLO
	mta04.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbbAGWq1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 7 Jan 2015 17:46:27 -0500
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta04.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NHT000X0V1U2B92@mta04.eastlink.ca> for
 util-linux@vger.kernel.org; Wed, 07 Jan 2015 18:46:26 -0400 (AST)
Received: from peter by llama.cordes.ca with local (Exim 3.36 #1 (Debian))
	id 1Y8zMw-00083B-00	for <util-linux@vger.kernel.org>; Wed,
 07 Jan 2015 18:46:26 -0400
Date: Wed, 07 Jan 2015 18:46:26 -0400
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] fallocate: create mode 0666, that's what umask is for
Message-id: <20150107224626.GS29504@cordes.ca>
References: <1419915737-27310-1-git-send-email-peter@cordes.ca>
 <20150107090354.GA15715@x2.net.home>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <20150107090354.GA15715@x2.net.home>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 07, 2015 at 10:03:54AM +0100, Karel Zak wrote:
> On Tue, Dec 30, 2014 at 01:02:17AM -0400, Peter Cordes wrote:
> > diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
> > index 0e06524b8c5837a63230dc047233c657c50c1d7c..9af3bb8ce1492defda57cc17764197790bb34c8e 100644
> > --- a/sys-utils/fallocate.c
> > +++ b/sys-utils/fallocate.c
> > @@ -365,7 +365,7 @@ int main(int argc, char **argv)
> >  
> >  	/* O_CREAT makes sense only for the default fallocate(2) behavior
> >  	 * when mode is no specified and new space is allocated */
> > -	fd = open(filename, O_RDWR | (!dig && !mode ? O_CREAT : 0), 0644);
> > +	fd = open(filename, O_RDWR | (!dig && !mode ? O_CREAT : 0), 0666);
> 
>  Applied, but I have replaced the number with 
> 
>     S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH
> 
>  macros to keep the code more readable.

 0666 is more readable, to me.  With the macros, I have to stop and
look to see what each one is, and figure out if any bits are left out.
If you were testing one bit in a given permission set, using a macro
would probably be more readable, but 0666 says "everything but execute"
in a lot less time than it takes to mentally OR 6 macros together.

 Maybe I'm weird for normally using numerical args to chmod, rather
than chmod +x, and most people don't chmod 755 often?

 Obviously it's your call in the end, as maintainer, and either way
doesn't make a big difference, since it compiles identically.

 Thanks for taking a look at my patches.  I haven't had any new ideas
for my fallocate --dig-holes patch.  My local copy does what I want it
to, and I haven't thought of anything else I really want.  All it
needs is probably just cleaning up what's printed at various -v
levels, and maybe a hole-size option.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
