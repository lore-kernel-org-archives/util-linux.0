Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53422 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076Ab2FMPBs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Jun 2012 11:01:48 -0400
Date: Wed, 13 Jun 2012 17:01:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: remove encryption options from mount and losetup?
Message-ID: <20120613150144.GE10561@x2.net.home>
References: <4FD8A950.5000906@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FD8A950.5000906@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 13, 2012 at 04:53:04PM +0200, Ludwig Nussel wrote:
> Is there any reason to still keep the encryption options in losetup and
> mount around? They look entirely useless to me. Even when using passfd
> and an external key generation function it's still broken as the key
> size is fixed at 32 byte and the last byte is always set to '\0'.
> So would a patch that removes encryption support completely be
> acceptable?

Our goal is to follow kernel, so it would be better to remove this
feature from kernel loopdev first.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
