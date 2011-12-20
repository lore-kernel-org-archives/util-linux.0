Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1025 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407Ab1LSNOp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 Dec 2011 08:14:45 -0500
Date: Tue, 20 Dec 2011 14:14:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Roger Leigh <rleigh@codelibre.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Add mount option for initramfs
Message-ID: <20111220131440.GE22739@n.net.home>
References: <20111216231538.GR17458@codelibre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111216231538.GR17458@codelibre.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 16, 2011 at 11:15:38PM +0000, Roger Leigh wrote:
>    { "nofail",	0, 0, MS_COMMENT},	/* Do not fail if ENOENT on dev */
> +  { "initramfs", 0, 0, MS_COMMENT},     /* Mount filesystem in initramfs */

 I don't think this is the right way. We have to be very conservative
 with new mount options, especially with options specific for any
 use case.

 You can use comment=initramfs and in new mount(8) will be also
 supported x-* options, then you can use x-initrd or so.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
