Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752567AbcKGNwY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 7 Nov 2016 08:52:24 -0500
Date: Mon, 7 Nov 2016 14:52:21 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] tests: always quote $LODEV
Message-ID: <20161107135221.2gpp3axq2wbo4rcn@ws.net.home>
References: <1478358489-18103-1-git-send-email-sweet_f_a@gmx.de>
 <201611071121.55542.sweet_f_a@gmx.de>
 <20161107113721.z53bvekbw3swgaxc@ws.net.home>
 <201611071348.23789.sweet_f_a@gmx.de>
 <20161107133810.2jvyfrye74d2mozi@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161107133810.2jvyfrye74d2mozi@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 07, 2016 at 02:38:10PM +0100, Karel Zak wrote:
> For example if there is way how to generate the getopt stuff by m4
> without any additional dependence, it's easy to maintain (include
> translations by .po files) then it sounds good.

BTW, does yuck generates parser where the result is always yuck
specific struct or you have control on the parsers code and the result
in your hands?

I mean something like GNU Bison (yacc) where the final parser is "syntax
description" + "your code". It would be nice to have

 -f, --foo     This is foo description
 {
    /* code to handle foo */
    mystruct->foo = 1;
    printf("Nice you send foo");
 }

 -c, --ccc     This is coo description
 {
    /* my code for ccc */
    ...
 }


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
