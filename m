Return-Path: util-linux-owner@vger.kernel.org
Received: from mta01.eastlink.ca ([24.224.136.30]:45518 "EHLO
        mta01.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeBQA3R (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 16 Feb 2018 19:29:17 -0500
Received: from emgw01.eastlink.ca ([71.7.199.173])
 by mta01.eastlink.ca (Oracle Communications Messaging Server 7.0.5.37.0 64bit
 (built Jan 25 2016)) with ESMTP id <0P4900H41KRY1RC0@mta01.eastlink.ca> for
 util-linux@vger.kernel.org; Fri, 16 Feb 2018 20:29:15 -0400 (AST)
Date: Fri, 16 Feb 2018 20:29:15 -0400
To: Karel Zak <kzak@redhat.com>
Cc: Theodore Ts'o <tytso@mit.edu>, util-linux@vger.kernel.org,
        Hornseth_Brenan@bah.com
Subject: Re: [PATCH] fsck: use xasprintf to avoid buffer overruns with an
        insane fs type
Message-id: <20180217002915.GM9479@cordes.ca>
References: <20180215200508.1466-1-tytso@mit.edu>
 <20180216155505.GL9479@cordes.ca> <20180216180820.ay7plq2du5xjwqms@ws.net.home>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <20180216180820.ay7plq2du5xjwqms@ws.net.home>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 16, 2018 at 07:08:20PM +0100, Karel Zak wrote:
> On Fri, Feb 16, 2018 at 11:55:05AM -0400, Peter Cordes wrote:
> > On Thu, Feb 15, 2018 at 03:05:08PM -0500, Theodore Ts'o wrote:
> > > This prevents a crash when running the command:
> > > 
> > > fsck -t AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA /dev/sda
> > > 
> > > Reported-by: Hornseth_Brenan@bah.com
> > > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > > ---
> > >  disk-utils/fsck.c | 15 +++++++++------
> > >  1 file changed, 9 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
> > > index 58fd8ac59..8a07bc272 100644
> > > --- a/disk-utils/fsck.c
> > > +++ b/disk-utils/fsck.c
> > > @@ -544,20 +544,20 @@ static char *find_fsck(const char *type)
> > >  {
> > >  	char *s;
> > >  	const char *tpl;
> > > -	static char prog[256];
> > > +	static char *prog = NULL;
> > 
> >  You're allocating / freeing every time it's used, so it shouldn't be
> > static anymore.
> 
> Ah, I miss the "static". Thanks.
> 
> > It might be easier to just use snprintf to truncate long strings,
> > instead of introducing dynamic allocation which requires explicit
> > freeing.  OTOH xasprintf makes it re-entrant / thread-safe, at the
> > cost of forcing the caller to care about memory management.  (And at
> > the cost of efficiency: prog is allocated / freed inside the loop.)
> 
> Well, I don't think dynamic allocation so big issue in this case, but
> I'll try to improve it on Monday to make the code more elegant.
> 
> Maybe all we need is to check -t argument and reject non-senses
> already in main() ;-)

Ted makes a good point that xasprintf makes it easier to reason about
correctness, and that's probably the most important consideration for
FSCK.  This code hardly needs to be efficient, and malloc/free aren't
terrible especially in a single-threaded program.

OTOH, I was worried for a while about a possible memory leak until I
figured out that leaving the loop without freeing was intentional, and
it was returning that memory to the caller.  (Of course it does;
that's the whole point of the function; but still,  if() break; before
free() looked worrying.)

---

If your proposed check in main() is based on length, then static buffer
size should probably also be set in main, otherwise you have magic
constants in two places that have to match.

Maybe have main() pass in a pointer + size for find_fsck to write
into (using snprintf)?

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
