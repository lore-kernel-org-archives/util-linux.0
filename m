Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38443 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754505AbaKNJLv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 14 Nov 2014 04:11:51 -0500
Date: Fri, 14 Nov 2014 10:11:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Boris Egorov <egorov@linux.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: fix get_partition_unused_primary()
Message-ID: <20141114091148.GE6704@x2.net.home>
References: <1415942836-1248-1-git-send-email-egorov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415942836-1248-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 14, 2014 at 11:27:16AM +0600, Boris Egorov wrote:
> Now function takes address to variable and fills it with partition
> number. Caller treats return value as int and use it appropriately.

Yep, it's better. 

>  static int get_partition_unused_primary(struct fdisk_context *cxt,
...
> +	*partno = rc == 0 ? n : rc;
        ^^^^^^^^^^^
I have replaced this line with

 if (rc == 0)
    *partno = n;

it seems we don't have to mix partno and return codes here at all.

> +	return 0;

 return rc;


 Applied, thanks!

    Karel
    

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
