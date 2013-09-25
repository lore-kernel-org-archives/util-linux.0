Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15600 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260Ab3IYJXw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Sep 2013 05:23:52 -0400
Date: Wed, 25 Sep 2013 11:23:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <davidlohr@hp.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: report cpu min mhz
Message-ID: <20130925092349.GA29487@x2.net.home>
References: <1379821420.2145.50.camel@buesod1.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1379821420.2145.50.camel@buesod1.americas.hpqcorp.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 21, 2013 at 08:43:40PM -0700, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <davidlohr@hp.com>
> 
> The lscpu tool only shows the current and max CPU frequencies, however,
> in many scenarios this is not enough. If there are energy saving situations
> (like some CPUs being idle, or not fully used) the cpugov can lower this value.
> 
> Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
> ---
>  sys-utils/lscpu.c | 50 +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 13 deletions(-)

 Applied, thanks. (I'll update tests if necessary).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
