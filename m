Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40347 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751995AbbBWUkM (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Feb 2015 15:40:12 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 468BE209DD
	for <util-linux@vger.kernel.org>; Mon, 23 Feb 2015 15:40:11 -0500 (EST)
Message-Id: <1424724011.3617363.231394013.6C35BC75@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1424616139-638-12-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
 <1424616139-638-12-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 11/13] rtcwake: improve coding style
Date: Mon, 23 Feb 2015 21:40:11 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Feb 22, 2015, at 15:42, Sami Kerola wrote:
> -	/* this process works in RTC time, except when working
> -	 * with the system clock (which always uses UTC).
> -	 */
> +	/* this process works in RTC time, except when working with the
> +	 * system clock (which always uses UTC). */

Since this and the other comments ends with a period, it really
should start with a capital.  When changing the line anyway...

Benno

-- 
http://www.fastmail.com - Send your email first class

