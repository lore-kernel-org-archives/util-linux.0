Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58303 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbcGNK0m (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jul 2016 06:26:42 -0400
Date: Thu, 14 Jul 2016 12:26:39 +0200
From: Karel Zak <kzak@redhat.com>
To: James Clarke <jrtc27@jrtc27.com>
Cc: util-linux@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andreas Henriksson <andreas@fatal.se>
Subject: Re: [PATCH] tests: Fix fdisk/id and fdisk/mbr-nondos-mode on Sparc
Message-ID: <20160714102639.bmp7quezbynkosdy@ws.net.home>
References: <20160714080224.37873-1-jrtc27@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160714080224.37873-1-jrtc27@jrtc27.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 14, 2016 at 09:02:24AM +0100, James Clarke wrote:
> On Sparc, fdisk defaults to using SUN disk labels, which causes the
> output from these tests to differ from non-Sparc.
> 
> Signed-off-by: James Clarke <jrtc27@jrtc27.com>
> ---
>  tests/expected/fdisk/id.sparc              |   3 +
>  tests/expected/fdisk/mbr-nondos-mode.sparc | 189 +++++++++++++++++++++++++++++
>  tests/ts/fdisk/id                          |  13 ++
>  tests/ts/fdisk/mbr-nondos-mode             |  13 ++
>  4 files changed, 218 insertions(+)

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
