Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60153 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbbCYIal (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Mar 2015 04:30:41 -0400
Date: Wed, 25 Mar 2015 09:30:36 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix fsck -C {fd} parsing
Message-ID: <20150325083036.GF1749@ws.net.home>
References: <5511C286.90500@suse.cz>
 <20150324221615.GB513@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150324221615.GB513@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 24, 2015 at 06:16:15PM -0400, Dave Reisner wrote:
> On Tue, Mar 24, 2015 at 09:01:10PM +0100, Stanislav Brabec wrote:
> > Both fsck(8) and fsck --help documents progress bar redirection as
> > -C {fd}
> > 
> > This did not work, and only -C{fd} and "-C {fd}" worked.

 Applied, thanks (please, Signed-off-by: next time).

> Perhaps rather than break the existing behavior it might be better to
> make the documentation match reality.

 Stanislav is right, it's pretty obvious from code:

> >  				} else if (i+1 < argc && *argv[i+1] != '-') {	/* -C <fd> */
> > -					progress_fd = string_to_int(argv[i]);
> > +					progress_fd = string_to_int(argv[i+1]);

 the "if()" checks for the next item in argv[], but string_to_int()
 has been used with argv[i].

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
