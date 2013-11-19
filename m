Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25466 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550Ab3KSRc5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Nov 2013 12:32:57 -0500
Date: Tue, 19 Nov 2013 18:32:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fdisk: remove angle brackets from usage
Message-ID: <20131119173252.GM5572@x2.net.home>
References: <1384803754-973-1-git-send-email-psusi@ubuntu.com>
 <20131119092347.GB5572@x2.net.home>
 <528B792C.4010202@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528B792C.4010202@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 19, 2013 at 09:43:56AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/19/2013 4:23 AM, Karel Zak wrote:
> > On Mon, Nov 18, 2013 at 02:42:34PM -0500, Phillip Susi wrote:
> >> Remove superfluous angle brackets and use square brackets where
> >> appropriate to conform to the man page convention.
> > 
> > The angle brackets are expected, see
> > Documentation/howto-usage-function.txt.
> 
> In that case, then fdisk should have square brackets added around the
> <disk> since it is an optional argument.

 Yes, it's optional for -l. Fixed. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
