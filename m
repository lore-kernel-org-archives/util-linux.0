Return-Path: <SRS0=LCHA=5K=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8647C1975A
	for <util-linux@archiver.kernel.org>; Wed, 25 Mar 2020 11:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89EC20722
	for <util-linux@archiver.kernel.org>; Wed, 25 Mar 2020 11:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7Rwbbfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgCYLgO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:36:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33454 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727046AbgCYLgO (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 25 Mar 2020 07:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585136173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=50XARrIbw468a1bXilGrTuLJbdiCSdD992in4i0uwc4=;
        b=D7RwbbfhfM18GAzCsP2KTv3bmmsoEFzwJ7DkIm6lB9SQ3Dwj3k9dYNG1RBnzH2BHMplXrQ
        TmTyQUuT4we1N+2sg4TTnOXP8yJd/TlXlmUrbyrMWsDHLXlyf212w8F9WBvtwmbEdrjIRe
        tU7OporiRNK9mPRrp1sguybhiQZgjKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-K5BkvAn1Pw-krHHU38c0fQ-1; Wed, 25 Mar 2020 07:36:09 -0400
X-MC-Unique: K5BkvAn1Pw-krHHU38c0fQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 342CF107ACCA;
        Wed, 25 Mar 2020 11:36:08 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB5391001DD8;
        Wed, 25 Mar 2020 11:36:06 +0000 (UTC)
Date:   Wed, 25 Mar 2020 12:36:04 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     util-linux@vger.kernel.org,
        Benno Schulenberg <bensberg@justemail.net>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Hans Holmnerg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH v2] blkzone: add open/close/finish commands
Message-ID: <20200325113604.j7qlb7zdzm2azxjm@ws.net.home>
References: <20200324100217.47549-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324100217.47549-1-damien.lemoal@wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Mar 24, 2020 at 07:02:17PM +0900, Damien Le Moal wrote:
>  sys-utils/blkzone.8 | 27 +++++++++++++++--
>  sys-utils/blkzone.c | 74 ++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 91 insertions(+), 10 deletions(-)

Applied, thanks.

>  static const struct blkzone_command commands[] = {
>  	{ "report",	blkzone_report, N_("Report zone information about the given device") },
> -	{ "reset",	blkzone_reset,  N_("Reset a range of zones.") }
> +	{ "reset",	blkzone_action, N_("Reset a range of zones.") },
> +	{ "open",	blkzone_action, N_("Open a range of zones.") },
> +	{ "close",	blkzone_action, N_("Close a range of zones.") },
> +	{ "finish",	blkzone_action, N_("Set a range of zones to Full.") }
> +};
> +
> +/*
> + * The action values must match the command index in the command array.
> + */
> +enum blkzone_action {
> +	BLK_ZONE_NO_ACTION = 0,
> +	BLK_ZONE_RESET,
> +	BLK_ZONE_OPEN,
> +	BLK_ZONE_CLOSE,
> +	BLK_ZONE_FINISH,
>  };

If you add ioctl_cmd and ioctl_name to the struct blkzone_command,
and you define commands[] as:

 commands[] = {
    { 
        .name = "report",
        .handler = blkzone_report,
        .help = N_("Report zone information about the given device") 
    },{
        .name = "reset",
        .handler = blkzone_action,
        .help = N_("Reset a range of zones."),
        .ioctl_cmd = BLKRESETZONE,
        .ioctl_name = "BLKRESETZONE"
    },
    ...
 };

than you do not need this switch() and command_action()

>  
> +	switch (command_action(ctl->command)) {
> +	case BLK_ZONE_RESET:
> +		ioctl_cmd = BLKRESETZONE;
> +		ioctl_name = "BLKRESETZONE";
> +		break;
> +	case BLK_ZONE_OPEN:
> +		ioctl_cmd = BLKOPENZONE;
> +		ioctl_name = "BLKOPENZONE";
> +		break;
> +	case BLK_ZONE_CLOSE:
> +		ioctl_cmd = BLKCLOSEZONE;
> +		ioctl_name = "BLKCLOSEZONE";
> +		break;
> +	case BLK_ZONE_FINISH:
> +		ioctl_cmd = BLKFINISHZONE;
> +		ioctl_name = "BLKFINISHZONE";
> +		break;
> +	case BLK_ZONE_NO_ACTION:
> +		/* fallthrough */
> +	default:
> +		errx(EXIT_FAILURE, _("Invalid zone action"));
  
but you can use ctl->command.ioclt_cmd  etc.

Just idea :-)

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

