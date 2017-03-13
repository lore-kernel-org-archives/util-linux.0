Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752900AbdCMOjb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 Mar 2017 10:39:31 -0400
Date: Mon, 13 Mar 2017 15:39:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/13] pull: warnings fixes and blkid translations
Message-ID: <20170313143926.hf5os4qxmxyvinz7@ws.net.home>
References: <20170305205232.24030-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 05, 2017 at 08:52:19PM +0000, Sami Kerola wrote:
> Sami Kerola (13):
>   misc: stop mixing declarations and code
>   libmount: fix use of preprocessor identifier
>   libblkid: avoid overflow when initializing array
>   libblkid: ensure uninitialized variable is not used [clang]
>   blkid: add curly braces to do-while statement
>   blkid: add messages to translations

Applied.

>   blkid: define output names only once
>   blkid: improve coding style

Not applied.

>   include: fix compiler warning

Applied.

>   libfdisk: dos: fix potential null pointer dereferences
>   libfdisk: fix potentially null

Applied a little different version.

>   docs: improve boilerplate.c options example

Applied.

>   lib/colors: assert rathen than overflow

Applied fixed version.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
