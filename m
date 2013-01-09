Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:49099 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051Ab3AIIKD convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jan 2013 03:10:03 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1Tsqjp-0001jq-QC
	for util-linux@vger.kernel.org; Wed, 09 Jan 2013 09:10:17 +0100
Received: from netkingxp.iwf.ing.tu-bs.de ([134.169.61.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 09 Jan 2013 09:10:17 +0100
Received: from G.Gersdorf by netkingxp.iwf.ing.tu-bs.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 09 Jan 2013 09:10:17 +0100
To: util-linux@vger.kernel.org
From: =?ISO-8859-1?Q?G=FCnter_Gersdorf?= <G.Gersdorf@tu-bs.de>
Subject: Re: Btrfs: wipe all the superblock [redhat bugzilla 889888]
Date: Wed, 09 Jan 2013 09:09:45 +0100
Message-ID: <kcj8k7$hdl$1@ger.gmane.org>
References: <50E9C267.3050302@inwind.it> <kchf4t$scf$1@ger.gmane.org> <50EC822B.1070102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <50EC822B.1070102@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Am 08.01.2013 21:31, schrieb Goffredo Baroncelli:
> Hi Günter,
>
> On 01/08/2013 04:48 PM, Günter Gersdorf wrote:
>> Am 06.01.2013 19:28, schrieb Goffredo Baroncelli:
>>>
>>> You can pull the change from:
>>>      http://cassiopea.homelinux.net/git/util-linux.git
>>> from the branch
>>>      btrfs-wipefs
>>>
>> After applying this patch, findfs and blkid didn't find filesystems
>> smaller than 256GB, probably because there is no third superblock.
>
> In my system also the stock "findfs" and "blkid" have the same problem:
> ie without my patch these utilities were unable to detect a btrfs
> filesystem.
>
> Could you confirm that ?

Without the patch?
On my systems, after applying the patch blkid and findfs will not find 
any btrfs filesystems, even if bigger than 256GB.

Günter


