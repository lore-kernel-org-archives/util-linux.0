Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45303 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751141AbaJ1UCP (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Oct 2014 16:02:15 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id DDD9A20D21
	for <util-linux@vger.kernel.org>; Tue, 28 Oct 2014 16:02:12 -0400 (EDT)
Message-Id: <1414526532.495299.184374637.2BF00A99@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: JWP <elseifthen@gmx.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 4/4] docs: improve wording and formattin of man page of
 hwclock
Date: Tue, 28 Oct 2014 21:02:12 +0100
In-Reply-To: <544EECC9.2000300@gmx.com>
References: <1414444693-16407-1-git-send-email-bensberg@justemail.net>
 <1414444693-16407-4-git-send-email-bensberg@justemail.net>
 <544EECC9.2000300@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, Oct 28, 2014, at 02:09, JWP wrote:
> On 10/27/2014 05:18 PM, Benno Schulenberg wrote:
> >  Since v2.26
> >  .B hwclock
> >  does not update the Hardware Clock's drift factor in @ADJTIME_PATH@ by default.
> > -It is necessary to use \fB\-\-update-drift\fR, with \fB\-\-set\fR or
> > +It is necessary to use the option \fB\-\-update-drift\fR, with \fB\-\-set\fR or
> >  \fB\-\-systohc\fR, to force drift factor updates.
> 
> The rest of the manual uses 'the --xxxx option'.

Well, I can't explain, but in this case "the option --xxxx" is better.

> >  Since v2.26
> >  .B hwclock \-\-hctosys
> > -automatically compensates time read from the Hardware Clock to account for
> > -systematic drift before using it to set the System Clock.  Therefore,
> > -\fB\-\-adjust\fR is no longer necessary during boot. This functionality makes
> > -hwclock usable early in the boot process when the root filesystem is read-only.
> > +automatically takes a systematic drift of the Hardware Clock into account,
> > +setting the System Clock to the drift-compensated time.  Therefore the option
> > +\fB\-\-adjust\fR is no longer necessary during boot.  This feature makes
> > +.B hwclock
> > +usable early on in the boot process when the root filesystem is read-only.
> 
> "a systematic drift"? That entire phrase does not sound natural to me.

:|

> I think it is important to
> stress that *the_time_read* from the Clock is what is being compensated as this is
> a new behavior.

Well, then suggest how exactly to phrase that.

Benno

-- 
http://www.fastmail.fm - Or how I learned to stop worrying and
                          love email again

