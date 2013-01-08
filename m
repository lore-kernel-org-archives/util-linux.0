Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:53598 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab3AHQEw convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Jan 2013 11:04:52 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1Tsbfk-0001j4-Gf
	for util-linux@vger.kernel.org; Tue, 08 Jan 2013 17:05:04 +0100
Received: from netkingxp.iwf.ing.tu-bs.de ([134.169.61.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 08 Jan 2013 17:05:04 +0100
Received: from G.Gersdorf by netkingxp.iwf.ing.tu-bs.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 08 Jan 2013 17:05:04 +0100
To: util-linux@vger.kernel.org
From: =?ISO-8859-1?Q?G=FCnter_Gersdorf?= <G.Gersdorf@tu-bs.de>
Subject: Re: Btrfs: wipe all the superblock [redhat bugzilla 889888]
Date: Tue, 08 Jan 2013 16:48:44 +0100
Message-ID: <kchf4t$scf$1@ger.gmane.org>
References: <50E9C267.3050302@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <50E9C267.3050302@inwind.it>
Cc: linux-btrfs@vger.kernel.org
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Am 06.01.2013 19:28, schrieb Goffredo Baroncelli:
>
> You can pull the change from:
> 	http://cassiopea.homelinux.net/git/util-linux.git
> from the branch
> 	btrfs-wipefs
>
After applying this patch, findfs and blkid didn't find filesystems 
smaller than 256GB, probably because there is no third superblock.

Günter


