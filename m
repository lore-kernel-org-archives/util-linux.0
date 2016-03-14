Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58082 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754929AbcCNMID (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 08:08:03 -0400
Date: Mon, 14 Mar 2016 13:08:01 +0100
From: Karel Zak <kzak@redhat.com>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/10] lsipc, lslogins, rtcwake: replace asctime() with
 strftime()
Message-ID: <20160314120801.u4a3xkmkd5z3wne7@ws.net.home>
References: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
 <1457865109-2881-4-git-send-email-kerolasa@iki.fi>
 <m337ruiket.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m337ruiket.fsf@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 13, 2016 at 04:20:42PM +0300, Yuriy M. Kaminskiy wrote:
> 
> On 03/13/16 13:31 , Sami Kerola wrote:
> > POSIX.1-2008 marks asctime() and asctime_r() as obsolete, recommending the
> > use of strftime(3) instead.
> 
> stftime uses locale, asctime is not. And if you want *locale-specific*
> time presentation, it is "%c" --- it can be very different from your "%a
> %b...", e.g. compare with attached

This is why I have asked for functions in lib/timeutils.c to make
short, full or iso formats explicitly defined on one place to avoid
creativity in utils code and such discussions.

We need:

 - human readable times:
    * full  (%c -- now asctime)
    * short ("%H:%M:%S, "%b%d/%H:%M", "%Y-%b%d")

 - ISO:
    * full
    * short


    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
