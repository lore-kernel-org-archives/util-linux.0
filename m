Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34671 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbaAFM4j (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 Jan 2014 07:56:39 -0500
Date: Mon, 6 Jan 2014 13:56:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Andrey Vagin <avagin@openvz.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] hexdump: initialize hex->skip
Message-ID: <20140106125635.GC31045@x2.net.home>
References: <1388151888-8999-1-git-send-email-avagin@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388151888-8999-1-git-send-email-avagin@openvz.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 27, 2013 at 05:44:48PM +0400, Andrey Vagin wrote:
>  	struct hexdump *hex = malloc (sizeof (struct hexdump));
>  	hex->length = -1;
> +	hex->skip = 0;
>  	INIT_LIST_HEAD(&hex->fshead);

 Fixed. It seems better to call calloc() rather then set all the
 fields to zero.

    Karel 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
