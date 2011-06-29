Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47811 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab1F2GkQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 29 Jun 2011 02:40:16 -0400
Date: Wed, 29 Jun 2011 08:40:12 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>, khlebnikov@openvz.org
Subject: Re: [BUG] umount does not work for disconected nfs mounts
Message-ID: <20110629064012.GF6418@nb.net.home>
References: <4E098E3B.5060707@openvz.org> <20110628085724.GE22770@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110628085724.GE22770@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 28, 2011 at 10:57:24AM +0200, Petr Uzel wrote:
> > so mount /mnt/nfs get stuck, umounting by device is still possible.
> 
> We might first scan through mtab to check if umount arg is known
> mountpoint and only if we fail, we would look for associated loopfile.

 Yes, go ahead.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
