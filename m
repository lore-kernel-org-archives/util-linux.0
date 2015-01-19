Return-Path: util-linux-owner@vger.kernel.org
Received: from mta04.eastlink.ca ([24.224.136.10]:64888 "EHLO
	mta04.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbbASU6H (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 19 Jan 2015 15:58:07 -0500
Received: from cmgw04.eastlink.ca ([71.7.199.170])
 by mta04.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NIF00B2FJYDM2L0@mta04.eastlink.ca> for
 util-linux@vger.kernel.org; Mon, 19 Jan 2015 16:58:05 -0400 (AST)
Date: Mon, 19 Jan 2015 16:58:05 -0400
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] docs: fix grammar and punctuation of 2.26 release notes
Message-id: <20150119205805.GX29504@cordes.ca>
References: <1421348945-2329-1-git-send-email-bensberg@justemail.net>
 <20150116031559.GW29504@cordes.ca>
 <1421517403.2403892.215153577.6B12EB93@webmail.messagingengine.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <1421517403.2403892.215153577.6B12EB93@webmail.messagingengine.com>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 17, 2015 at 06:56:43PM +0100, Benno Schulenberg wrote:
> 
> On Fri, Jan 16, 2015, at 04:15, Peter Cordes wrote:
> > > + The new version no longer supports some obscure MBR-specific command-line
> > >   options and legacy CHS addressing.
> > 
> >  s/and/or/ in the last line.  "no longer supports x or y" is the proper
> > usage here.
> 
> Hmm.   I would tend to use "nor" here.  It may not be grammatical or
> proper usage, but I think it is the most clear.  ("No longer foo or bar"
> works fine, but "no longer foo-foo-baz-foo-baz or bar" is unclear to me --
> the negation has been mostly forgotten when the eye arrives at "or bar".
> The "nor" is then a nice reminder.)

 You're right, nor might actually be more proper.  And agree on using
it to avoid ambiguity.

> 
> > > +   -o for mount(8); it's now possible to specify swap options on the command
> > > +   line by the same string as in fstab
> > 
> >  I think "with the same string", rather than "by the same string".
> 
> Well, "is specified by" gives me many more google hits than "is specified with".

 "Is specified by <name of standard / person / organization>" is common usage.
 "Is specified with <how you specify it>" is a strange usage that I'm
not sure is correct.  What I am pretty sure about is that "by" isn't
correct usage for the 2nd case.  If we were writing a book, I'd
probably think of a way to reword the whole sentence.

 Perhaps "using the same string as in fstab"?  I think that sounds
less clunky than either "by" or "with".

> This comparison may not be valid, but I think "by" is okay here.  And even if
> most native speakers would prefer "with" here, I think it's fine to let some of
> the foreignness of Karel's tongue sound through in his text.

 I agree that the meaning is still clear, so it doesn't really need a
change.

>  
> > > +The debug infrastructure in the libraries libmount, libsmartcolsm, libfdisk and
> > > +libblkid allows to specify debug options by human-readable strings too. For
> > >  example "LIBMOUNT_DEBUG=all mount /mnt".
> > 
> > "libblkid allows specifying debug options with human-readable strings, too. For"
> > 
> >  would read a bit better.
> 
> To a native speaker probably yes.

 Definitely, not just probably.  The meaning is totally clear, but I
don't think any native speaker would have used "by" instead of "with"
or "as".

>  But I'm trying to make the minimum
> amount of changes, fixing just the things where my comprehension is
> hindered.

 Fair enough.  I didn't think it would be a problem to make more
changes around lines you're already changing anyway, but if there's a
downside, it can stay.

>  There's no need to make this text into "English English";
> "understandable and acceptable foreigner English" seems good enough.

 Yup, "acceptable foreigner English" is a good description of a lot of
free software docs.  I agree it's not worth the time to try to get
global open-source projects up to the level a book editor would be
happy with.  It just caught my interest, so I took the time, and
probably found some changes just for the sake of changing something.


> Thanks for the review.
> Shall I add a Reviewed-by tag to V2?  Or an Acked-by?

 Either would be cool.  I'm not too familiar with the usual practices
for tagging git commits, so whichever you think is most appropriate
would be appreciated.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
