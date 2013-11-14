Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54027 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377Ab3KNIjP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Nov 2013 03:39:15 -0500
Date: Thu, 14 Nov 2013 09:39:12 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: external mount utilities and utab
Message-ID: <20131114083912.GA7281@x2.net.home>
References: <5273FF29.1090403@ubuntu.com>
 <20131104133735.GH23604@x2.net.home>
 <5277AA0C.70309@ubuntu.com>
 <5283C4CC.5010200@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5283C4CC.5010200@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 13, 2013 at 01:28:28PM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/4/2013 9:07 AM, Phillip Susi wrote:
> > Are you saying then that all of the helpers should now be using 
> > libmount, and taking care of the utab updates themselves rather
> > than just having mount do it?
> 
> ping... still wondering if the proper fix for this is to link
> mount.cifs with libmount and make it suid, or if mount needs fixed to
> do the utab update?

I have improved libmount (in git tree) and now it updates utab for the
helpers. 

Anyway if your mount.cifs is not suid then user= does not make sense
and you also don't have to care about utab at all. For example on
Fedora we don't have suid mount.cifs for years.

IMHO it's better to minimize number of suid binaries. I guess that 
the user= functionality has been introduced to mount regular
filesystems (ext2, ...) from removable devices.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
