Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47737 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752553AbbBWUhT (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Feb 2015 15:37:19 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 929CA207D2
	for <util-linux@vger.kernel.org>; Mon, 23 Feb 2015 15:37:18 -0500 (EST)
Message-Id: <1424723839.3617007.231392809.42CA471C@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 04/13] rtcwake: remove RTC_ALM_READ and RTC_ALM_SET
 compatibility
Date: Mon, 23 Feb 2015 21:37:19 +0100
In-Reply-To: <1424616139-638-5-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
 <1424616139-638-5-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Feb 22, 2015, at 15:42, Sami Kerola wrote:
> The RTC_WKALM_RD and RTC_WKALM_SET have avaRilable since 2.6.17, and
> preferred way since 2007.  Keeping the availability to old interface is
> no longer needed.

s/have avaRilable/have been available/
s/the availability to old interface/the fallbacks to the old interface/

Benno

-- 
http://www.fastmail.com - The way an email service should be

