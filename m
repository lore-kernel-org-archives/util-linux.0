Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46277 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbbCILxF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Mar 2015 07:53:05 -0400
Date: Mon, 9 Mar 2015 12:52:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Sitsofe Wheeler <sitsofe@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: agetty --reload
Message-ID: <20150309115259.GB26473@ws.net.home>
References: <CALjAwxjTo=krFxHht2029Sh-h3maEvGK1Xa0fXUOScsamG_=Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALjAwxjTo=krFxHht2029Sh-h3maEvGK1Xa0fXUOScsamG_=Eg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 08, 2015 at 09:02:11PM +0000, Sitsofe Wheeler wrote:
> The main issue seems to be that /etc/issue isn't reparsed when agetty
> --reload is done unless /run/agetty.reload exists before the original
> agetty is started. Is this the intended behaviour?

No, this is a bug, fixed by commit c9f5ec0faa2b2d9cf7fc162baf99499457b8b909.

> The second issue occurs when --autologin and --login-pause are being
> used and a reload happens even when the above is done. Since the login
> program hasn't actually been started (as we are waiting for the user
> to press enter) I expected the reload to cause agetty to reload
> /etc/issue and start waiting again but this does not currently happen.
> Is this also intentional?

Well, it wasn't implemented, improved by commit c2ef308bbfdc9fb9a0053e258828f5bd6fbb0c5d.

The changes will be in v2.26.1.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
