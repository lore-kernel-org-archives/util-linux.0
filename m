Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750863AbdFTIgy (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Jun 2017 04:36:54 -0400
Date: Tue, 20 Jun 2017 10:36:49 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/12] hwclock: add usage() functions heading
Message-ID: <20170620083649.qunrwp7dsxcaspot@ws.net.home>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <68a54120-d8ad-59c2-89b6-4ccdd961300b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <68a54120-d8ad-59c2-89b6-4ccdd961300b@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 18, 2017 at 08:41:45PM -0400, J William Piggott wrote:
> -#define USAGE_MAN_TAIL(_man)   _("\nFor more details see %s.\n"), _man
> +#define USAGE_MAN_TAIL(_man)   _("\nFor more details see %s\n"), _man

What's wrong with the period?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
