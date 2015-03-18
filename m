Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60794 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756983AbbCRUO0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Mar 2015 16:14:26 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id D885A20E24
	for <util-linux@vger.kernel.org>; Wed, 18 Mar 2015 16:14:23 -0400 (EDT)
Message-Id: <1426709665.931918.242192665.7F1A1D3A@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: J William Piggott <elseifthen@gmx.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <5508C704.1060500@gmx.com>
References: <1426624493-2464-1-git-send-email-bensberg@justemail.net>
 <1426624493-2464-3-git-send-email-bensberg@justemail.net>
 <5508C704.1060500@gmx.com>
Subject: Re: [PATCH 3/3] hwclock: fix spelling,
 punctuation and formatting mistakes in the man page
Date: Wed, 18 Mar 2015 21:14:25 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Wed, Mar 18, 2015, at 01:29, J William Piggott wrote:
> On 03/17/2015 04:34 PM, Benno Schulenberg wrote:
> >  Since v2.26 important changes were made to the
> >  .B \-\-hctosys
> > -function, the
> > +function and the
> >  .B \-\-directisa
> >  option, and a new option
> >  .B \-\-update\-drift
> > -was added. See their respective sections below.
> > +was added.  See their respective descriptions below.
> 
> What guide says this is the proper style for an inline list?

Pfff...  It's better.  The two commas seem to suggest that
also changes were made to the third item, --update-drift,
but three words into that phrase that appears not to be
the case.  So... keep the two things that were changed
together, and mention the addition in a second phrase.

> > -The set function requires using the
> > +The \fB\%\-\-setepoch\fR function requires using the
> >  .B \%\-\-epoch
> > -option.
> > +option to specify the year.
> 
> This is completely unnecessary verbosity.

No.  It took me three readings to get that with "set"
--setepoch was meant.

> > -.BI "\%hwclock\ \-\-set\ \-\-date='" 2011-08-14\ 16:45:05 '
> > +.B "hwclock\ \-\-set\ \-\-date='2011-08-14\ 16:45:05'
> 
> It is common practice for option arguments to be in italic.

No.  They are in italics when they are fill-in arguments: something
has to be filled in instead of the word in italics.  When giving actual,
literal values, they are in bold.

> I've already
> explained to you that the soft hyphen prevents this command structure
> from wrapping on narrow windows when multitasking.

The word is at the start of a line here -- there is no need to
prevent wrapping.

> > -.BI \%\-\-epoch= 1980
> > +.B \%\-\-epoch=1980
> 
> Option arguments should be in italic.

No.  Why the repetition?  Once is enough.

> > -the Hardware Clock to detect a time transition.  "Toy" in the option
>> +the Hardware Clock to detect a time transition.  The "toy" in the option
> 
> What style guide is this from?

Again, it's better.

> > -.BI \%adjtimex\ \-\-tick \ <value>\  \-\-frequency \ <value>
> > +.BI \%adjtimex\ \-\-tick \ value\  \-\-frequency \ value
> 
> How does the reader know they do not literally enter 'value'?

Because it's in italics.  (The angular brackets are a convention
of usage texts.)

> >  Attempt to configure drift correction for only
> > -one of them, and the other's drift will be overlaid upon it.  If the big
> > -picture is not kept in mind, confusion will soon ensue.
> > +one of them, and the other's drift will be overlaid upon it.
> 
> This is true and valuable information. I know from experience.

The sentence was removed because it's repetitious, but mainly
so that it's clear what "This problem" below refers to -- not to
losing the big picture, but to the other drift getting overlaid.

> >  The System Clock drift is corrected with the
> >  .BR \%adjtimex "(8) command's " \-\-tick " and " \%\-\-frequency
> > -options.  These two work together, tick is the course adjustment and
> > -frequency is the fine adjustment. (For system that do not have an
> > +options.  These two work together; tick is the coarse adjustment and
> > +frequency is the fine adjustment.  (For systems that do not have an
> 
> Improper use of a semicolon, "These two work together" is incomplete.

Aaah, but no nice word about the spell correction from "course" to "coarse".

:)

Anyway, a comma wasn't right either.  Better make it a colon then.

> > -.RB "Confirm that " ntpd "(1) will not be launched at startup."
> > +.RB "Ensure that " ntpd "(1) will not be launched at startup."
> 
> They were instructed at the beginning of the section to do this. There
> is nothing wrong with 'confirm'.

Okay, I forgot about that, the explanations being so long...

> > -Shutdown the system.
> > +Shut down the system.
> 
> This is wrong.

No, it isn't: "shutdown" is the noun, "shut down" the verb.

https://www.wordnik.com/words/shutdown
https://www.wordnik.com/words/shut%20down

> http://www.merriam-webster.com/dictionary/shutdown
> http://www.merriam-webster.com/dictionary/shut%20down

Benno

-- 
http://www.fastmail.com - Accessible with your email software
                          or over the web

