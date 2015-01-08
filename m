Return-Path: util-linux-owner@vger.kernel.org
Received: from mta03.eastlink.ca ([24.224.136.9]:42533 "EHLO mta03.eastlink.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971AbbAHEFG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Jan 2015 23:05:06 -0500
Received: from cmgw04.eastlink.ca ([71.7.199.170])
 by mta03.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NHU009A1AJL9CW1@mta03.eastlink.ca> for
 util-linux@vger.kernel.org; Thu, 08 Jan 2015 00:05:05 -0400 (AST)
Received: from peter by llama.cordes.ca with local (Exim 3.36 #1 (Debian))
	id 1Y94LJ-0002i5-00	for <util-linux@vger.kernel.org>; Thu,
 08 Jan 2015 00:05:05 -0400
Date: Thu, 08 Jan 2015 00:05:05 -0400
To: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: questions on util-linux translation
Message-id: <20150108040504.GT29504@cordes.ca>
References: <CAO7R9g8opv3Z3aW73xJ-d3ZBwi5_f4td9Xeqk=QBUCqz13fGhw@mail.gmail.com>
 <1420490268.1408121.209893057.48A620D9@webmail.messagingengine.com>
 <CAO7R9g8aGM48RzU-ed-cYyAdUEPbX7B4QSsVTdLx90poPtKwhQ@mail.gmail.com>
 <1420577328.1786767.210387085.321E0759@webmail.messagingengine.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <1420577328.1786767.210387085.321E0759@webmail.messagingengine.com>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 06, 2015 at 09:48:48PM +0100, Benno Schulenberg wrote:
> 
> On Tue, Jan 6, 2015, at 11:34, Antonio Ceballos wrote:
> > 2. My first suggestion is "too neutral" for that context. Your
> > suggestion probably sounds better. I presume that something
> > more explicit but longer is worse, such as:
> > 
> > "partition #7 cannot be removed, as it doesn't exist"
> 
> Yeah, that is rather oververbose.  The message is not a contextless
> error message, but gets produced only when --verbose is used.  The
> previously mentioned example of deleting partitions 5 to 9 (with 7
> not existing), the command would be:
> 
> partx --delete --verbose -n 5:9 /dev/sda
> 
> and it currently would print the following progress messages:
> 
> dev/sda: partition #5 removed
> dev/sda: partition #6 removed
> dev/sda: partition #7 already doesn't exist
> dev/sda: partition #8 removed
> dev/sda: partition #9 removed
> 
> In fact I think the message for #7 is quite good,
> and I don't think that my proposal is any better:
> 
> dev/sda: partition #5 removed
> dev/sda: partition #6 removed
> dev/sda: skipping nonexistent partition #7
> dev/sda: partition #8 removed
> dev/sda: partition #9 removed

 As an unbiased observer (never used partx, so I'm the target audience
for understanding its output), either of these two look fine.
"already doesn't exist" mentally parses quickly.  That phrasing has
the advantage that the partition number is at the same column as the
messages for successful deletion, so you can scan down the column of
numbers and see that's the only message about #7.

 With the 2nd phrasing, I found I took a sec of extra time for my eye
to bounce from the column of #5, #6, <gap>, #8, #9 out to the #7.

 So I'd suggest keeping the "partition #%d already doesn't exist".  As
a native English speaker, I agree it sounds slightly clumsy, but it
gets the point across quickly and unambiguously.  You could maybe lose
the word "already", and say
"partition #%d doesn't exist"

 Or maybe "partition #%d: no such partition", to use the familiar
wording of strerror(ENOENT): "no such file or directory".

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
