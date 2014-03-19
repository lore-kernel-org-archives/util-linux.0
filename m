Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58496 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964883AbaCSMcx (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Mar 2014 08:32:53 -0400
Message-Id: <1395232368.7652.96330753.426A8F05@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1394397023-7050-3-git-send-email-kerolasa@iki.fi>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
 <1394397023-7050-3-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 03/10] kill: flip all comparions to be in smaller - greater
 order
Date: Wed, 19 Mar 2014 13:32:48 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Mar 9, 2014, at 21:30, Sami Kerola wrote:
> This makes code more readable.

Hmm, I don't agree with that.

> -			if (argc > 2)
> +			if (2 < argc)

> -	if (num < SIGRTMIN || num > SIGRTMAX)
> +	if (num < SIGRTMIN || SIGRTMAX < num)

I like to see always the variable on the left and the fixed value on the right.

Regards,

Benno

-- 
http://www.fastmail.fm - Send your email first class

