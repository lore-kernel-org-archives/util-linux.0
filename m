Return-Path: <SRS0=Bpzm=QL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A136DC282C4
	for <util-linux@archiver.kernel.org>; Mon,  4 Feb 2019 13:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA922082F
	for <util-linux@archiver.kernel.org>; Mon,  4 Feb 2019 13:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfBDN0E (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:26:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbfBDN0E (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 4 Feb 2019 08:26:04 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5ACE380F90;
        Mon,  4 Feb 2019 13:26:03 +0000 (UTC)
Received: from ws.net.home (ovpn-117-196.ams2.redhat.com [10.36.117.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FAC110021B1;
        Mon,  4 Feb 2019 13:26:02 +0000 (UTC)
Date:   Mon, 4 Feb 2019 14:25:59 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Nuno Silva <nunojsilva@ist.utl.pt>
Cc:     util-linux@vger.kernel.org
Subject: Re: cal: lack of color support disables "standout mode"
Message-ID: <20190204132559.h3udu2h4kqzck7br@ws.net.home>
References: <q29ap5$86n0$1@ciao.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q29ap5$86n0$1@ciao.gmane.org>
User-Agent: NeoMutt/20180716-1023-ca4e12
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 04 Feb 2019 13:26:03 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Jan 23, 2019 at 09:05:41AM +0000, Nuno Silva wrote:
> The cal utility seems to check for color support in the current $TERM in
> order to turn standout mode on or off. This means that, in a monochrome
> terminal, the current/requested day is not highlighted, even if the
> terminal has standout mode defined.

Fixed. Thanks for your report.

> While I can force this with --color=always, I'd say it's slightly
> confusing that the highlighting is controlled by --color=. If this
> behaviour is kept, perhaps the man page could say something about this?

The idea has been to colorize another things too (week days, weekend,
...), but it has never been implemented :-)

The option name is the same as we use in another utils for this
purpose. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
