Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36252 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbbCALYN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Mar 2015 06:24:13 -0500
Received: by wghk14 with SMTP id k14so28313244wgh.3
        for <util-linux@vger.kernel.org>; Sun, 01 Mar 2015 03:24:12 -0800 (PST)
Date: Sun, 1 Mar 2015 11:24:10 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 04/13] rtcwake: remove RTC_ALM_READ and RTC_ALM_SET
 compatibility
In-Reply-To: <1424723839.3617007.231392809.42CA471C@webmail.messagingengine.com>
Message-ID: <alpine.LNX.2.03.1503011122440.822@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi> <1424616139-638-5-git-send-email-kerolasa@iki.fi> <1424723839.3617007.231392809.42CA471C@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 23 Feb 2015, Benno Schulenberg wrote:

> On Sun, Feb 22, 2015, at 15:42, Sami Kerola wrote:
> > The RTC_WKALM_RD and RTC_WKALM_SET have avaRilable since 2.6.17, and
> > preferred way since 2007.  Keeping the availability to old interface is
> > no longer needed.
> 
> s/have avaRilable/have been available/
> s/the availability to old interface/the fallbacks to the old interface/

Thanks Benno,

Here's updated commit message.

https://github.com/kerolasa/lelux-utiliteetit/commit/d14020f743a3d4dd5f1e4a7d4df4db5535ed0111

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
