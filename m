Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53400 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbcDVLW5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Apr 2016 07:22:57 -0400
Date: Fri, 22 Apr 2016 13:22:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-safe implementation of -oloop
Message-ID: <20160422112255.idrjikem5u253kh6@ws.net.home>
References: <570D3CC7.5060809@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <570D3CC7.5060809@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 12, 2016 at 08:21:59PM +0200, Stanislav Brabec wrote:
> As it was discussed in LKML[1], kernel has no way to detect backing
> file data changes if multiple loop devices have the same backing file.
> 
> Exactly this happened if -oloop is used multiple times with the same
> source.
> 
> It could not happen in past, but with introduction of btrfs sub-volumes
> it has a perfectly legal use cases.
> 
> This patch set introduces a new behavior of -oloop:
> 
> First check, whether the same backing file with the same offset is
> already used. If yes, reuse already initialized loop device.
> 
> If not, initialize another loop device.

 Applied, thanks.

> - If the same backing file is already used for a loop device with
>   correct offset, but incorrect sizelimit, there is no solution. The
>   current implementation does not check for it.

 We need a warning/error for this.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
