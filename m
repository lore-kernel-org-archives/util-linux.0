Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57276 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbcBALSR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Feb 2016 06:18:17 -0500
Date: Mon, 1 Feb 2016 12:18:15 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: run btrfs subvol checks for "auto" fs type
Message-ID: <20160201111815.wilhso7klaiy6cio@ws.net.home>
References: <56A7DE4B.5060308@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56A7DE4B.5060308@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 26, 2016 at 09:59:55PM +0100, Stanislav Brabec wrote:
> Looking at the code, it is a safe approach. In case of btrfs, it will do
> what is needed, in case of no btrfs, btrfs_get_default_subvol_id() will
> fail, and the rest of the code is skipped.

 It's safe, but "mount -a" is going to call the btrfs ioctl or each
 "auto" fstab entry :-)

 Anyway, applied. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
