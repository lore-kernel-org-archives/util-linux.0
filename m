Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16479 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451Ab3AJKsT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Jan 2013 05:48:19 -0500
Date: Thu, 10 Jan 2013 11:48:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] build-sys: add chkdupexe and uuidd socket activation
 to most-builds
Message-ID: <20130110104810.GF593@x2.net.home>
References: <1357771446-11966-1-git-send-email-kerolasa@iki.fi>
 <1357771446-11966-3-git-send-email-kerolasa@iki.fi>
 <20130109224715.GY31925@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130109224715.GY31925@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 09, 2013 at 05:47:15PM -0500, Dave Reisner wrote:
> On Wed, Jan 09, 2013 at 10:44:06PM +0000, Sami Kerola wrote:
> > Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> > ---
> 
> chkdupexe was marked as deprecated and turned off by default in

 --enable-most-builds is just about utils which are not enabled by
 default :-)

> 4581bd9c6797ea3b75. Maybe generalize the commit message as well, since
> this does a lot more than just enable the 2 builds it claims.

 fixed

> >  configure.ac | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
