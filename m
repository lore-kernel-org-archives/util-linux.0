Return-Path: <SRS0=LCHA=5K=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A19AC1975A
	for <util-linux@archiver.kernel.org>; Wed, 25 Mar 2020 16:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E735420772
	for <util-linux@archiver.kernel.org>; Wed, 25 Mar 2020 16:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+uypo2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCYQ5H (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:57:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48919 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgCYQ5H (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 25 Mar 2020 12:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585155426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1oelcMwp3UqmIiPeFzaBrjn8n5bS9g9btsH1xBLmuoE=;
        b=I+uypo2zN8+Z/4m/Z2VzDtwEi2KXHuYprhxfsrxeh6dO3cPcqzw25l6FT8R4TX8vCvJkE/
        NsE7CviuHX5aEesjSOrL5/wg4TGhxXCxN1iGysFTqEWtxt6wnVlYusf0xljQctDKu4LrmZ
        lHzhcRZWCyEgKJwwFrnFgD17yKI4NLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-a-BAdYGDPGyRFGVrWQpeHw-1; Wed, 25 Mar 2020 12:57:02 -0400
X-MC-Unique: a-BAdYGDPGyRFGVrWQpeHw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E27D2801E53;
        Wed, 25 Mar 2020 16:57:00 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79F05196AE;
        Wed, 25 Mar 2020 16:56:59 +0000 (UTC)
Date:   Wed, 25 Mar 2020 17:56:56 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Benno Schulenberg <bensberg@justemail.net>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH v2] blkzone: add open/close/finish commands
Message-ID: <20200325165656.ohypo52rj5zlgiqx@ws.net.home>
References: <20200324100217.47549-1-damien.lemoal@wdc.com>
 <20200325113604.j7qlb7zdzm2azxjm@ws.net.home>
 <CO2PR04MB2343A0A15DAB638F4989CA22E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO2PR04MB2343A0A15DAB638F4989CA22E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 25, 2020 at 03:12:04PM +0000, Damien Le Moal wrote:
> I just sent a V3 of the full patch with this cleanup.
> Did you prefer an incremental change ?
> (I did not see that you said you applied v2 above... Thanks !)

No problem, I'll generate the diff locally. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

