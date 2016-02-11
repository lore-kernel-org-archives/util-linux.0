Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40977 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbcBKLoK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 11 Feb 2016 06:44:10 -0500
Date: Thu, 11 Feb 2016 12:44:09 +0100
From: Karel Zak <kzak@redhat.com>
To: Victor Ananjevsky <ananasik@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: agetty improvement
Message-ID: <20160211114408.sciidpqksy74fcla@ws.net.home>
References: <20160127214404.14b17964b7509e4839dbf26e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160127214404.14b17964b7509e4839dbf26e@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 27, 2016 at 09:44:04PM +0200, Victor Ananjevsky wrote:
> is that possible to add a handle of esc sequences (\eXXX) to agetty in an upcomeng releases?
> there is a simple patch to do this
> 
> 
> --- util-linux-2.24/term-utils/agetty.c.orig	2013-10-10 13:44:17.000000000 +0300
> +++ util-linux-2.24/term-utils/agetty.c	2013-11-12 08:12:26.457936826 +0200
> @@ -2104,6 +2104,9 @@
>  		}
>  		break;
>  	}
> +	case 'e':
> +		printf("\033");
> +		break;

You can already use ESC sequences in the issue file, but I agree that
use \e is more readable and elegant. 

Implemented, will be in v2.28. Thanks!


Now when I think about it, we already have infrastructure to convert
color names to the real sequences. Maybe it would be nice to support
\e{red} \e{lightgreen} to keep /etc/issue files more readable.
Comments?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
