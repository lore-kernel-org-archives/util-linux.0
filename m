Return-Path: bensberg@justemail.net
Message-Id: <1406487424.22794.146193409.16E8F3E3@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20140721234936.GH17373@x2.net.home>
References: <53CCADA9.3020703@bernhard-voelker.de>
 <20140721082859.GD17373@x2.net.home>
 <1405977369.18035.144118445.737362A9@webmail.messagingengine.com>
 <53CD86FC.7000808@bernhard-voelker.de>
 <1405981133.2561.144137253.6000B5B5@webmail.messagingengine.com>
 <20140721234936.GH17373@x2.net.home>
Subject: Re: mount.8: mtab as symlink
Date: Sun, 27 Jul 2014 20:57:04 +0200
List-ID: <util-linux.vger.kernel.org>


On Tue, Jul 22, 2014, at 01:49, Karel Zak wrote:
> On Tue, Jul 22, 2014 at 12:18:53AM +0200, Benno Schulenberg wrote:
> > By the way, Karel, what are these 'helper=' and 'uhelper=' things
> > that are mentioned in umount.8?  Shouldn't these be mentioned in
> > mount.8 too, and more extensively? 
> 
> Not sure, it's implemented for very special purpose when udisks mount
> a device that should be umounted again by udisks. I don't think we
> want to do any advertisement for this functionality.

So... should it be removed from the man page of umount too?
If so, the third patch in the upcoming series does that.

Benno

-- 
http://www.fastmail.fm - Access all of your messages and folders
                          wherever you are
