Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:53718 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933323AbdAGUeV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 7 Jan 2017 15:34:21 -0500
Subject: Re: pull: hwclock 27 changes
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
References: <20161231214107.8658-1-kerolasa@iki.fi>
 <05e4405f-8096-9261-f9f2-d2c6b84675bc@gmx.com>
 <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ce8e9cfa-e3a0-f35e-d422-e5b417a02ac7@gmx.com>
Date: Sat, 7 Jan 2017 15:32:13 -0500
MIME-Version: 1.0
In-Reply-To: <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 01/07/2017 02:37 PM, J William Piggott wrote:
> 
> 
 +	} else {
> +		if (ctl->debug)
>  			printf(_("No usable clock interface found.\n"));
> +		warnx(_("Cannot access the Hardware Clock via "
> +			"any known method."));
> 
>>
>> warnx( indentation is wrong.
>>
> 

Forget this one, I looked at it wrong.



