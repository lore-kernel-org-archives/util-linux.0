Return-Path: <SRS0=2g+Q=UD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A84EC282CE
	for <util-linux@archiver.kernel.org>; Tue,  4 Jun 2019 11:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAF8247CB
	for <util-linux@archiver.kernel.org>; Tue,  4 Jun 2019 11:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfFDLKl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:10:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfFDLKk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 4 Jun 2019 07:10:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92C8AA3EA1;
        Tue,  4 Jun 2019 11:10:40 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF3182B5AE;
        Tue,  4 Jun 2019 11:10:39 +0000 (UTC)
Date:   Tue, 4 Jun 2019 13:10:35 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Petr Pisar <petr.pisar@atlas.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: Mistakes in message strings
Message-ID: <20190604111035.45rdqrl5pce4pcsu@ws.net.home>
References: <20190601142701.GL3522@album.bayer.uni.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190601142701.GL3522@album.bayer.uni.cx>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 04 Jun 2019 11:10:40 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jun 01, 2019 at 04:27:02PM +0200, Petr Pisar wrote:
> while updating Czech translation for util-linux-2.34-rc2 I spotted these
> issues in the message strings:

Thanks for your feedback!

I have always doubts when fix messages issues -- before the release it
means that some already translated strings will be untranslated; and
after the release it means we will release with known mistakes.

Anyway, after release it seems as better from my point of view.

    Karel

> 
> # FIXME: Remove a trailing period
> #: login-utils/lslogins.c:1345
> msgid ""
> " -p, --pwd                display information related to login by password.\n"
> 
> # FIXME "user" should read "group"
> #: sys-utils/setpriv.c:139
> msgid " --rgid <gid|user>           set real gid\n"
> 
> # FIXME: Missing a comma between options
> #: term-utils/agetty.c:2352
> msgid " -J  --noclear              do not clear the screen before prompt\n"
> 
> # FIXME: Missing a comma between options
> #: term-utils/agetty.c:2357
> msgid " -N  --nonewline            do not print a newline before issue\n"
> 
> # FIXME: typo in "is possible", should be "if possible"
> #: misc-utils/findmnt.c:1246
> msgid "     --tree             enable tree format output is possible\n"
> 
> 
> Moreover, I have difficulies in translating this message:
> 
> #: misc-utils/hardlink.c:363 text-utils/pg.c:1263
> msgid "saved"
> 
> because each of the location requires a different translation in Czech
> language ("stored" versus "spared"). Please either add a gettext context or,
> better, duplicate the messages:
> 
> # First argument is "Would link" or "Linked".
> #: misc-utils/hardlink.c:354
> #, c-format
> msgid " %s %s to %s\n"
> 
> into:
> 
> msgid " Would link %s to %s\n"
> msgid " Linked %s to %s\n"
> 
> and duplicate this:
> 
> # First argument is "Would link" or "Linked".
> # Second and third ones are file names.
> # Fourth one is "would save" or "saved".
> #: misc-utils/hardlink.c:360
> #, c-format
> msgid " %s %s to %s, %s %jd\n"
> 
> into:
> 
> msgid " Would link %s to %s, would save %jd\n"
> msgid " Linked %s to %s, saved %jd\n"
> 
> I believe it will make the messages more undestandible and easier to
> translate also in other languages.
> 
> -- Petr



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
