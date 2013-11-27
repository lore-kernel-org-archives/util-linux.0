Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16897 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905Ab3K0O6z (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 27 Nov 2013 09:58:55 -0500
Date: Wed, 27 Nov 2013 15:58:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Marc MERLIN <marc@merlins.org>, util-linux@vger.kernel.org
Subject: Re: Severe fdisk problem leading to data loss?
Message-ID: <20131127145840.GB32483@x2.net.home>
References: <20131118102051.GA31813@merlins.org>
 <20131124135226.GH11389@merlins.org>
 <20131125103124.GQ5572@x2.net.home>
 <529605B7.3020903@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <529605B7.3020903@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 27, 2013 at 09:46:15AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/25/2013 5:31 AM, Karel Zak wrote:
> > This is definitely bug too, because Linux does not care about 
> > partition type and kernel is able to use this partition:
> 
> Isn't the bug actually in the kernel, not parted?  An ID of zero means
> the slot is unused, so it shouldn't be paying any attention to the
> start and length.

 After 20 years it's feature ;-) as I'm almost sure that we cannot fix
 it and disable all partition where is no the ID. 
 
 And Linux kernel have never cared about partition type (this is not
 specific to MBR, the same behaviour we have for Sun, SGI, MAC, BSD,
 ..), only PT where we care is GPT (zero GUID is ignored).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
