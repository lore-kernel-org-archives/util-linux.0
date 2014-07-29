Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:17170 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbaG2KV0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Jul 2014 06:21:26 -0400
Date: Tue, 29 Jul 2014 12:21:22 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: mount.8: mtab as symlink
Message-ID: <20140729102122.GU8533@x2.net.home>
References: <53CCADA9.3020703@bernhard-voelker.de>
 <20140721082859.GD17373@x2.net.home>
 <1405977369.18035.144118445.737362A9@webmail.messagingengine.com>
 <53CD86FC.7000808@bernhard-voelker.de>
 <1405981133.2561.144137253.6000B5B5@webmail.messagingengine.com>
 <20140721234936.GH17373@x2.net.home>
 <1406487424.22794.146193409.16E8F3E3@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406487424.22794.146193409.16E8F3E3@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 27, 2014 at 08:57:04PM +0200, Benno Schulenberg wrote:
> 
> On Tue, Jul 22, 2014, at 01:49, Karel Zak wrote:
> > On Tue, Jul 22, 2014 at 12:18:53AM +0200, Benno Schulenberg wrote:
> > > By the way, Karel, what are these 'helper=' and 'uhelper=' things
> > > that are mentioned in umount.8?  Shouldn't these be mentioned in
> > > mount.8 too, and more extensively? 
> > 
> > Not sure, it's implemented for very special purpose when udisks mount
> > a device that should be umounted again by udisks. I don't think we
> > want to do any advertisement for this functionality.
> 
> So... should it be removed from the man page of umount too?
> If so, the third patch in the upcoming series does that.

 Please, no. It's described in the section where is description of the
 API between umount(8) and external helpers. IMHO 'helper=' and
 'uhelper=' makes sense there.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
