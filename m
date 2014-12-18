Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48482 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751125AbaLRU3t (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Dec 2014 15:29:49 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id E8D11209A9
	for <util-linux@vger.kernel.org>; Thu, 18 Dec 2014 15:29:48 -0500 (EST)
Message-Id: <1418934588.1961521.204580073.2E7DAA16@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Adam Sampson <ats@offog.org>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: RFC [patch] adding docstrings
Date: Thu, 18 Dec 2014 21:29:48 +0100
In-Reply-To: <y2ah9wtwbz9.fsf@cartman.at.offog.org>
References: <1418847631-8317-1-git-send-email-bensberg@justemail.net>
 <y2ah9wtwbz9.fsf@cartman.at.offog.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Thu, Dec 18, 2014, at 10:20, Adam Sampson wrote:
> Benno Schulenberg <bensberg@justemail.net> writes:
> > This patch adds a docstring (a one-line description) to each of the
> > utilities.
> 
> Is it worth synchronising these descriptions with the one-liners in the
> "NAME" sections of the man pages (i.e. what apropos shows)?

I think so.  In a later, different patch we can do that.

> I think the
> one you've come up with for addpart is clearer than the existing one in
> the man page, for example...

Thanks.  At first, like Steven, I just yanked (by script) the description
from the man page into the usage text, and then tried to improve those
descriptions.  But I soon ran out of ideas and therefore asked for help.

Benno

-- 
http://www.fastmail.com - Access your email from home and the web

