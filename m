Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46602 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbbAGJEI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Jan 2015 04:04:08 -0500
Date: Wed, 7 Jan 2015 10:03:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Peter Cordes <peter@cordes.ca>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fallocate: create mode 0666, that's what umask is for
Message-ID: <20150107090354.GA15715@x2.net.home>
References: <1419915737-27310-1-git-send-email-peter@cordes.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419915737-27310-1-git-send-email-peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 30, 2014 at 01:02:17AM -0400, Peter Cordes wrote:
> diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
> index 0e06524b8c5837a63230dc047233c657c50c1d7c..9af3bb8ce1492defda57cc17764197790bb34c8e 100644
> --- a/sys-utils/fallocate.c
> +++ b/sys-utils/fallocate.c
> @@ -365,7 +365,7 @@ int main(int argc, char **argv)
>  
>  	/* O_CREAT makes sense only for the default fallocate(2) behavior
>  	 * when mode is no specified and new space is allocated */
> -	fd = open(filename, O_RDWR | (!dig && !mode ? O_CREAT : 0), 0644);
> +	fd = open(filename, O_RDWR | (!dig && !mode ? O_CREAT : 0), 0666);

 Applied, but I have replaced the number with 

    S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH

 macros to keep the code more readable.

 Thanks
     Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
