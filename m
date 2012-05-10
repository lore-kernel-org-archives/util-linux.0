Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60022 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758629Ab2EJJxt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 May 2012 05:53:49 -0400
Date: Thu, 10 May 2012 11:53:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 5/5] fdisk: sgi: abort on HDIO_GETGEO failure
Message-ID: <20120510095323.GB30118@x2.net.home>
References: <1336306225.2685.14.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336306225.2685.14.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 06, 2012 at 02:10:25PM +0200, Davidlohr Bueso wrote:
>  fdisk/fdisksgilabel.c |   39 ++++++++++++++++++++-------------------
>  1 files changed, 20 insertions(+), 19 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
