Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758784AbdKOQhc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 Nov 2017 11:37:32 -0500
Date: Wed, 15 Nov 2017 17:37:29 +0100
From: Karel Zak <kzak@redhat.com>
To: kalle <kalle@projektwerkstatt.de>
Cc: util-linux@vger.kernel.org
Subject: Re: mount: how to identify filesystems to mount them
Message-ID: <20171115163729.ihe4vnhmxbj2jprz@ws.net.home>
References: <ff28d2dd-c527-3d5f-e804-1ce468518b83@projektwerkstatt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ff28d2dd-c527-3d5f-e804-1ce468518b83@projektwerkstatt.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 15, 2017 at 05:18:17PM +0100, kalle wrote:
> hello,
> -i think it would be good, if it would be explained shortly, what a file
> system is
> -what would be good would be an explanation, how to find out filesystem,
> label, UUID or device name of a given device...

man mount, section "Indicating the device" is not enough?

OK, I think, we can add some short note about "what filesystem is" to the
begin of the mount man page for people who accidentally booted Linux
:-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
