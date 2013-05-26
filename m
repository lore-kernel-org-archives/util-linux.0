Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:57671 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3EZSYe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 May 2013 14:24:34 -0400
Message-ID: <51A2533B.9060905@bernhard-voelker.de>
Date: Sun, 26 May 2013 20:23:55 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 0000] pull: cal the branch four
References: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Sami,

On 05/26/2013 11:14 AM, Sami Kerola wrote:
> The cal branch I have in my git has got fixes to issues reviewed earlier,
> and I hope all works.  Based on that I decided to get rid of upper cal
> year limit, 9999, and replace it with unsigned long.  I know the change
> does not make much practical sense, the point of the change is that where
> there is no need to have artificial limits to a random magic number they
> should not exist.

unsigned years ... hmm, not that this would work today, but what about BC
years? E.g. on what weekday did Julius Caesar die (March 15th, 44 BC, [1])?
Maybe a future improvement (... having to make years signed again)?

[1] http://en.wikipedia.org/wiki/Julius_Caesar

Have a nice day,
Berny
