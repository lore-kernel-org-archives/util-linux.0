Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:22389 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab3EFAMZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 5 May 2013 20:12:25 -0400
Message-ID: <5186F568.2070305@draigBrady.com>
Date: Mon, 06 May 2013 01:12:24 +0100
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 13/16] cal: stop trimming whitespaces
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi> <1367520701-14962-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367520701-14962-14-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 05/02/2013 07:51 PM, Sami Kerola wrote:
> Remove trailing spaces from output it is trivial
> 
> cal | sed 's/ *$//'
> 
> but padding them back is difficult.
> 
> CC: Pádraig Brady <P@draigbrady.com>
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>

Looks good.

thanks,
Pádraig.

