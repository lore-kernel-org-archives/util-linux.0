Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34147 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbbBMLZe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 13 Feb 2015 06:25:34 -0500
Date: Fri, 13 Feb 2015 12:25:23 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: "Dale R. Worley" <worley@alum.mit.edu>,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigbrady.com>,
        mrmazda@earthlink.net, util-linux <util-linux@vger.kernel.org>
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
Message-ID: <20150213112523.GP32318@ws.net.home>
References: <54DC88BF.5040702@draigBrady.com>
 <87h9uqv6lv.fsf@hobgoblin.ariadne.com>
 <20150213092131.GM32318@ws.net.home>
 <CAG27Bk0JrVSbKEBqeEr63O4cz3B5zyDmGw_MFVzXYTbWjZ2URQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0JrVSbKEBqeEr63O4cz3B5zyDmGw_MFVzXYTbWjZ2URQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 13, 2015 at 10:33:23AM +0000, Sami Kerola wrote:
> On 13 February 2015 at 09:21, Karel Zak <kzak@redhat.com> wrote:
> > On Thu, Feb 12, 2015 at 10:21:48PM -0500, Dale R. Worley wrote:
> >> I don't particularly like colorization.  But technically, it seems to me
> >> that what is needed is a systematic way for the user to indicate his
> >> colorization preferences to *all* utilities.  And a corresponding way
> >> for the system to provide defaults for those user preferences.
> >>
> >>
> >> Only when there is a systematic framework for colorization will all the
> >> programs allow colorizing to be configured.
> >
> > It would be possible to create a shared library from our lib/colors.c
> > to support terminal-colors.d/... :-)
> 
> Or add the needed to ncurses. Isn't that better than adding a new
> library?

you want to link programs like dmesg, gcc or ls with ncurses monster?

The another story is that ncurses provides completely abstract layer
for colors and I didn't found a way how to use it together with color 
escape sequences. This is reason why for example cfdisk supports only
enable/disable terminal-colors.d feature, but no schemes to specify
colors.
    
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
