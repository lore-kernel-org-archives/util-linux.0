Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39247 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756380AbaJaJvu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 31 Oct 2014 05:51:50 -0400
Date: Fri, 31 Oct 2014 10:51:42 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: JWP <elseifthen@gmx.com>, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 4/4] docs: improve wording and formattin of man page of
 hwclock
Message-ID: <20141031095142.GX10134@x2.net.home>
References: <1414444693-16407-1-git-send-email-bensberg@justemail.net>
 <1414444693-16407-4-git-send-email-bensberg@justemail.net>
 <544EECC9.2000300@gmx.com>
 <1414526532.495299.184374637.2BF00A99@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414526532.495299.184374637.2BF00A99@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 28, 2014 at 09:02:12PM +0100, Benno Schulenberg wrote:
> 
> On Tue, Oct 28, 2014, at 02:09, JWP wrote:
> > On 10/27/2014 05:18 PM, Benno Schulenberg wrote:
> > >  Since v2.26
> > >  .B hwclock
> > >  does not update the Hardware Clock's drift factor in @ADJTIME_PATH@ by default.
> > > -It is necessary to use \fB\-\-update-drift\fR, with \fB\-\-set\fR or
> > > +It is necessary to use the option \fB\-\-update-drift\fR, with \fB\-\-set\fR or
> > >  \fB\-\-systohc\fR, to force drift factor updates.
> > 
> > The rest of the manual uses 'the --xxxx option'.
> 
> Well, I can't explain, but in this case "the option --xxxx" is better.
> 
> > >  Since v2.26
> > >  .B hwclock \-\-hctosys
> > > -automatically compensates time read from the Hardware Clock to account for
> > > -systematic drift before using it to set the System Clock.  Therefore,
> > > -\fB\-\-adjust\fR is no longer necessary during boot. This functionality makes
> > > -hwclock usable early in the boot process when the root filesystem is read-only.
> > > +automatically takes a systematic drift of the Hardware Clock into account,
> > > +setting the System Clock to the drift-compensated time.  Therefore the option
> > > +\fB\-\-adjust\fR is no longer necessary during boot.  This feature makes
> > > +.B hwclock
> > > +usable early on in the boot process when the root filesystem is read-only.
> > 
> > "a systematic drift"? That entire phrase does not sound natural to me.
> 
> :|
> 
> > I think it is important to
> > stress that *the_time_read* from the Clock is what is being compensated as this is
> > a new behavior.
> 
> Well, then suggest how exactly to phrase that.

I'll wait for the final patch :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
