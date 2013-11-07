Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50482 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867Ab3KGNLr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 7 Nov 2013 08:11:47 -0500
Date: Thu, 7 Nov 2013 14:11:42 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: blkid does not escape quotes in volume labels
Message-ID: <20131107131142.GC2853@x2.net.home>
References: <5273C1CF.8020000@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5273C1CF.8020000@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 01, 2013 at 10:59:27AM -0400, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> e2label /dev/loop0 'La"bel'
> blkid -p /dev/loop0
> /dev/loop0: LABEL="La"bel" UUID="cb71cd2a-5237-44b6-92f1-d2bff59ed688"
> VERSION="1.0" TYPE="ext2" USAGE="files
> ystem"

 Fixed, now it uses \" for quotes. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
