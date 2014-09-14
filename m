Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:58120 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbaINL5w (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Sep 2014 07:57:52 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 9F6E0241C2
	for <util-linux@vger.kernel.org>; Sun, 14 Sep 2014 13:57:49 +0200 (CEST)
Date: Sun, 14 Sep 2014 13:57:45 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Boris Egorov <egorov@linux.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: fix cppcheck warnings
Message-ID: <20140914115745.GA20978@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Boris Egorov!

I spotted something in your patch that doesn't look right to me.

[...]
> --- a/sys-utils/lscpu-dmi.c
> +++ b/sys-utils/lscpu-dmi.c
> @@ -161,7 +161,7 @@ static int hypervisor_from_dmi_table(uint32_t base, uint16_t len,
>  	else if (manufacturer && strstr(manufacturer, "HITACHI") &&
>  					product && strstr(product, "LPAR"))
>  		rc = HYPER_HITACHI;
> -	else if (!vendor && strcmp(vendor, "Parallels"))
> +	else if (vendor && strcmp(vendor, "Parallels"))
                           ^
Shouldn't the ! be here? --^
(alternatively: vendor && 0 == strcmp...)

>  		rc = HYPER_PARALLELS;
>  done:
>  	free(buf);
[...]


Regards,
Andreas Henriksson
