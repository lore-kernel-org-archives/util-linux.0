Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:62797 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354AbbELGsH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 May 2015 02:48:07 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] libfdisk: (gpt) fix attributes endianess
Date: Tue, 12 May 2015 08:47:40 +0200
Cc: util-linux@vger.kernel.org, Michael Marineau <michael.marineau@coreos.com>
References: <1431085193-1509-1-git-send-email-sweet_f_a@gmx.de> <20150511102545.GM27969@ws.net.home>
In-Reply-To: <20150511102545.GM27969@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201505120847.40612.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 11 May 2015, Karel Zak wrote:
> On Fri, May 08, 2015 at 01:39:53PM +0200, Ruediger Meier wrote:
> > The new libfdisk/gpt test (4a4a0927) discovered that we read and
> > write partition attributes wrongly on BE systems.
>
> It was pretty hidden bug (as the problem was in the both set/get
> functions).

BTW maybe we could add the new raw attributes interface to sfdisk too. 
Like
$ ./sfdisk --part-attrs img 1 "0x0000000000000001"
(and also for stdin text input)

This would make sfdisk forward compatible (in case they invent new 
attributes) and we could remove test_fdisk_gpt helper again.

cu,
Rudi
