Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64742 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970AbaE1HTw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 28 May 2014 03:19:52 -0400
Date: Wed, 28 May 2014 09:19:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 2/2] Don't ignore EBUSY in losetup when the loop device
 is given
Message-ID: <20140528071949.GD385@x2.net.home>
References: <1401215897.15260.28.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401215897.15260.28.camel@oct.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 27, 2014 at 08:38:17PM +0200, Stanislav Brabec wrote:
>  sys-utils/losetup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
