Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40643 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782Ab3KDNhh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Nov 2013 08:37:37 -0500
Date: Mon, 4 Nov 2013 14:37:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: external mount utilities and utab
Message-ID: <20131104133735.GH23604@x2.net.home>
References: <5273FF29.1090403@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5273FF29.1090403@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 01, 2013 at 03:21:13PM -0400, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> When mount runs mount.cifs, /run/mount/utab is not updated, so the
> user mount flag is lost and thus, I can't umount as the user.  Running
> mount -i works correctly.  Is this a bug in mount.cifs, or should
> mount be recording these options whether it runs the external helper
> or not?

 ah.. note, that mount.cifs is not suid on Fedora, only suid mount
 helper is mount.nfs on my machine.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
