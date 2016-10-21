Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbcJUMM6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 21 Oct 2016 08:12:58 -0400
Date: Fri, 21 Oct 2016 14:12:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Anders Kaseorg <andersk@mit.edu>
Cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] getopt: Terminate long_options even if add_long_options
 is never called
Message-ID: <20161021121256.urgiwqn564hqjquw@ws.net.home>
References: <alpine.DEB.2.10.1610191834080.52298@buzzword-bingo.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.DEB.2.10.1610191834080.52298@buzzword-bingo.mit.edu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 19, 2016 at 06:35:57PM -0400, Anders Kaseorg wrote:
> v2.26-rc1~140^2 “getopt: avoid re-terminating long_option list at
> every update” forgot to terminate the long_options list in the case
> where -l/--longoptions was not specified at all, so that
> add_long_options is never called.  The resulting garbage may crash
> getopt if any long options are provided:
> 
> $ LANG=de_DE getopt -o c -- --help
> Segmentation fault (core dumped)

I have applied a little bit different solution
https://github.com/karelzak/util-linux/commit/e1164591f7927402af8d73d340e75dbfeb06a288

> +	ctl.long_options[0].name = NULL;
> +	ctl.long_options[0].has_arg = 0;
> +	ctl.long_options[0].flag = NULL;
> +	ctl.long_options[0].val = 0;

now add_longopt(ctl, NULL, 0) always terminates the array.

Please, re-test it. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
