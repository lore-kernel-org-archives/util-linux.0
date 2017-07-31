Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:45572
        "EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdGaRwa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jul 2017 13:52:30 -0400
Date: Mon, 31 Jul 2017 19:52:27 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] build: use --runstatedir instead of --localstatedir
Message-ID: <20170731175227.GA23732@fatal.se>
References: <1501164042-27281-1-git-send-email-andreas@fatal.se>
 <20170731133156.2pk6qz7d6zmsevor@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170731133156.2pk6qz7d6zmsevor@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Karel Zak,

On Mon, Jul 31, 2017 at 03:31:56PM +0200, Karel Zak wrote:
[...]
> It seems we need somehow to support autoconf < 2.70 where is no
> $runstatedir. So, I have modified the code to use fallback
> 
>     runstatedir='${localstatedir}/run'
> 
> It also seems we need to check for unmodified $localstatedir rather
> than care about $prefix. So, I have improved the AS_CASE().
> 
> Please, git-pull from master branch and retest it with new autoconf
> and your environment. Thanks.

Thanks for picking it up and improving it. I'm quite sure that
none of your changes will affect debian/debhelper builds.

(If I find something when I find time to test it properly I'll
report back.)

The important point for debhelpers point of view is that
./configure --runstatedir is used instead of
./configure --localstatedir (and the upstream AS_CASE/AS_IF
doesn't apply here since debhelper will pass both of those
configure flags explicitly.)

Please note clearly in the upcoming release notes than anyone
explicitly using the --localstatedir flag will need to move
over to --runstatedir (or accept/rely on util-linux defaults).

Regards,
Andreas Henriksson
