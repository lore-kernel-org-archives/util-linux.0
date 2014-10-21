Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11771 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755030AbaJUJik (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Oct 2014 05:38:40 -0400
Date: Tue, 21 Oct 2014 11:38:18 +0200
From: Karel Zak <kzak@redhat.com>
To: JWP <elseifthen@gmx.com>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/7] hwclock: hctosys drift compensation II
Message-ID: <20141021093818.GF8057@x2.net.home>
References: <5426D4C2.4060403@gmx.com>
 <5426D7C0.50108@gmx.com>
 <alpine.LNX.2.03.1409281829450.8884@iki.fi>
 <54298D46.6010101@gmx.com>
 <20141014090311.GM8057@x2.net.home>
 <544052E0.3080105@gmx.com>
 <20141020120550.GB8057@x2.net.home>
 <54459C31.3060702@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54459C31.3060702@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 20, 2014 at 07:35:13PM -0400, JWP wrote:
> Someone may think the Hardware Clock itself was being compensated.
> 
> I have made a commit to change the wording slightly, I will send you a
> pull request after I send this email.

Cool.

> Thank you for taking time to review and merge my work, and allowing me to
> contribute to util-linux.

I hope we will see more your patches ;-)

> * Do you want pull requests sent to you via github?
> * If yes, what, if anything, should be posted to the mailing list?

This mailing list is the core of the util-linux community, the ideal
solution is to send at least the initial version of the patches to the
list for wide discussion and review. The github is nice for repos if
you want to modify just small subset of the patches, or you work on
something large for long time, it's also nice backup solution etc.

I don't like strict rules, just use common sense :-)

(well, except email attachments, it's really painful solution for
 patches, the best is git-send-email)

See also Documentation/howto-contribute.txt and another howtos in the
Documentation/.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
