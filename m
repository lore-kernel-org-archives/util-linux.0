Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59724 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752371AbbAQR4o (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 17 Jan 2015 12:56:44 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 43269204D1
	for <util-linux@vger.kernel.org>; Sat, 17 Jan 2015 12:56:44 -0500 (EST)
Message-Id: <1421517403.2403892.215153577.6B12EB93@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Peter Cordes <peter@cordes.ca>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] docs: fix grammar and punctuation of 2.26 release notes
Date: Sat, 17 Jan 2015 18:56:43 +0100
In-Reply-To: <20150116031559.GW29504@cordes.ca>
References: <1421348945-2329-1-git-send-email-bensberg@justemail.net>
 <20150116031559.GW29504@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Fri, Jan 16, 2015, at 04:15, Peter Cordes wrote:
> > + based on libfdisk. If your use cases depend on sfdisk(8) then it is strongly
> 
>  Should put a comma after "sfdisk(8)".

True.  Will be in V2.

> > + The new version no longer supports some obscure MBR-specific command-line
> >   options and legacy CHS addressing.
> 
>  s/and/or/ in the last line.  "no longer supports x or y" is the proper
> usage here.

Hmm.   I would tend to use "nor" here.  It may not be grammatical or
proper usage, but I think it is the most clear.  ("No longer foo or bar"
works fine, but "no longer foo-foo-baz-foo-baz or bar" is unclear to me --
the negation has been mostly forgotten when the eye arrives at "or bar".
The "nor" is then a nice reminder.)

> > + The command hwclock(8) does not automatically (re)calculate the drift factor on
> > + --systohc to avoid several problems (ntpd with '11 minute mode', for example),
> > + but the new command-line option --update-drift has to be explicitly used to
> > + force hwclock(8) to update /etc/adjtime.
> 
>  Can we just start the sentence "hwclock(8) ...", instead of "The
> command hwclock(8)"?  I don't think there's any ambiguity that you
> might actually be talking about the man page.

True.  But it's what Karel wrote, and it's fine, it works.

> >   - supports new options --reload to force already running agetty processes to
> > -   reprint /etc/issue file. 
> > +   reprint the /etc/issue file
> 
>  "reprint /etc/issue" would work, and be shorter.

Same comment as above.

> > - - supports sfdisk compatible scripts, it's possible to save your partitioning 
> > -   layout to text files and (re)use it in all fdisks.
> > + - supports sfdisk compatible scripts; it's possible to save your partitioning
> > +   layout to text files and (re)use it in all fdisks
> 
>  Kudos for good use of a semicolon.  I always like a good semicolon. :)

:)

> > + - supports new command-line option "-o <list>" with the same semantic as
> 
>  semantics, not semantic.

Right.  Will be in V2.

> > +   -o for mount(8); it's now possible to specify swap options on the command
> > +   line by the same string as in fstab
> 
>  I think "with the same string", rather than "by the same string".

Well, "is specified by" gives me many more google hits than "is specified with".
This comparison may not be valid, but I think "by" is okay here.  And even if
most native speakers would prefer "with" here, I think it's fine to let some of
the foreignness of Karel's tongue sound through in his text.
 
> > +The debug infrastructure in the libraries libmount, libsmartcolsm, libfdisk and
> > +libblkid allows to specify debug options by human-readable strings too. For
> >  example "LIBMOUNT_DEBUG=all mount /mnt".
> 
> "libblkid allows specifying debug options with human-readable strings, too. For"
> 
>  would read a bit better.

To a native speaker probably yes.  But I'm trying to make the minimum
amount of changes, fixing just the things where my comprehension is
hindered.  There's no need to make this text into "English English";
"understandable and acceptable foreigner English" seems good enough.

Thanks for the review.
Shall I add a Reviewed-by tag to V2?  Or an Acked-by?

Benno

-- 
http://www.fastmail.com - Does exactly what it says on the tin

