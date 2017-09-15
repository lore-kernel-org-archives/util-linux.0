Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbdIOLds (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 15 Sep 2017 07:33:48 -0400
Date: Fri, 15 Sep 2017 13:33:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] uuidparse: fix stack-buffer-overflow [asan]
Message-ID: <20170915113344.qht5ybljy5hfcqhp@ws.net.home>
References: <20170911195717.817-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170911195717.817-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 11, 2017 at 08:57:14PM +0100, Sami Kerola wrote:
> ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffee13b8f05 at
> pc 0x55debcc9fda4 bp 0x7ffee13b8d70 sp 0x7ffee13b8520
> WRITE of size 38 at 0x7ffee13b8f05 thread T0
>     #0 0x55debcc9fda3 in scanf_common(void*, int, bool, char const*, __va_list_tag*) (/home/src/util-linux/.libs/lt-uuidparse+0x63da3)
>     #1 0x55debcca077b in vscanf (/home/src/util-linux/.libs/lt-uuidparse+0x6477b)
>     #2 0x55debcca085f in scanf (/home/src/util-linux/.libs/lt-uuidparse+0x6485f)
>     #3 0x55debcd50fad in print_output /home/src/util-linux/misc-utils/uuidparse.c:284:10
>     #4 0x55debcd4fcc5 in main /home/src/util-linux/misc-utils/uuidparse.c:355:2
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  misc-utils/uuidparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/misc-utils/uuidparse.c b/misc-utils/uuidparse.c
> index 5fa34b23d..3347dc0af 100644
> --- a/misc-utils/uuidparse.c
> +++ b/misc-utils/uuidparse.c
> @@ -279,7 +279,7 @@ static void print_output(struct control const *const ctrl, int argc,
>  		fill_table_row(tb, argv[i]);
>  
>  	if (i == 0) {
> -		char uuid[UUID_STR_LEN];
> +		char uuid[UUID_STR_LEN + 1];
>  
>  		while (scanf(" %" stringify_value(UUID_STR_LEN)

 It seems better to use "%36[" because the uuid size is really
 36+\0.

 Fixed, good catch.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
