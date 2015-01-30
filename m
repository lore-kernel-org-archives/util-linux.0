Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56167 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752629AbbA3USu (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Jan 2015 15:18:50 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 24C4820A39
	for <util-linux@vger.kernel.org>; Fri, 30 Jan 2015 15:18:50 -0500 (EST)
Message-Id: <1422649129.1189198.221115417.2D352E5C@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] more: fix control character display bug
Date: Fri, 30 Jan 2015 21:18:49 +0100
In-Reply-To: <1422608050-28600-1-git-send-email-kerolasa@iki.fi>
References: <1422608050-28600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Fri, Jan 30, 2015, at 09:54, Sami Kerola wrote:
> This removes isprint(c) column++ from get_line() that made underlining,
> bold, and other control characters to cause more display to wrap lines

Suggestion: s/more display/'more'/

> incorrectly.  Easiest way to see the difference is to run following
> before and after compiling this change.
> 
> PAGER=./more man man

Could you include in this description a snippet of the observed changes?

Also, it would be nice to see the patch split into two: one that changes
the logic, and one that adjusts the whitespace for the changed logic.
(Once the patch is in git, one can of course use 'git log -p -w' to see
just the changed logic among all the changed whitespace, but from just
a plain email this is a bit hard to do.  Or maybe you yourself could post
a -p -w diff as a follow-up to the full patch to show the essential changes.
Because it seems that also github is not able to strip whitespace changes
from diffs.)

Benno

-- 
http://www.fastmail.com - Same, same, but different...

