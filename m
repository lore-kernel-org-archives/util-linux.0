Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53310 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab1IGFdR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Sep 2011 01:33:17 -0400
Date: Wed, 7 Sep 2011 07:33:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: util-linux@vger.kernel.org, kerolasa@iki.fi
Subject: Re: [PATCH] script.c: drop libintl.h include
Message-ID: <20110907053300.GB2496@nb.redhat.com>
References: <1315252976-4394-1-git-send-email-jacmet@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315252976-4394-1-git-send-email-jacmet@sunsite.dk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 05, 2011 at 10:02:55PM +0200, Peter Korsgaard wrote:
> Commit 8fb810ff26 (script: include-what-you-use header check) added a
> <libintl.h> #include, which isn't needed as nls.h includes it (if
> enabled) - But worse, breaks the build for systems without libintl.h
> (like some uClibc configurations).

 Already fixed by patch from Natanael Copa.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
