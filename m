Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.10]:52706 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbaHUO5C (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Aug 2014 10:57:02 -0400
Message-ID: <53F608BA.4080401@bernhard-voelker.de>
Date: Thu, 21 Aug 2014 16:56:58 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Dave Reisner <dreisner@archlinux.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] mountpoint: drop S_ISDIR check
References: <1408625292-2445-1-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1408625292-2445-1-git-send-email-dreisner@archlinux.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/21/2014 02:48 PM, Dave Reisner wrote:
> Files can be mountpoints, too.

just out of curiosity - how?

 $ touch /tmp/mountpoint
 $ mount -t proc proc /tmp/mountpoint
 mount: mount point /tmp/mountpoint is not a directory

Thanks & have a nice day,
Berny

