Return-Path: <SRS0=iT9e=OB=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C670C43441
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 10:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D455520870
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 10:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D455520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390798AbeKVVLM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:11:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbeKVVLM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Nov 2018 16:11:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7A7846289;
        Thu, 22 Nov 2018 10:32:22 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11A434AA;
        Thu, 22 Nov 2018 10:32:21 +0000 (UTC)
Date:   Thu, 22 Nov 2018 11:32:19 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Andreas Henriksson <andreas@fatal.se>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC/PATCH] Add hardening settings to uuidd.service
Message-ID: <20181122103219.atqj725ahcqg2n7p@ws.net.home>
References: <20181112211031.21996-1-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112211031.21996-1-andreas@fatal.se>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 22 Nov 2018 10:32:23 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Nov 12, 2018 at 10:10:31PM +0100, Andreas Henriksson wrote:
> diff --git a/misc-utils/uuidd.service.in b/misc-utils/uuidd.service.in
> index 45f1f7334..dd38b645c 100644
> --- a/misc-utils/uuidd.service.in
> +++ b/misc-utils/uuidd.service.in
> @@ -17,8 +17,7 @@ ProtectKernelModules=yes
>  ProtectControlGroups=yes
>  RestrictAddressFamilies=AF_UNIX
>  MemoryDenyWriteExecute=yes
> -SystemCallFilter=@default @file-system @basic-io @system-service @signal @io-eve
> -nt @network-io
> +SystemCallFilter=@default @file-system @basic-io @system-service @signal @io-event @network-io


Not sure, maybe I have miss some another your patch or you forgot to
send any patch, but we have no Protect* and Restrict* setting in the
uuidd.service.in yet. The current upstream is:

 https://github.com/karelzak/util-linux/blob/master/misc-utils/uuidd.service.in

:-)

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
