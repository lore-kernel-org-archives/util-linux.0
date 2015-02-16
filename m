Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55535 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548AbbBPNtn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Feb 2015 08:49:43 -0500
Date: Mon, 16 Feb 2015 14:49:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, kerolasa@gmail.com,
        "Dale R. Worley" <worley@alum.mit.edu>,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigbrady.com>,
        mrmazda@earthlink.net, util-linux <util-linux@vger.kernel.org>
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
Message-ID: <20150216134930.GJ11948@ws.net.home>
References: <54DC88BF.5040702@draigBrady.com>
 <87h9uqv6lv.fsf@hobgoblin.ariadne.com>
 <20150213092131.GM32318@ws.net.home>
 <CAG27Bk0JrVSbKEBqeEr63O4cz3B5zyDmGw_MFVzXYTbWjZ2URQ@mail.gmail.com>
 <20150213112523.GP32318@ws.net.home>
 <20150215111238.GG32251@vapier>
 <20150216091043.GA11948@ws.net.home>
 <20150216093533.GJ4075@vapier>
 <20150216094747.GC11948@ws.net.home>
 <20150216103241.GD3926@type.bordeaux.inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150216103241.GD3926@type.bordeaux.inria.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 16, 2015 at 11:32:41AM +0100, Samuel Thibault wrote:
> It should also check how to change the colors. Not all terminals will
> support the ANSI way.
> 
> > Anyway, we don't want to create (duplicate) any database, all it
> > provides are knobs for customization and enable/disable.
> 
> It provides only that because the source code currently hardcodes the
> \033[%sm sequence, but it really should not, and use terminfo instead.

 Good point, I'm ready to accept patches to implement this feature :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
