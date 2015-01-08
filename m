Return-Path: peter@cordes.ca
Date: Thu, 08 Jan 2015 14:26:35 -0400
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fallocate: create mode 0666, that's what umask is for
Message-id: <20150108182635.GV29504@cordes.ca>
References: <1419915737-27310-1-git-send-email-peter@cordes.ca>
 <20150107090354.GA15715@x2.net.home> <20150107224626.GS29504@cordes.ca>
 <20150108091302.GI15715@x2.net.home>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <20150108091302.GI15715@x2.net.home>
From: Peter Cordes <peter@cordes.ca>
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 08, 2015 at 10:13:02AM +0100, Karel Zak wrote:
> On Wed, Jan 07, 2015 at 06:46:26PM -0400, Peter Cordes wrote:
> >  Thanks for taking a look at my patches.  I haven't had any new ideas
> > for my fallocate --dig-holes patch.  My local copy does what I want it
> 
>  I didn't look at your second patch yet. I'd like to finalize stuff for 
>  v2.26-rc1 and it seems that with some invasive and large changes we
>  can wait for v2.27.

 Sure, no rush.  Agree it's not something that's ready to go in for a
release you're already finalizing.

  I only just subscribed to the mailing list to post my patches.
Thanks for the heads up on release-schedule issues, so I can stop
worrying that you missed it or something.  :)

  If anyone has any thoughts about the design, esp. from the point of
view of a different use-case for --dig-holes (like maybe for VM
images?), that would be useful.  I could maybe revise my patch and
have something closer to ready for inclusion into 2.27.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
