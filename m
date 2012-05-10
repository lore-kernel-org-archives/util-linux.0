Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:63949 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757941Ab2EJJv6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 May 2012 05:51:58 -0400
Date: Thu, 10 May 2012 11:51:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/5] fdisk: create DOS specific write table function
Message-ID: <20120510095132.GD25706@x2.net.home>
References: <1336306221.2685.12.camel@offbook>
 <20120506181144.GB6429@skipper.site>
 <1336330965.2685.20.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336330965.2685.20.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 06, 2012 at 09:02:45PM +0200, Davidlohr Bueso wrote:
>  fdisk/fdisk.c         |   27 ++++-----------------------
>  fdisk/fdiskdoslabel.c |   25 +++++++++++++++++++++++++
>  fdisk/fdiskdoslabel.h |    1 +
>  3 files changed, 30 insertions(+), 23 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
