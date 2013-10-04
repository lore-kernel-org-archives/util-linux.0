Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38529 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751216Ab3JDJXK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 4 Oct 2013 05:23:10 -0400
Message-Id: <1380878588.23958.29906781.520589D2@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Petr Pisar <petr.pisar@atlas.cz>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20131004085637.GC3808@album.bayer.uni.cx>
References: <20131004085637.GC3808@album.bayer.uni.cx>
Subject: Re: util-linux 2.24-rc1 message errors
Date: Fri, 04 Oct 2013 11:23:08 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Fri, Oct 4, 2013, at 10:56, Petr Pisar wrote:
> # FIXME: Signular or plural? Missing `s'.
> #: libfdisk/src/sgi.c:762
> msgid "Partition overlap on the disk."

We were here before.  The phrase is correct, "overlap" is a noun.
But as it bothers you, I'll dig up my previous proposal.

> # FIXME: s/cotrol/control/
> #: term-utils/agetty.c:1810
> msgid " -L, --local-line[=<mode>]  cotrol local line flag\n"

Already fixed.

I'll be working on the others.

Benno

-- 
http://www.fastmail.fm - IMAP accessible web-mail

