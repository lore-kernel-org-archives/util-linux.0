Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41488 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714Ab2IZVB3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Sep 2012 17:01:29 -0400
Message-ID: <50636D1D.3080007@draigBrady.com>
Date: Wed, 26 Sep 2012 22:01:17 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] column: make defined separator to be non-greedy
References: <1348692336-21301-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1348692336-21301-1-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 09/26/2012 09:45 PM, Sami Kerola wrote:
> This patch changes interpretation of subsequent delimeter interpretation.
> Earlier version merged columns that had null string as content together,
> which lead to output as visualized below.
>
> $ printf "a:b:c\n1::3\n" | column  -t -s ':'
> a  b  c
> 1  3
>
> The number 3 has wrong column, which this patch takes care of, and alters
> the output following way.
>
> $ printf "a:b:c\n1::3\n" | column  -t -s ':'
> a  b  c
> 1     3
>
> This patch does not alter the default case, e.g., subsequent white spaces
> are understood as separator of the same field, and the beginning of line
> white spaces are being ignored together.
>
> Signed-off-by: Sami Kerola<kerolasa@iki.fi>

The new operation makes sense to me.
You can always get the previous operation
by filtering through tr -s ':' first.

cheers,
Pádraig.
