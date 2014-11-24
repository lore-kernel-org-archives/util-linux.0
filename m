Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55550 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbaKXPqM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Nov 2014 10:46:12 -0500
Date: Mon, 24 Nov 2014 16:46:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Drake Wilson <drake@dasyatidae.net>, util-linux@vger.kernel.org,
        770211@bugs.debian.org
Subject: Re: LUKS partition types, redux
Message-ID: <20141124154604.GA2610@x2.net.home>
References: <546D0495.2030803@dasyatidae.net>
 <20141124113733.GC926@x2.net.home>
 <547343EA.6090606@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547343EA.6090606@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 24, 2014 at 09:42:50AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/24/2014 6:37 AM, Karel Zak wrote:
> > The current trend is to use partition type to define for what
> > purpose we want to use the partition (for example "this is /home") 
> > independently on partition format.
> 
> I wouldn't call this bone headed idea of redhat's a trend.  Using
> partition table type codes to decide to auto mount in particular parts
> of the filesystem is such a brain damaged idea, those who thought it
> up need beaten with a clue-by-four and its use needs to be *strongly*
> discouraged.

 well, it's designed for auto-generated fstab-less systems like
 containers/virt images, etc. I'm not big fan of this feature, but for
 some use cases it makes sense. (And it's systemd upstream decision.)

 Anyway, use partition type for "usage" makes more sense than for "fs-type".

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
