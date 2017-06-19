Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbdFSIlz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 04:41:55 -0400
Date: Mon, 19 Jun 2017 10:41:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] uuidparse: add new command
Message-ID: <20170619084151.nejowhp7pkeeeifd@ws.net.home>
References: <20170618172536.21544-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170618172536.21544-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 18, 2017 at 05:25:36PM +0000, Sami Kerola wrote:
> +static void uuid_unpack(const uuid_t in, struct uuid *uu)
> +time_t uuid_time(const uuid_t uu, struct timeval *ret_tv)
> +int uuid_type(const uuid_t uu)
> +int uuid_variant(const uuid_t uu)

Why? The functions are exported by library API.

The rest seems good.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
