Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11716 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbaDRJxR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Apr 2014 05:53:17 -0400
Date: Fri, 18 Apr 2014 11:53:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk partition reorder fails
Message-ID: <20140418095313.GI5786@x2.net.home>
References: <20140402164925.GA13910@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140402164925.GA13910@aepfle.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 02, 2014 at 06:49:25PM +0200, Olaf Hering wrote:
> 
> This is fdisk from openSUSE 13.1. I have added partitions 15+ with
> parted. Once I'm done with repartitioning, I wanted to sort the
> partitions with fdisk like I have done it in the past. Too bad, this
> fails with the version included. The start sector is all scrambled and
> outside the disk. Lukily, this time I did not write it to disk.
> 
> Looks like 2.24.1, included in Factory, is still broken.

Fixed, thanks for your report!

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
