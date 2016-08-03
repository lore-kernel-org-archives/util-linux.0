Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47352 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757789AbcHCK40 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Aug 2016 06:56:26 -0400
Date: Wed, 3 Aug 2016 12:47:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/8] losetup: re-use loop device
Message-ID: <20160803104721.y6wyq4644bgkza76@ws.net.home>
References: <aaabe320-5552-8963-4143-989e63ae3833@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aaabe320-5552-8963-4143-989e63ae3833@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 02, 2016 at 07:55:03PM +0200, Stanislav Brabec wrote:
> Here is a patch set that is based on a "safe implementation of loop
> reuse" patch set sent three weeks ago.

I think it makes sense to reuse loop device by mount(8), because the
goal is to mount FS and mount the same FS from two device may be 
disaster, but I'm not sure about losetup. 

Would be enough to keep it stupid and exit with error if the same
backing file is already used and require --force to create duplicate
loopdev?

 if (!force && has_conflict(backing_file, ....))
    err(EXIT_FAILURE, _("%s: already associated with %s"), ....);

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
