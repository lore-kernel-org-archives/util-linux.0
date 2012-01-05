Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62038 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932728Ab2AEQ3h (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Jan 2012 11:29:37 -0500
Date: Thu, 5 Jan 2012 17:29:34 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/5] sfdisk: do not depend on arch for packed attribute
Message-ID: <20120105162934.GC11073@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325718131.7056.6.camel@offbook>
 <1325718126.7056.5.camel@offbook>
 <1325716139.7056.1.camel@offbook>
 <1324994959-24298-1-git-send-email-gaowanlong@cn.fujitsu.com>
 <1324388527.3316.10.camel@offbook>
 <1324388525.3316.9.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 20, 2011 at 02:42:05PM +0100, Davidlohr Bueso wrote:
>  fdisk/sfdisk.c |    9 ---------
>  include/c.h    |    3 +++
>  2 files changed, 3 insertions(+), 9 deletions(-)

On Tue, Dec 20, 2011 at 02:42:07PM +0100, Davidlohr Bueso wrote:
>  fdisk/fdisk.h |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)

  I have removed the PACKED macro at all and used __attribute__
  keyword in the code.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
