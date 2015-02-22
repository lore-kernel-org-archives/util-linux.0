Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55834 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752047AbbBVRob (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Feb 2015 12:44:31 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id D2B5620687
	for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 12:44:30 -0500 (EST)
Message-Id: <1424627071.3149397.230857529.0E42F353@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1424616106-580-3-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-3-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 02/16] flock: add --verbose option
Date: Sun, 22 Feb 2015 18:44:31 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Feb 22, 2015, at 15:41, Sami Kerola wrote:
> +.B \-\-verbose
> +Tell why lock could not be got, and when it can be how long did it take
> +to acquire the lock.

Better: "Report how long it took to acquire the lock, or why the lock
could not be obtained."

> -		{"version", no_argument, NULL, 'V'},
> +		{"version", required_argument, NULL, 'V'},

Huh?

Benno

-- 
http://www.fastmail.com - mmm... Fastmail...

