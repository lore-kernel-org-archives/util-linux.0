Return-Path: peb@mppmu.mpg.de
Date: Fri, 2 Mar 2012 14:09:20 +0100 (CET)
From: Peter Breitenlohner <peb@mppmu.mpg.de>
To: Davidlohr Bueso <dbueso@aomail.uab.es>
cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] lslocks: add personality column
In-Reply-To: <1330693206.23371.0.camel@offworld>
Message-ID: <alpine.LNX.2.00.1203021407350.13913@pcl321.mppmu.mpg.de>
References: <1330693206.23371.0.camel@offworld>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <util-linux.vger.kernel.org>

On Fri, 2 Mar 2012, Davidlohr Bueso wrote:

> @@ -248,8 +251,9 @@ static int get_local_locks(struct list_head *locks)
> 			 * separated by ' ' - check <kernel>/fs/locks.c
> 			 */
> 			switch (i) {
> -			case 0:
> -			case 1: /* not intereted! */
> +			case 0: /* not intereted! */

should this be 'intereted' or 'interpreted'?

Regards
Peter Breitenlohner <peb@mppmu.mpg.de>
