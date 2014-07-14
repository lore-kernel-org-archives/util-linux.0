Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23481 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754492AbaGNNHZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 09:07:25 -0400
Date: Mon, 14 Jul 2014 15:07:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: fdisk -b segfaults
Message-ID: <20140714130715.GA30288@x2.net.home>
References: <53BA8537.2090504@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53BA8537.2090504@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 07, 2014 at 01:32:07PM +0200, Bernhard Voelker wrote:
>   $ ~/util-linux/fdisk -b 4096 xxx
... 
>   Device does not contain a recognized partition table.
>   Segmentation fault

 Fixed, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
