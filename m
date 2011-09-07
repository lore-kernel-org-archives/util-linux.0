Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51295 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004Ab1IGQdp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Sep 2011 12:33:45 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p87GXjmH002660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 7 Sep 2011 12:33:45 -0400
Date: Wed, 7 Sep 2011 16:32:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: util-linux@vger.kernel.org, kerolasa@iki.fi
Subject: Re: [PATCH] script.c: drop libintl.h include
Message-ID: <20110907143213.GA4204@nb>
References: <1315252976-4394-1-git-send-email-jacmet@sunsite.dk> <20110907053300.GB2496@nb.redhat.com> <877h5klgcs.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <877h5klgcs.fsf@macbook.be.48ers.dk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 07, 2011 at 01:52:19PM +0200, Peter Korsgaard wrote:
> >>>>> "Karel" == Karel Zak <kzak@redhat.com> writes:
> 
>  Karel> On Mon, Sep 05, 2011 at 10:02:55PM +0200, Peter Korsgaard wrote:
>  >> Commit 8fb810ff26 (script: include-what-you-use header check) added a
>  >> <libintl.h> #include, which isn't needed as nls.h includes it (if
>  >> enabled) - But worse, breaks the build for systems without libintl.h
>  >> (like some uClibc configurations).
> 
>  Karel>  Already fixed by patch from Natanael Copa.
> 
> Ahh, didn't notice it because of the kernel.org issue. While that patch
> also fixes the problem, it is more complicated than needed as nls.h
> already includes libintl.h - E.G. the explicit include can just be
> removed.

 Yes, good point. Fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
