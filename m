Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752118AbdBTMOf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 20 Feb 2017 07:14:35 -0500
Date: Mon, 20 Feb 2017 13:14:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/7] pull: make smatch scan output easy to digest
Message-ID: <20170220121426.5mr6ab6x7pxt5j4b@ws.net.home>
References: <20170213220641.1395-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170213220641.1395-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Merged, but except:

On Mon, Feb 13, 2017 at 10:06:34PM +0000, Sami Kerola wrote:
>   misc: unify function declarations [smatch scan]

I agree that some unification would be nice, but don't like

   static __attribute__((__noreturn__)) __attribute__((__format__(printf, 1, 2)))
          void log_err(const char *fmt, ...);

it would be better to keep all the attributes after declaration:

   static void log_err(const char *fmt, ...)
                    __attribute__((__noreturn__))
                    __attribute__((__format__(printf, 1, 2)));

it means new line for each attribute. IMHO it's more readable and you
don't have to search for the function name, etc.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
