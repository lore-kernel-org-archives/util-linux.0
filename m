Return-Path: util-linux-owner@vger.kernel.org
Received: from mta03.eastlink.ca ([24.224.136.9]:35155 "EHLO mta03.eastlink.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798AbbBAVVk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 1 Feb 2015 16:21:40 -0500
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta03.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NJ4000Y80GNKAE0@mta03.eastlink.ca> for
 util-linux@vger.kernel.org; Sun, 01 Feb 2015 17:21:38 -0400 (AST)
Date: Sun, 01 Feb 2015 17:21:38 -0400
To: J William Piggott <elseifthen@gmx.com>
Cc: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH 8/8] docs: add the Sort command to the man page of	cfdisk
Message-id: <20150201212138.GV29504@cordes.ca>
References: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
 <1422799213-16717-8-git-send-email-bensberg@justemail.net>
 <54CE80A2.1040008@gmx.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <54CE80A2.1040008@gmx.com>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 01, 2015 at 02:38:10PM -0500, J William Piggott wrote:
> 
> 
> On 02/01/2015 09:00 AM, Benno Schulenberg wrote:
> > Also sort T into its proper position, improve the wording of U,
> > and add the Left and Right arrow keys.
> > 
> > Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
> > ---
> >  disk-utils/cfdisk.8 |   38 +++++++++++++++++++++++---------------
> >  1 files changed, 23 insertions(+), 15 deletions(-)
> > 
> > diff --git a/disk-utils/cfdisk.8 b/disk-utils/cfdisk.8
> > index dc30b70..e4577d5 100644
> > --- a/disk-utils/cfdisk.8
> > +++ b/disk-utils/cfdisk.8
...
> >  .PP
> >  All commands can be entered with either uppercase or lowercase
> >  letters (except for
> >  .BR W rite).
> > -When in a submenu or at a prompt for entering a size, you can hit the
> > -.I ESC
> > +When in a submenu or at a prompt, you can hit the
> > +.I Esc
> >  key to return to the main menu.
> 
> s/can hit/may use/

 I think "can" is better.  "can use", though, rather than "can hit".
There's a "can be entered" earlier in the paragraph, which I think is
good usage.

"may" sounds like either the docs / software is giving you permission
to use this feature, or commenting on whether or not you might
actually use the feature.


 Docs should get their meaning across with as simple and
straightforward language as possible, for quick reading and
understanding by as many people as possible.  And hopefully not
distract ADHD people like me into thinking about re-wording them while
I'm in the middle of trying to figure out how to do something else :P.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
