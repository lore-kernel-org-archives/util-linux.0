Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162821AbeBPSIZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 16 Feb 2018 13:08:25 -0500
Date: Fri, 16 Feb 2018 19:08:20 +0100
From: Karel Zak <kzak@redhat.com>
To: Peter Cordes <peter@cordes.ca>
Cc: Theodore Ts'o <tytso@mit.edu>, util-linux@vger.kernel.org,
        Hornseth_Brenan@bah.com
Subject: Re: [PATCH] fsck: use xasprintf to avoid buffer overruns with an
 insane fs type
Message-ID: <20180216180820.ay7plq2du5xjwqms@ws.net.home>
References: <20180215200508.1466-1-tytso@mit.edu>
 <20180216155505.GL9479@cordes.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180216155505.GL9479@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:55:05AM -0400, Peter Cordes wrote:
> On Thu, Feb 15, 2018 at 03:05:08PM -0500, Theodore Ts'o wrote:
> > This prevents a crash when running the command:
> > 
> > fsck -t AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA /dev/sda
> > 
> > Reported-by: Hornseth_Brenan@bah.com
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> >  disk-utils/fsck.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
> > index 58fd8ac59..8a07bc272 100644
> > --- a/disk-utils/fsck.c
> > +++ b/disk-utils/fsck.c
> > @@ -544,20 +544,20 @@ static char *find_fsck(const char *type)
> >  {
> >  	char *s;
> >  	const char *tpl;
> > -	static char prog[256];
> > +	static char *prog = NULL;
> 
>  You're allocating / freeing every time it's used, so it shouldn't be
> static anymore.

Ah, I miss the "static". Thanks.

> It might be easier to just use snprintf to truncate long strings,
> instead of introducing dynamic allocation which requires explicit
> freeing.  OTOH xasprintf makes it re-entrant / thread-safe, at the
> cost of forcing the caller to care about memory management.  (And at
> the cost of efficiency: prog is allocated / freed inside the loop.)

Well, I don't think dynamic allocation so big issue in this case, but
I'll try to improve it on Monday to make the code more elegant.

Maybe all we need is to check -t argument and reject non-senses
already in main() ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
