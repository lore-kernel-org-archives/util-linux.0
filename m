Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE97C77B7C
	for <util-linux@archiver.kernel.org>; Sun, 21 May 2023 18:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjEUSJE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 21 May 2023 14:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjEUSGc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 21 May 2023 14:06:32 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E075F9
        for <util-linux@vger.kernel.org>; Sun, 21 May 2023 11:06:30 -0700 (PDT)
Date:   Sun, 21 May 2023 20:06:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684692389; bh=HbupnYFQHPkXWA+48Xy0pi1jzBc26SkLEogX84OCp8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jehn0zOJwUrLPMSstmZVKw5Cp0N8rcmlCiozFMptB9H2/CvpxPSUBTuQgF77EsOpG
         eGq5wS7Fq3Qt4yC6eU8ru8Hl9UqlkVKdszOcSAbBAUYV6L+VwtV+B5LDy3WfebgYJk
         mGRg8hFEmU49q7P76HfLX4swxoTtmVNkgubgQyd4=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Quentin Rameau <quinq@fifth.space>
Cc:     util-linux@vger.kernel.org
Subject: Re: mount: sshfs problem with "defaults" option after 2.39 upgrade
Message-ID: <b71959fa-899b-411e-9937-d29689999111@t-8ch.de>
References: <20230521181814.0b0f2d38.quinq@fifth.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521181814.0b0f2d38.quinq@fifth.space>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Quentin,

On 2023-05-21 18:18:14+0200, Quentin Rameau wrote:
> Hi,
> 
> I just updated util-linux to 2.39 from 2.38.1 (on Alpine Linux),
> and new mount triggers an error for an old sshfs fstab mount entry,
> that was working until now.
> 
> The line in question is:
> 
> user@host:path /media/ssh/path sshfs defaults,nosuid,nodev,noexec,noatime,noauto,_netdev,user,idmap=user,allow_other,rec 0 0
> 
> and fails with:
> 
> $ mount /media/ssh/path
> fuse: unknown option(s): `-o defaults'
> 
> I can see in the trace that "defaults" is actually passed to the helper
> 
> 30906 execve("/sbin/mount.sshfs", ["/sbin/mount.sshfs", "user@host:path", "/media/ssh/path", "-o", "rw,defaults,noatime,_netdev,...", <truncated here>
> 
> And running it with LIBMOUNT_DEBUG=all shows
> 
> 30933: libmount:   UPDATE: 30933: libmount:       FS: synced: vfs: 'rw,noatime,nodev,nosuid,noexec' fs: 'idmap=user,allow_other,reconnect' user: 'defaults,noauto,_netdev,, optstr: 'rw,defaults,noatime,noauto,_netdev,user=quinq,nodev,nosuid,noexec,allow_other,reconnect'
> [...]
> optstr: rw,defaults,noatime,noauto,_netdev,nodev,nosuid,noexec,idmap=user,allow_other,reconnect
> VFS-optstr: rw,noatime,nodev,nosuid,noexec
> FS-opstr: idmap=user,allow_other,reconnect
> user-optstr: defaults,noauto,_netdev
> 
> The "defaults" option is stripped from the analog traces with mount 2.38.1

Could you try https://github.com/util-linux/util-linux/pull/2250 ?


Thomas
