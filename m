Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751783AbeBZWuK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Feb 2018 17:50:10 -0500
Date: Mon, 26 Feb 2018 23:50:06 +0100
From: Karel Zak <kzak@redhat.com>
To: "John Groves (jgroves)" <jgroves@micron.com>
Cc: Ruediger Meier <ruediger.meier@ga-group.nl>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [EXT] Re: ready for v2.32 ?
Message-ID: <20180226225006.rslgrlgsmphsyhqh@ws.net.home>
References: <201802262216.01925.ruediger.meier@ga-group.nl>
 <20180226222021.tvjznf3w7qzsyafg@ws.net.home>
 <1519685049171.25700@micron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519685049171.25700@micron.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 26, 2018 at 10:44:12PM +0000, John Groves (jgroves) wrote:
> Doh! Mpool stores its metadata as little endian, and rigorously uses
> le32_to_cpu and the like to move on-media structures to & from
> memory.
> 
> le32_to_cpu(osd->osb_cksum1) would be the correct way to handle it.

Fixed. Thanks for quick reply!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
