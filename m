Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36574 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818AbcHBOQl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2016 10:16:41 -0400
Date: Tue, 2 Aug 2016 16:09:02 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] getops: improve getopt-parse.bash example
Message-ID: <20160802140902.opqb5mitrfheb6iw@ws.net.home>
References: <20160727103457.3105-1-kerolasa@iki.fi>
 <1469618118.1670435.678129761.331B0F49@webmail.messagingengine.com>
 <CAG27Bk1pZx3AAnJ3kGOvm+ekBJnW1p0Ryme0f_wtntWrRpWBmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1pZx3AAnJ3kGOvm+ekBJnW1p0Ryme0f_wtntWrRpWBmA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 27, 2016 at 04:20:32PM +0100, Sami Kerola wrote:
> On 27 July 2016 at 12:15, Benno Schulenberg <bensberg@justemail.net> wrote:
> >
> > In the subject line: s/ops/opt/.
> >
> > On Wed, Jul 27, 2016, at 12:34, Sami Kerola wrote:
> >> --- a/misc-utils/getopt-parse.bash
> >> +++ b/misc-utils/getopt-parse.bash
> >> @@ -3,45 +3,73 @@
> >>  # A small example program for using the new getopt(1) program.
> >>  # This program will only work with bash(1)
> >>  # An similar program using the tcsh(1) script language can be found
> >
> > When here anyway, maybe fix a typo: s/An/A/.
> > Add a missing period: s/)/)./.
> > And adjust for the times: s/new //.
> >
> >> -# as parse.tcsh
> >> +# as getopt-parse.tcsh
> >
> > Also add period: s/tcsh/tcsh./
> >
> > Benno
> 
> Thanks Benno.
> 
> The example file banner is updated to both of them. I also changed the
> example script
> to call itself as script rather than a program.
> 
> https://github.com/kerolasa/lelux-utiliteetit/commit/d27f5fe770025e456fbd33b87a96968f34c455ed
> 
> Karel if/when considering merge the branch name is: getopt

Merged, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
