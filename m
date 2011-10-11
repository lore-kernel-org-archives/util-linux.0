Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32624 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab1JKIVm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Oct 2011 04:21:42 -0400
Date: Tue, 11 Oct 2011 10:21:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] mountpoint: return dev_t from dir_to_device
Message-ID: <20111011082138.GB20392@nb.net.home>
References: <1318131111-30395-1-git-send-email-dreisner@archlinux.org> <20111009212326.GP782@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111009212326.GP782@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 09, 2011 at 05:23:26PM -0400, Dave Reisner wrote:
> On Sat, Oct 08, 2011 at 11:31:50PM -0400, Dave Reisner wrote:
> > The string returned from this function was never of much use other than
> > to stat the path when the user requested a major:minor pair beyond the
> > true/false exit. Save some processing and directly returning the dev_t
> > on success, and an impossible value on failure.
> > 
> > Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> > ---
> >  sys-utils/mountpoint.c |   15 +++++++--------
> >  1 files changed, 7 insertions(+), 8 deletions(-)
> > 
> 
> I'll also mention that this fixes an issue with mountpoint that causes
> it to throw a false negative when /proc is mounted with a source of
> "none". This value is treated specially in libmount and sets the source
> to NULL, which makes dir_to_device() incorrectly claim that the directory
> is not in fact a mountpoint.

 Applied with some minor changes, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
