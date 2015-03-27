Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33777 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407AbbC0OPy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Mar 2015 10:15:54 -0400
Date: Fri, 27 Mar 2015 15:15:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk: readline support
Message-ID: <20150327141552.GO1749@ws.net.home>
References: <201503271327.43178.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201503271327.43178.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 27, 2015 at 01:27:43PM +0100, Ruediger Meier wrote:
> sfdisk: MBR                            ...
>     : simple-commas               ... OK
>     : activate                    ... OK
>     : simple-space                ... OK
>     : read-dump                   ... FAILED (sfdisk/dos-read-dump)
>     : write-dump                  ... OK
>     : explicit-size               ... FAILED (sfdisk/dos-explicit-size)
>   ... FAILED (2 from 6 sub-tests)
> sfdisk: GPT                            ...
>     : all-defaults                ... FAILED (sfdisk/gpt-all-defaults)
>     : uuid                        ... OK
>     : label                       ... OK
>     : type                        ... OK
>     : attrs                       ... OK
>     : read-dump                   ... FAILED (sfdisk/gpt-read-dump)
>     : write-dump                  ... OK
>     : list-pmbr                   ... OK
>   ... FAILED (2 from 8 sub-tests)

 Fixed, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
