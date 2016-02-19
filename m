Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55982 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1428060AbcBSQCd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 19 Feb 2016 11:02:33 -0500
Date: Fri, 19 Feb 2016 17:02:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: again errno usage, today: strutils.c
Message-ID: <20160219160231.mw7634wyeamtnc7d@ws.net.home>
References: <201602191206.36635.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201602191206.36635.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 19, 2016 at 12:06:36PM +0100, Ruediger Meier wrote:
> But I want to ask whether it would be a good idea to make the message 
> generally less verbose:
> 
> -   if (errno)
> +   if (errno == ERANGE)
> 
> On other systems strtoul(3p) would return EINVAL too for case --id="XX" 
> but EINVAL has no useful information here:
> 
>   test_logger: failed to parse id: 'XX': Invalid argument
> 
> This would not change anything on Linux/c99 as strtoul(3) only set 
> ERANGE there.

  Sound good. Go ahead, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
