Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31041 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294Ab2DJLYT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Apr 2012 07:24:19 -0400
Date: Tue, 10 Apr 2012 13:24:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/3] fdisk: use randutils for mbr signature creation
Message-ID: <20120410112416.GM19784@x2.net.home>
References: <1333662727.2696.5.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333662727.2696.5.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 05, 2012 at 11:52:07PM +0200, Davidlohr Bueso wrote:
>  fdisk/Makefile.am |    1 +
>  fdisk/fdisk.c     |   51 +++++----------------------------------------------
>  2 files changed, 6 insertions(+), 46 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
