Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5397 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259Ab2GXMVZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 08:21:25 -0400
Date: Tue, 24 Jul 2012 14:21:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] fdisk: de-duplicate disk label strings
Message-ID: <20120724122121.GI736@x2.net.home>
References: <500E8653.8050604@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <500E8653.8050604@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 24, 2012 at 01:26:11PM +0200, Bernhard Voelker wrote:
>  fdisks/fdisk.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

 Hmm.. applied and reverted (this happen if your fingers are faster
 than your brain..).

 The xxx_label structs will be completely encapsulated in libfdisk and
 inaccessible for applications (like fdisk.c).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
