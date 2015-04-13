Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59656 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753489AbbDMKbS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Apr 2015 06:31:18 -0400
Date: Mon, 13 Apr 2015 12:31:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Sergey Zolotarev <szx@live.ru>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: Fix partition order killed my hard drive (twice)
Message-ID: <20150413103115.GO3923@ws.net.home>
References: <DUB119-W10D0E142F9CF92AA8A3436B4E70@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <DUB119-W10D0E142F9CF92AA8A3436B4E70@phx.gbl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 13, 2015 at 04:11:05PM +0600, Sergey Zolotarev wrote:
> Is it possible that fdisk could damage / kill a hard drive after
> using the "Fix partition order" command? It seems that that is
> exactly what happened to me two times already, with two different
> hard drives. 

Do you really believe that write some bytes to HDD may destroy the
device? I don't think so. 

fdisks-like utils just write some data to the device, nothing else.
You can replace it by dd(1) or "echo 'something' > /dev/sda"...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
