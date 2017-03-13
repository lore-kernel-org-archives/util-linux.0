Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbdCMLli (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 Mar 2017 07:41:38 -0400
Date: Mon, 13 Mar 2017 12:41:35 +0100
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: ideas of what lib might be missing?  (2.29.2 has missing symbols
 @ link)
Message-ID: <20170313114135.riuh2pahfs3v4jkp@ws.net.home>
References: <58C3F064.4060904@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <58C3F064.4060904@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Mar 11, 2017 at 04:41:08AM -0800, L A Walsh wrote:
> I thought 'configure' was supposed to test for what was present
> and what was missing?  Seems to have missed a few... :-(

 Please, send complete step by step way how to reproduce the problem
 (used commands and output).

> Was wondering what library I might be missing? or why they
> are being referenced when 'whatever library' they are in,
> evidently isn't on my system...  configure bug?

 It's lib/ stuff in the package, nothing external.

> array enable=(                fs-paths-default
>                last libmount-support-mtab line
>                newgrp
>                reset
>                static-programs=mount sulogin-emergency-mount
>                vipw write
> )
> array disable=( assert nls pylibmount )
> array with=(    audit
>                bashcompletiondir=/usr/share/bash-completion
>                gnu-ld
>                readline
> )
> array without=( python )

 This copy & past from some build system, or what? It would be better
 to have ./configure command line.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
