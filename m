Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39789 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbaKXQKn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Nov 2014 11:10:43 -0500
Date: Mon, 24 Nov 2014 17:10:36 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Drake Wilson <drake@dasyatidae.net>, util-linux@vger.kernel.org
Subject: Re: Bug#770211: LUKS partition types, redux
Message-ID: <20141124161036.GB2610@x2.net.home>
References: <546D0495.2030803@dasyatidae.net>
 <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com>
 <546E1A16.6050102@ubuntu.com>
 <5472B7E4.4040601@dasyatidae.net>
 <547341AD.4020702@ubuntu.com>
 <547342B2.2060509@dasyatidae.net>
 <54734522.7010807@dasyatidae.net>
 <547347A1.7080402@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547347A1.7080402@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 24, 2014 at 09:58:41AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/24/2014 9:48 AM, Drake Wilson wrote:
> > To clarify, that's in the GPT list, not the MBR one.  I see that
> > the MBR one names 0x83 "Linux", at least.  Does that mean that
> > {0FC63DAF-8483-4772-8E79-3D69D8477DE4} should also be named "Linux"
> > rather than "Linux filesystem"?
> 
> Oh boy.  I hadn't noticed that util-linux had added so many silly type
> codes now that it supports GPT.  This mess really needs cleaned up.

 Well, UEFI standard defines only 3 partition type GUIDs, the rest is vendor 
 specific ..  so there is huge area for human creativity :-) 
 
 The initial source for fdisk was
    http://en.wikipedia.org/wiki/GUID_Partition_Table
 and extended by stuff from free desktop
    http://www.freedesktop.org/wiki/Specifications/DiscoverablePartitionsSpec/

 (Hmm.. someone already added dm-crypt and LUKS specific GUIDs to
  wikipedia.)

> There should just be "Linux" and that's it.  That's the only one we
> have in parted and it is quite sufficient.

 and also RAID and LVM ;-)


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
