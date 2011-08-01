Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp-68.nebula.fi ([83.145.220.68]:45024 "EHLO
	smtp-68.nebula.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab1HAQ0F (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Aug 2011 12:26:05 -0400
Received: from [127.0.0.1] (dyn-xdsl-83-150-113-243.nebulazone.fi [83.150.113.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-68.nebula.fi (Postfix) with ESMTP id 477E643F0879
	for <util-linux@vger.kernel.org>; Mon,  1 Aug 2011 19:26:02 +0300 (EEST)
Message-ID: <4E36D394.5040509@iki.fi>
Date: Mon, 01 Aug 2011 19:25:56 +0300
From: Lauri Nurmi <lanurmi@iki.fi>
MIME-Version: 1.0
To: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] pluralization and tiny adjustments of some messages
References: <1312140631.21317.2157888669@webmail.messagingengine.com>
In-Reply-To: <1312140631.21317.2157888669@webmail.messagingengine.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

31.7.2011 22:30, Benno Schulenberg kirjoitti:
> --- a/sys-utils/fstrim.c
> +++ b/sys-utils/fstrim.c
>   	if (verbose)
> -		printf(_("%s: %" PRIu64 " bytes was trimmed\n"),
> +		printf(_("%s: %" PRIu64 " bytes were trimmed\n"),
>   						path, (uint64_t) range.len);

Hi,

shouldn't this one be pluralized also?


Regards,
LN

