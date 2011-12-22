Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp14.ono.com ([62.42.230.176]:11725 "EHLO resmaa14.ono.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752683Ab1LVCeB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Dec 2011 21:34:01 -0500
Date: Thu, 22 Dec 2011 03:33:54 +0100
From: Guillem Jover <guillem@hadrons.org>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 4/5] fdisk: remove packed definitions
Message-ID: <20111222023354.GB31045@gaara.hadrons.org>
References: <1324388527.3316.10.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324388527.3316.10.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi!

On Tue, 2011-12-20 at 14:42:07 +0100, Davidlohr Bueso wrote:
> @@ -26,12 +26,6 @@
>  #define cround(n)	(display_in_cyl_units ? ((n)/units_per_sector)+1 : (n))
>  #define scround(x)	(((x)+units_per_sector-1)/units_per_sector)
>  
> -#if defined(__GNUC__) && (defined(__arm__) || defined(__alpha__))
> -# define PACKED __attribute__ ((packed))
> -#else
> -# define PACKED
> -#endif
> -
>  struct partition {
>  	unsigned char boot_ind;         /* 0x80 - active */
>  	unsigned char head;             /* starting head */

Why not merge this commit with the previous one? They are for the same
logical change, and otherwise it termporarily introduces a warning.

regards,
guillem
