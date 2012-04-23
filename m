Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22405 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754585Ab2DWK50 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Apr 2012 06:57:26 -0400
Date: Mon, 23 Apr 2012 12:57:22 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 6/8] fdisk: do not call sgi and sun code when creating a
 new dos label
Message-ID: <20120423105722.GE11847@x2.net.home>
References: <1334569487.2552.15.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334569487.2552.15.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 16, 2012 at 11:44:46AM +0200, Davidlohr Bueso wrote:
> fdisk/fdisk.c |    2 --
> 1 files changed, 0 insertions(+), 2 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
