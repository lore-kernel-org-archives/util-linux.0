Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39146 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974AbaKRMGR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Nov 2014 07:06:17 -0500
Date: Tue, 18 Nov 2014 13:06:06 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/6] libmount: fix memory overflow [AddressSanitizer]
Message-ID: <20141118120606.GI6704@x2.net.home>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
 <1415656195-20458-5-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415656195-20458-5-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 10, 2014 at 09:49:53PM +0000, Sami Kerola wrote:
> -		if (sscanf(line, " %128[^\n ]\n", name) != 1)
> +		if (sscanf(line, " %" stringify(sizeof(line) - 1)  "[^\n ]\n", name) != 1)
>  			continue;

 Are you really sure with this code? Did you test it?

 Your homework:

        #include <stdio.h>

        #define stringify(s) #s

        int main(int argc, char **argv)
        {
            char buf[123];
            printf("Size is:" stringify(sizeof(buf) - 1) ".\n");
            return 1;
        }

 result:

         $ make a 
         cc     a.c   -o a
         x2:~$ ./a
         Size is:sizeof(buf) - 1.


 Anyway, fixed and merged..

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
