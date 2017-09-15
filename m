Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbdIOLrN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 15 Sep 2017 07:47:13 -0400
Date: Fri, 15 Sep 2017 13:47:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] libsmartcols: fix heap-buffer-overflow [asan]
Message-ID: <20170915114709.dkndevgojbfzyp5u@ws.net.home>
References: <20170911195717.817-1-kerolasa@iki.fi>
 <20170911195717.817-2-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170911195717.817-2-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 11, 2017 at 08:57:15PM +0100, Sami Kerola wrote:
> This gives room for element 0 in array of column cells.
> 
> ERROR: AddressSanitizer: heap-buffer-overflow on address 0x608000000080 at
> pc 0x5596bfaaca26 bp 0x7ffd8352a550 sp 0x7ffd83529d00
> READ of size 64 at 0x608000000080 thread T0
>     #0 0x5596bfaaca25 in __asan_memmove (/home/src/util-linux/.libs/lt-column+0xc2a25)
>     #1 0x7f8d53660d1b in scols_line_move_cells /home/src/util-linux/libsmartcols/src/line.c:164:2
>     #2 0x7f8d5366502c in scols_table_move_column /home/src/util-linux/libsmartcols/src/table.c:307:3
>     #3 0x5596bfb0214b in reorder_table /home/src/util-linux/text-utils/column.c:303:3
>     #4 0x5596bfaff7ec in modify_table /home/src/util-linux/text-utils/column.c:393:3
>     #5 0x5596bfafdbb6 in main /home/src/util-linux/text-utils/column.c:770:4
>     #6 0x7f8d52718f69 in __libc_start_main (/usr/lib/libc.so.6+0x20f69)
>     #7 0x5596bfa089b9 in _start (/home/src/util-linux/.libs/lt-column+0x1e9b9)
> 
> 0x608000000080 is located 0 bytes to the right of 96-byte region [0x608000000020,0x608000000080)
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  libsmartcols/src/line.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsmartcols/src/line.c b/libsmartcols/src/line.c
> index aa339ce38..a041eeb60 100644
> --- a/libsmartcols/src/line.c
> +++ b/libsmartcols/src/line.c
> @@ -133,7 +133,7 @@ int scols_line_alloc_cells(struct libscols_line *ln, size_t n)
>  
>  	DBG(LINE, ul_debugobj(ln, "alloc %zu cells", n));
>  
> -	ce = realloc(ln->cells, n * sizeof(struct libscols_cell));
> +	ce = realloc(ln->cells, (n + 1) * sizeof(struct libscols_cell));

The issue is scols_line_move_cells(). Fixed. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
