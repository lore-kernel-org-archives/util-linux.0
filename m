Return-Path: util-linux-owner@vger.kernel.org
Received: from mta02.eastlink.ca ([24.224.136.13]:36521 "EHLO
	mta02.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbbBBBMG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Feb 2015 20:12:06 -0500
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta02.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NJ30026ATDG6G80@mta02.eastlink.ca> for
 util-linux@vger.kernel.org; Sun, 01 Feb 2015 21:12:03 -0400 (AST)
Date: Sun, 01 Feb 2015 21:12:03 -0400
To: J William Piggott <elseifthen@gmx.com>
Cc: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH 8/8] docs: add the Sort command to the man page of cfdisk
Message-id: <20150202011203.GZ29504@cordes.ca>
References: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
 <1422799213-16717-8-git-send-email-bensberg@justemail.net>
 <54CE80A2.1040008@gmx.com> <20150201212138.GV29504@cordes.ca>
 <54CEC2F3.7060906@gmx.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <54CEC2F3.7060906@gmx.com>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 01, 2015 at 07:21:07PM -0500, J William Piggott wrote:
> 
> 
> On 02/01/2015 04:21 PM, Peter Cordes wrote:
> > On Sun, Feb 01, 2015 at 02:38:10PM -0500, J William Piggott wrote:
> >>
> >>
> >> On 02/01/2015 09:00 AM, Benno Schulenberg wrote:
> >>> Also sort T into its proper position, improve the wording of U,
> >>> and add the Left and Right arrow keys.
> >>>
> >>> Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
> >>> ---
> >>>  disk-utils/cfdisk.8 |   38 +++++++++++++++++++++++---------------
> >>>  1 files changed, 23 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/disk-utils/cfdisk.8 b/disk-utils/cfdisk.8
> >>> index dc30b70..e4577d5 100644
> >>> --- a/disk-utils/cfdisk.8
> >>> +++ b/disk-utils/cfdisk.8
> > ...
> >>>  .PP
> >>>  All commands can be entered with either uppercase or lowercase
> >>>  letters (except for
> >>>  .BR W rite).
> >>> -When in a submenu or at a prompt for entering a size, you can hit the
> >>> -.I ESC
> >>> +When in a submenu or at a prompt, you can hit the
> >>> +.I Esc
> >>>  key to return to the main menu.
> >>
> >> s/can hit/may use/
> > 
> >  I think "can" is better.  "can use", though, rather than "can hit".
> > There's a "can be entered" earlier in the paragraph, which I think is
> > good usage.
> > 
> > "may" sounds like either the docs / software is giving you permission
> > to use this feature,
> 
> Yes, that is exactly why 'may' is better. One 'can' use the <ESC>
> anytime, I'm hitting it right now. Can means: it is possible.
>
> What is being said, is in this particular circumstance the program
> 'allows' you to use that key and something will happen.

 That sentence is telling you that returning to the main menu (by
pressing <ESC>) is one of your options.  Not just that you can press a
key.  You can always give any input you want (if you don't care about
the resulting behaviour).

 This kind of leads to the question of whether the program is in
charge, with a user directing its action; or whether the user is in
charge, carrying out their desired actions by directing software to do
it.  I feel like I want to say something snarky about Microsoft now.
:P

> Having said that, grammatically either one is considered acceptable.
> So 'can vs may' is a subjective call,

 Yeah, both ways convey the correct meaning.  I still think "may" has
unintended connotations, but your explanation does make sense for why
you think "may" is appropriate.

  Perhaps someone who learned English only as a second, or Nth,
language, could shed some light on whether there's any confusion, or
if one way sounds more clear to them.  I prefer "can use" or "can
press", partly because I think it's more direct and straightforward.


> but 'hit' needs to go IMO.

 It's not terrible, but I think it would be an improvement to change it.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
