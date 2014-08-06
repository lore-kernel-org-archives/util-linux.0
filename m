Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.131]:59456 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbaHFXC1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Aug 2014 19:02:27 -0400
Message-ID: <53E2B3FB.8050409@bernhard-voelker.de>
Date: Thu, 07 Aug 2014 01:02:19 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "Linda A. Walsh" <lkml@tlinx.org>, util-linux@vger.kernel.org
Subject: Re: Specifying a generic and per-fs mount line in /etc/fstab as well
 as no-canonicalize.
References: <53E2B27C.9020305@tlinx.org>
In-Reply-To: <53E2B27C.9020305@tlinx.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/07/2014 12:55 AM, Linda A. Walsh wrote:
> if "/usr/src" is a symlink pointing to /home/src,
> 
> and under /home/src, packages points to ../packages, then when I
> switch to /usr/src/packages, I see my path listed as /usr/src/packages:
> 
>> >  cd /usr/src/packages
> /usr/src/packages> pwd
> /usr/src/packages
> 
> Only by asking an external util can I find the real name:

OT, but: no, "pwd -P" (pwd, the shell built-in) does.

Have a nice day,
Berny

