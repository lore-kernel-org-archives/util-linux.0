Return-Path: <SRS0=iT9e=OB=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5A6C43441
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 10:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1173320865
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 10:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1173320865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbeKVVSB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:18:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729929AbeKVVSB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Nov 2018 16:18:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49AA081DF0;
        Thu, 22 Nov 2018 10:39:11 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54C665DD86;
        Thu, 22 Nov 2018 10:39:10 +0000 (UTC)
Date:   Thu, 22 Nov 2018 11:39:07 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] rfkill: Add systemd integration
Message-ID: <20181122103907.vwjf6uprlxzthd7e@ws.net.home>
References: <0ad9b6ea-0d46-5ec5-1bfc-0e48be52dae8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad9b6ea-0d46-5ec5-1bfc-0e48be52dae8@suse.cz>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 22 Nov 2018 10:39:11 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 21, 2018 at 09:04:37PM +0100, Stanislav Brabec wrote:
> Add rfkill-block@.service and rfkill-unblock@.service templates.
> These make rfkill integration to systemd easier.
> 
> Files come from openSUSE rfkill package.
> 
> Example:
> Use `systemctl {start,stop} rfkill-block@bluetooth` to block or unblock
> (disable or enable) the bluetooth device.

OK, but why? ;-)

Does anything within systemd depend on rfkill? I guess for humans is
more friendly to call "rfkill unblock bluetooth" than use systemctl.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
