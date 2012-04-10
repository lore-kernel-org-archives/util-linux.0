Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45072 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103Ab2DJKXf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Apr 2012 06:23:35 -0400
Date: Tue, 10 Apr 2012 12:23:31 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] fdisk: move kernel geometry into blkdev
Message-ID: <20120410102331.GA19784@x2.net.home>
References: <1333558884.2573.4.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333558884.2573.4.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 04, 2012 at 07:01:24PM +0200, Davidlohr Bueso wrote:
>  fdisk/fdisk.c    |   15 +--------------
>  include/blkdev.h |    3 +++
>  lib/blkdev.c     |   23 +++++++++++++++++++++++
>  3 files changed, 27 insertions(+), 14 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
