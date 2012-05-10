Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52213 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758102Ab2EJJqL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 May 2012 05:46:11 -0400
Date: Thu, 10 May 2012 11:46:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] fdisk: fix segfault on bsd label
Message-ID: <20120510094607.GA25706@x2.net.home>
References: <1336131332.17719.1.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336131332.17719.1.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 04, 2012 at 01:35:32PM +0200, Davidlohr Bueso wrote:
>  fdisk/fdisk.c         |    2 ++
>  fdisk/fdiskdoslabel.c |    2 +-
>  fdisk/fdiskdoslabel.h |    1 +
>  3 files changed, 4 insertions(+), 1 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
